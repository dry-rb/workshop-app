require "blog/operation"
require "dry-validation"
require "json"

DB = []

FEED_RESPONSES = {
  "http://example.com/valid.json" => <<-JSON,
  [
    {"title": "Example article"},
    {"title": "Another article"}
  ]
  JSON
  "http://example.com/invalid.json" => <<-JSON,
  [
    {"title": "Example article"},
    {"body": "This is missing a title"}
  ]
  JSON
}

class DownloadFeed < Blog::Operation
  def call(feed_url)
    response = FEED_RESPONSES[feed_url]

    if response
      Right(JSON.parse(response))
    else
      Left(:error)
    end
  end
end

ImportedArticleSchema = Dry::Validation.JSON do
  required(:title).filled
end

class ImportArticles < Blog::Operation
  attr_reader :article_repo, :download_feed

  def initialize(article_repo:, download_feed:)
    @article_repo = article_repo
    @download_feed = download_feed
  end

  def call(feed_url)
    download_feed.(feed_url).bind { |articles|
      validations = articles.map { |article|
        ImportedArticleSchema.(article)
      }

      if validations.all?(&:success?)
        imported_articles = validations.map { |article|
          article_repo.create(article.to_h)
        }

        Right(imported_articles)
      else
        Left(validations)
      end
    }
  end
end

class ArticleRepo
  def create(attrs)
    DB << attrs
    attrs
  end
end

RSpec.describe "Thinking and working with functional objects" do
  before do
    DB.clear
  end

  subject(:import_articles) {
    ImportArticles.new(article_repo: article_repo, download_feed: download_feed)
  }

  let(:article_repo) { ArticleRepo.new }
  let(:download_feed) { DownloadFeed.new }

  it "imports articles and populates the DB" do
    result = import_articles.("http://example.com/valid.json")

    expect(result).to be_success
    expect(DB.length).to eq 2
    expect(DB.first[:title]).to eq "Example article"
  end

  it "returns an error if the download failed" do
    result = import_articles.("http://example.com/error.json")

    expect(result).to be_failure
    expect(DB).to be_empty
  end

  it "returns validation errors if any feed article is invalid" do
    result = import_articles.("http://example.com/invalid.json")

    expect(result).to be_failure
    expect(DB).to be_empty
    expect(result.value.first).to be_a Dry::Validation::Result
  end
end

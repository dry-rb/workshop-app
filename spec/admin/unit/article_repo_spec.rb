require "db_spec_helper"
require "blog/admin/article_repo"

RSpec.describe Blog::Admin::ArticleRepo do
  subject(:repo) { described_class.new }

  describe "#create" do
    it "creates an article" do
      author = Factory[:author]
      article = repo.create(title: "Test article", status: "draft", author_id: author.id)

      expect(article.title).to eq "Test article"
      expect(article.id).to be_an Integer
    end
  end

  describe "#by_id" do
    let!(:article) { Factory[:article, title: "My article"] }

    it "returns an article by ID" do
      result = repo.by_id(article.id)

      expect(result.title).to eq "My article"
      expect(result).to be_a Blog::Admin::Entities::Article
    end
  end

  describe "#listing" do
    let!(:author) { Factory[:author, name: "Jane Doe"] }
    let!(:article_draft) { Factory[:draft_article, title: "My draft", author_id: author.id] }
    let!(:article_published) { Factory[:published_article, title: "My article", author_id: author.id] }

    it "returns all articles in created_at descending order" do
      articles = repo.listing.to_a

      expect(articles.length).to eq 2
      expect(articles[0]).to be_a Blog::Admin::Entities::Article
      expect(articles[0].title).to eq "My article"
      expect(articles[1].title).to eq "My draft"
    end

    it "aggregates author with each article" do
      articles = repo.listing.to_a

      expect(articles.first.author.name).to eq "Jane Doe"
    end
  end
end

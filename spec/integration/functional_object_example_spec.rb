require "blog/operation"

DB = []

# Implement your example functional objects here.

class ImportArticles < Blog::Operation
  def call(feed_url)
  end
end

RSpec.describe "Thinking and working with functional objects" do
  before do
    DB.clear
  end

  subject(:import_articles) {
    # Create your object(s) here, e.g.
    #
    # ImportArticles.new(...)
  }

  it "imports articles and populates the DB" do
    # Call your object here, e.g.
    #
    # import_articles.("http://example.com/feed.json")

    expect(DB.length).to eq 2
    expect(DB.first[:title]).to eq "Example article"
  end
end

require "blog/entities/article"

RSpec.describe Blog::Entities::Article do
  subject(:article) { described_class.new(attributes) }

  let(:attributes) {
    {
      title: "First post",
      status: "published",
      published_at: Time.now,
    }
  }

  describe ".new" do
    it "initializes with valid attributes" do
      expect(article).to be_a Blog::Entities::Article
    end

    describe "title:" do
      it "expects a string" do
        expect {
          Blog::Entities::Article.new(attributes.merge(title: nil))
        }.to raise_error(Dry::Struct::Error)
      end
    end

    describe "status:" do
      it "expects a valid ArticleStatus" do
        expect {
          Blog::Entities::Article.new(attributes.merge(status: "zzz"))
        }.to raise_error(Dry::Struct::Error)
      end
    end

    describe "published_at:" do
      it "allows nil" do
        article = Blog::Entities::Article.new(attributes.merge(published_at: nil))

        expect(article).to be_a Blog::Entities::Article
        expect(article.published_at).to be_nil
      end
    end
  end
end

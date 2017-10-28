require "blog/admin/articles/create"

RSpec.describe Blog::Admin::Articles::Create, "#call" do
  subject(:create) { described_class.new(article_repo: repo) }

  let(:repo) { spy(:article_repo) }

  describe "valid input" do
    let(:input) {
      {
        "title" => "Hello world",
        "status" => "draft",
        "published_at" => nil,
      }
    }

    let(:article) { double(:article) }

    before do
      allow(repo).to receive(:create).and_return article
    end

    it "creates an article" do
      create.(input)
      expect(repo).to have_received(:create)
    end

    it "is a success" do
      expect(create.(input)).to be_success
    end

    it "returns the article" do
      expect(create.(input).value).to eq article
    end
  end

  describe "invalid input" do
    let(:input) {
      {"title" => ""}
    }

    it "does not create an article" do
      create.(input)
      expect(repo).not_to have_received(:create)
    end

    it "is a failure" do
      expect(create.(input)).to be_failure
    end

    it "returns failed validation result" do
      expect(create.(input).value).to be_a Dry::Validation::Result
    end
  end
end

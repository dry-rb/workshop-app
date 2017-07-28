require "admin/articles/create"

RSpec.describe Admin::Articles::Create, "#call" do
  subject(:create) { described_class.new(article_repo: repo) }

  let(:repo) { spy(:article_repo) }

  context "valid input" do
    let(:input) {
      {
        "title" => "Test article",
        "author_id" => "1",
        "status" => "published",
        "published_at" => "2017-07-28 09:00:00",
      }
    }

    it "creates the article" do
      create.(input)
      expect(repo).to have_received(:create).with(hash_including(title: "Test article"))
    end

    it "is a success" do
      expect(create.(input)).to be_success
    end
  end

  context "invalid input" do
    let(:input) { {"title" => ""} }

    it "is a failure" do
      expect(create.(input)).to be_failure
    end

    it "returns the validation result" do
      expect(create.(input).value).to be_a Dry::Validation::Result
      expect(create.(input).value.messages[:title]).to include "must be filled"
    end
  end
end

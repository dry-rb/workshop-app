require "types"

RSpec.describe "Types::ArticleStatus" do
  subject(:type) { Types::ArticleStatus }

  it "defaults to 'draft'" do
    expect(type[nil]).to eq "draft"
  end

  describe "allowed values" do
    specify "draft" do
      expect(type["draft"]).to eq "draft"
    end

    specify "published" do
      expect(type["published"]).to eq "published"
    end
  end

  it "disallows other string values" do
    expect { type["zzz"] }.to raise_error(Dry::Types::ConstraintError)
  end

  it "disallows non-string values" do
    expect { type[123] }.to raise_error(Dry::Types::ConstraintError)
  end
end

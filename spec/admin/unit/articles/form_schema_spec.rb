require "blog/admin/articles/form_schema"

RSpec.describe "Blog::Admin::Articles::FormSchema" do
  subject(:schema) { Blog::Admin::Articles::FormSchema }

  let(:attributes) {
    {
      title: "First post",
      status: "published",
      published_at: "2017-07-28 09:00:00",
    }
  }

  it "accepts valid attributes" do
    expect(schema.(attributes)).to be_success
  end

  describe "attributes" do
    describe "title" do
      it "rejects blank strings" do
        result = schema.(attributes.merge(title: ""))
        expect(result).to be_failure
        expect(result.messages[:title].length).to eq 1
      end
    end

    describe "status" do
      it "accepts any ArticleStatus value" do
        expect(schema.(attributes.merge(status: "draft"))).to be_success
      end

      it "rejects any non-status value" do
        result = schema.(attributes.merge(status: "zzz"))
        expect(result).to be_failure
        expect(result.messages[:status].length).to eq 1
      end
    end

    describe "published_at" do
      it "rejects any non-time value" do
        result = schema.(attributes.merge(published_at: "today"))
        expect(result).to be_failure
        expect(result.messages[:published_at].length).to eq 1
      end

      it "accepts nil" do
        expect(schema.(attributes.merge(published_at: nil))).to be_success
      end
    end
  end
end

RSpec.shared_context "view" do
  let(:view_context_options) {
    {
      fullpath: "/",
      csrf_metatag: '<meta name="_csrf" content="___test_csrf_token___" />',
      csrf_tag: '<input type="hidden" name="_csrf" value="___test_csrf_token___" />',
      csrf_token: "___test_csrf_token___",
      flash: {},
    }
  }
end

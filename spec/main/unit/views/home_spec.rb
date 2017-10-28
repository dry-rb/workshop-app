require "db_spec_helper"
require "blog/main/views/home"
require "blog/main/view/context"

RSpec.describe Blog::Main::Views::Home, "#call", type: :view do
  subject(:view) { described_class.new }

  let(:html) { view.(context: Blog::Main::View::Context.new(view_context_options)) }
  let(:page) { Capybara.string(html) }

  before do
    Factory[:published_article, title: "My 1st article", created_at: TimeMath.week.decrease(Time.now, 2)]
    Factory[:published_article, title: "My 2nd article", created_at: TimeMath.week.decrease(Time.now, 1)]
  end

  it "renders the articles in date-descending order" do
    expect(page).to have_selector ".article:nth-of-type(1) h2", text: "My 2nd article"
    expect(page).to have_selector ".article:nth-of-type(2) h2", text: "My 1st article"
  end
end

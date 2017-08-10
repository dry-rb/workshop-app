class Main::Application
  route "articles" do |r|
    r.get ":id" do |article_id|
      r.view "articles.show", id: article_id
    end
  end
end

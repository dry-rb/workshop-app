class Admin::Application
  route "articles" do |r|
    r.is do
      r.get do
        r.view "articles.index"
      end

      r.post do
        r.resolve "articles.create" do |create_article|
          create_article.(r[:article]) do |m|
            m.success do
              r.redirect "/admin/articles"
            end

            m.failure do |validation|
              r.view "articles.new", validation: validation
            end
          end
        end
      end
    end

    r.get "new" do
      r.view "articles.new"
    end

    r.on ":article_id" do |article_id|
      r.on "edit" do
        r.view "articles.edit", id: article_id
      end

      r.post do
        r.resolve "articles.update" do |update_article|
          update_article.(article_id, r[:article]) do |m|
            m.success do
              r.redirect "/admin/articles"
            end

            m.failure do |validation|
              r.view "articles.edit", id: article_id, validation: validation
            end
          end
        end
      end
    end
  end
end

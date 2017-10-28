Factory.define :article do |f|
  f.title { fake(:lorem, :words, 5).join(" ") }
  f.association :author
  f.status "published"
  f.published_at { Time.now }
end

Factory.define(draft_article: :article) do |f|
  f.status "draft"
  f.published_at nil
end

Factory.define(published_article: :article) do |f|
end

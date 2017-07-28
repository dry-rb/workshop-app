require_relative "../spec/support/db/factory"

author = Factory[:author, name: "Jane Doe"]

_article = Factory[
  :article,
  title: "First post",
  author_id: author.id,
  status: "published",
  published_at: Time.now,
]

require "blog/repository"
require "admin/entities"

module Admin
  class AuthorRepo < Blog::Repository[:authors]
    relations :authors

    struct_namespace Entities

    def listing
      authors
    end
  end
end

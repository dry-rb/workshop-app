# auto_register: false

require "rom-repository"
require "blog/import"

module Blog
  class Repository < ROM::Repository::Root
    include Blog::Import.args["persistence.rom"]
  end
end

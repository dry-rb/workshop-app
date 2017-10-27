# auto_register: false

require "rom-repository"
require "blog/container"
require "blog/import"

module Blog
  class Repository < ROM::Repository::Root
    include Import.args["persistence.rom"]
  end
end

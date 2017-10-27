require_relative "blog/admin/container"

Blog::Admin::Container.finalize!

require "blog/admin/web"

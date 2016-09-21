require "yajl"
require_relative "extensions/custom_build"

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :custom_build
end

require "json"
require "securerandom"

class CustomBuild < Middleman::Extension
  def  initialize(app, options_hash = {}, &block)
    super
  end

  def after_build(builder)
    client = GitWand::GitHub::API::Client.new(username: ENV["GITHUB_USERNAME"], token: ENV["GITHUB_TOKEN"])
    uuid = SecureRandom.uuid
    owner = "olistik"
    repo = "api-test"
    path = "datasets/data.json"
    # from all external data sources (i.e. DatoCMS), faking:
    # 1. fetching
    # 2. merging
    # 3. checking the need for a Pull Request
    data = [
      {"id" => 1, "name" => "Donald Duck"},
      {"id" => 2, "name" => "Agent Smith", "movie" => "The Matrix"},
      {"id" => 3, "name" => "Clark Kent"},
    ]
    client.update_file(owner: owner, repo: repo, branch: "master", path: path, message: "Updating file #{path}", content: JSON.pretty_generate(data))
  end
end

::Middleman::Extensions.register(:custom_build, CustomBuild)

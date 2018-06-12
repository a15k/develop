require 'net/http'
require 'json'

class ClientFinder

  attr_reader :data

  def initialize(repo_name)
    @repo_name = repo_name

    tree_url = "https://api.github.com/repos/a15k/#{repo_name}/git/trees/master?recursive=1"
    tree_response = Net::HTTP.get(URI(tree_url))
    tree = JSON.parse(tree_response)

    @data = {}

    tree["tree"].each do |entry|
      if entry["path"].match(/clients\/([\d\.]+)\/([\w\-]+)$/)
        @data[$2] ||= []
        @data[$2].push($1)
        @data[$2].sort!
      end
    end
  end
end

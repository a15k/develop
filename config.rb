require "lib/webpack_asset_helpers"
require "lib/client_finder"

helpers do
  def highlightjs(content:, klass: nil)
    content = CGI::escapeHTML(content) if klass == 'html'
    <<-MARKUP
      <pre><code #{'class=' + klass if !klass.nil?}>#{content}</code></pre>
    MARKUP
  end
end

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :directory_indexes

helpers WebpackAssetHelper

if ARGV.include?("s3_sync") && (ENV['AWS_ACCESS_KEY_ID'].nil? || ENV['AWS_SECRET_ACCESS_KEY'].nil?)
  raise "AWS credentials not set"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'develop.a15k.org'
  s3_sync.region                     = 'us-east-2'
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404'
end

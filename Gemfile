source 'https://rubygems.org'

# only use the stuff we need, not everything that Rails depends on
rails_version = '4.2.4'
gem 'actionpack',    "= #{rails_version}"
gem 'actionview',    "= #{rails_version}"
gem 'activesupport', "= #{rails_version}"
gem 'railties',      "= #{rails_version}"
gem 'bundler',       '>= 1.3.0', '< 2.0'
gem 'sprockets-rails'

# server
gem 'puma'

# javascript
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'

# views
gem 'compass', '1.0.1'
gem 'sass-rails', '~> 5.0'
gem 'haml',   '4.0.5'
gem 'redcarpet'

# client to portal
gem 'jsl-today_json', path: '../today_json'

# dev / test
group :development, :test do
  gem 'pry'
end

# dev
group :development do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end

# test
group :test do
  gem 'mrspec'
  gem 'rspec-rails'
  gem 'rack-test'
end

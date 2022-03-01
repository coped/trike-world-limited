source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'dotenv-rails', groups: [:development, :test]
gem 'rails',             '~> 6.0.0'
gem "puma",              '>= 3.12.3'
gem 'sass-rails',        '~> 6.0'
gem 'webpacker',         '~> 4.0'
gem 'turbolinks',        '~> 5'
gem 'jbuilder',          '~> 2.7'
gem 'bootsnap',          '>= 1.4.2', require: false
gem 'bulma-rails',       '~> 0.7.5'
gem 'sitemap_generator', '~> 6.0', '>= 6.0.2'
gem 'bcrypt',            '~> 3.1', '>= 3.1.13'
gem 'pg',                '~> 1.1', '>= 1.1.4'
gem "aws-sdk-s3",        require: false
gem 'image_processing',  '~> 1.12'
gem 'will_paginate',     '~> 3.2', '>= 3.2.1'
gem "nokogiri",          '>= 1.10.8'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console',           '>= 3.3.0'
  gem 'listen',                '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
  gem 'capybara',                 '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'mini_magick', '~> 4.11'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass'

group :test do
  gem 'shoulda-matchers', '~> 4.0'
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'database_cleaner', '~> 2.0.1'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'rubocop', '~> 1.17.0'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'bundler-audit', '~> 0.8.0'
  gem 'brakeman', '~> 5.1.1'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

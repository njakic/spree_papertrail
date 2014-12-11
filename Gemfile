source 'https://rubygems.org'

gem 'spree', git: 'https://github.com/spree/spree.git', branch: '2-3-stable'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', git: 'https://github.com/spree/spree_auth_devise.git', branch: '2-3-stable'

gemspec

group :development, :test do
  gem 'pry'

  # Pretty print your Ruby objects with style -- in full color and with proper indentation
  gem 'awesome_print'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
end

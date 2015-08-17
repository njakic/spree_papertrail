source 'https://rubygems.org'

# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-3-stable'

gemspec

group :development, :test do
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller'

  # Pretty print your Ruby objects with style -- in full color and with proper indentation
  gem 'awesome_print'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
end

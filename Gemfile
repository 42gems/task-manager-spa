source 'https://rubygems.org'

ruby '2.1.3'
gem 'rails', '4.1.4'
gem 'pg'
gem 'thin'
gem 'devise'
gem 'bcrypt', require: 'bcrypt'
gem 'aasm'
gem 'inherited_resources'
gem 'rabl'
gem 'carrierwave'
gem 'cloudinary'

# front end
gem 'haml'
gem 'haml-rails'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'angular-rails-templates'
gem 'angularjs-rails-resource', '~> 1.1.1'
gem 'bootstrap-sass', '~> 3.2.0'
gem "font-awesome-rails"

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# heroku
gem 'rails_12factor',  group: :production

group :development do
  gem 'spring'
  gem 'quiet_assets'
  gem 'letter_opener'
  gem "pry-rails"
  gem 'pry-byebug'
  gem 'awesome_print'

  #guards for watching files changes and
  gem 'guard-bundler' #bundle on gemfile changed
  gem 'guard-rails' #run rails on config changes
  gem 'guard-livereload', require: false #reload browser on assets change, to correct work need to install live reload plug for browser
end

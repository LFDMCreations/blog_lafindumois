# LafindumoisBlog

These are the steps to follow to create  the blog API that will securely serve a front-end application. This app uses the [Sinatra](https://sinatrarb.com/intro.html) framework. 

To the contrary of [Ruby on rails](https://rubyonrails.org/) and [Hanami](https://hanamirb.org/), Sinatra is not opiniated, namely in terms of file structure and configuration.

This means that we'll put our own file structure and configuration in place. 

**This readme file seems rather complete, but it isn't! All gems have extensive documentation.**

**Importantly, we will build a modular Sinatra app, not a classical style app. Read the Sinatra docs on the difference between the two. We use a modular app for ease of testing and extending modules.**

## Use Sinatra

Create an empty folder

```
❯ mkdir hi_blog
❯ cd hi_blog
```

### Create the app

Start with :

```
❯ bundle init
Writing new Gemfile to /Users/moi/Code/Ruby/hi_blog/Gemfile
❯ bundle add sinatra
```

You should now have a Gemfile in with 2 lines in it. You can now add the webserver, `puma` with

```
❯ bundle add puma
```

### Ruby gems

Obviously, this app, like all ruby apps, uses many gems. In order to get the last version of each gem, make sure to go to [rubygems](https://rubygems.org/), check the gem out, read the documentation or at least the introduction to the documentation. 


## Use RSpec

Following best practices of Behavious Driven Development, or: BDD, add [RSpec](https://rspec.info/). 

If you're unfamiliar with RSpec, read the book **Effective Testing with RSpec 3: Build Ruby Apps with Confidence**. You can get it [here](https://pragprog.com/titles/rspec3/effective-testing-with-rspec-3/). Getting familiar with RSpec might take some time and effort, but it's more than worth it!

Adding rspec is easy `bundle add rspec` and `bundle add rack-test` but this time, you need to open the Gemfile and put RSpec and rack-test in the group `test`. 

### Configure RSpec

First run :
```
> rspec --init
```

This creates a file `.rspec` and a folder `spec` containing one file: `spec_helper.rb`. This is a configuration file. Since we'll use feature specs (for models) and requests specs (for routes), let's import the hanami-way of configuring rspec. Please see the `./spec` folder in this repository.


### First spec

Create, `spec/requests/root_spec.rb` as per the file in the folder. 

```
require 'rack/test'
require 'json'
require_relative '../../app/main.rb'
module LafindumoisBlog
    RSpec.describe 'Lafindumois blog api', type: :request do
        it 'says hi!' do
            get '/'
            expect(last_response.status).to eq(200)
            expect(last_response).to be_successful
        end
    end
end

```

If you run this spec, it will fail.

```
❯ bundle exec rspec spec/requests/root_spec.rb
```

This is logical we haven't even created the `app` folder and `main.rb` therein. Please do that now. Run the spec again and see it fail for other reasons. 

If you put the following lines in `main.rb` the spec should pass:

```
require 'sinatra/base'
module LafindumoisBlog    
  class API < Sinatra::Base
    get '/' do
      retour = "bonjour Lafindumois"
      status 201
    end  
  end
end
```

## Make this a bootable app

It is perfectly fine to have a `app/main.rb` file like this :

```
require 'sinatra/base'
module HiBlog
  class API < Sinatra::Base
    get '/' do
      "bonjour HiBlog"
    end
    run! if app_file == $0
  end
end
```

and run this with 

```
❯ ruby app/main.rb
```

But we prefer to use `rackup`. 

Therefore, 
1. delete the line `run! if app_file == $0`  from `main.rb` and
2. create a file `config.ru` at root containing:

```
require './app/main'
run HiBlog::API
```
and boot the app with

```
❯ rackup
```


## Made code reload 

With code reload, we don't have to reboot the server each time we change a word of code, add this to the `Gemfile`:

```
group :test, :development do
    gem 'rack-unreloader', '~> 2.1'
end
```

Please read the documentation for rack-unreloader and change `config.ru` to 

```
require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(:subclasses=>%w'HiBlog'){HiBlog::API}
Unreloader.require './app/main.rb'
run Unreloader
```

Happy coding and see code implemented immediately without rebooting the app. 

## Add racksh

[Racksh](https://www.rubydoc.info/gems/racksh/1.0.1) is a console for rack based applications and it is extremely practical for introspection (according to the docs), i.e., see what your app is doing from the console, without starting the server and checking the browers or echoing constants and variables. 

Create a development section in the `Gemfile`, add `gem 'racksh', '~> 1.0', '>= 1.0.1'` and run bundle install. 

## What are we building? 

Our app allows authors to write articles. Articles contain images and people may add comments to articles. The app also needs an administrator who can see all the authors and articles and can administer the application for all authors and moderate articles and comments. 

These plain English lines contain the database structure and models the app will be using. 

### Add persistence

#### Add the required gems

We will use the excellent [Sequel](https://sequel.jeremyevans.net/) for managing models, connexions to the database and persistence more generally.

We must add a few gems to the Gemfile. This time, rather than using the command `bundle add [gem]`, we open the Gemfile and get things organised a bit since the command `bundle add...` appends the gem to the Gemfile that ends up being messy this way. Let's to this manually.

Add these gems to the Gemfile:

```
gem "sequel", "~> 5.77"
gem "pg"
```

and in `group :test` add `gem "database_cleaner-sequel"`. 

Run `bundle install` 

#### Add and alter files and environment variables



1. Create a folder `./config` with 3 files : `config.rb`, `database.yml` and `persistence.rb`. 
My `database.yml` is in `./gitignore` therefore not visible. It is structured like this:
```
development:
  adapter: postgresql
  encoding: unicode
  database: lafindumois_blog_development
  username: my_username
  password: my_password
```

:bulb: _There is no `production` section in `database.yml` as the uri in production is an environment variable on the production server. Please see `persistence.rb` for that._ 

2. require config.rb in `config.ru` by adding this in the beginning of that file: `require_relative './config/config'`.
3. Let's make sure that our app is correctly picking up the database connexion. For that 

2. Update `config/settings.rb` 
3. Add the database_cleaner in `spec/support/database_cleaner.rb` and update `spec/spec_helper.rb`. 
4. Enable migrations by appending code to the `Rakefile`.
5. One `.env` file already exists. create a `.env.test` file at root and add it to `.gitignore`. 

Add the database urls to .env and to .env.test. The syntax for the url is structured like this :

DATABASE_URL=postgres://username:password@localhost:5432/lafindumois_blog_development.

A password is not required. Therefore, this is valid syntax:
DATABASE_URL=postgres://username@localhost:5432/lafindumois_blog_development.

Obviously, the database url in the `./.env.test` file is postfixed `_test`, not `_development`.
**The documentation shows how to run the hanami console and make sure that the app correctly reads the url. Do that.**

### Create databases, create migrations and run migrations. 

With all this in place, we can start creating our migrations. The steps are:

1. Create the databases
2. Add citext to the databases
3. Create the migration files
4. Fill in the migration files
5. Run the migration
6. Add the ROM relation


#### Create the databases ####

Easy. Connect to postgresql with `psql` and 
```
username=# CREATE DATABASE lafindumois_blog_development;
username=# CREATE DATABASE lafindumois_blog_test;
```

#### Add citext to the databases ####

By personnal preference, I put constraints at database level. The migration create_authors checks for validity of emails through a regular expression. Postgresql uses the citext extension, which is not implemented by default. Connect to the databases with psql and add citext extension to both the development and the test databases with :
```
CREATE EXTENSION IF NOT EXISTS citext;
```

#### Create the migration files ####

A folder `/db/migrate` is created at root upon creation of the fist migration with:
```
> bundle exec rake db:create_migration\[create_authors\]
> bundle exec rake db:create_migration\[create_administrators\]
> bundle exec rake db:create_migration\[create_aricles\]
> bundle exec rake db:create_migration\[create_messages\]
```
I use .zsh and therefore I need to escape the square brackets. 

#### Fill in the migration files ####

Migrations are executed in the order they come. Therefore, an error occurs and the migration is (partially) aborted when calling a `foreign_key` in a `create_table` function, referencing a table that is created in a subsequent `create_table` function. See the file `./db/migrate/20240131203603_create_authors.rb` for an example of this. Likewise, the lines of code that create join tables must be placed after the code that creates each table.

Create all migrations. Be as complete as you can be. Although migrations allow altering the database structure by adding or removing tables or columns, the migration files provide helpful information on the database structure. Therefor, readibility of those files is important.

#### Run the migrations ####

Run the migrations for the development environment and for the test environment with:

```
> bundle exec rake db:migrate 
> HANAMI_ENV=test bundle exec rake db:migrate
```

#### Add the ROM relations ####

A final step: create the [ROM relations](https://rom-rb.org/learn/core/5.2/relations/).

In `./lib/lafindumois_blog/persistence/relations` create the 4 files for the 4 relations that we'll be using. 

**Wow !! That was quite a bit of work already! Looking forward to Hanami 2.1 that ships with persistence.**


## Add a first author ##

### Start with the spec, ... ###

Create a file in `./spec/requests/authors/index_spec.rb`. If you run the spec, it fails:

```
> bundle exec rspec spec/requests/authors/index_spec.rb
```

Obviously, understand every line of the spec, namely the memoization `let(:authors) { app["persistence.rom"].relations[:authors] }` and the `before hook`.

### ... and then continue with the action. ###

To make it pass, first add the route and the action with:
```
bundle exec hanami generate action authors.index --skip-view --url=/authors/all --http=get
```

As previously, this creates the route and action. See ` app/actions/authors/index.rb` and the Hanami guide to make the test pass. 

If you check in the database with psql, you'll see that it is empty, thanks to database_cleaner and the around hook that it contains. After the test, the database is truncated.

**Don't move to the next step as long as this test fails**



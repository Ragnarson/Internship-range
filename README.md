Internship-Range [![Build Status](https://secure.travis-ci.org/gotar/Internship-range.png?branch=master)](http://travis-ci.org/gotar/Internship-range)
================

### Usage

#### PostgreSQL setup

Following description assumes that you have installed and running PostgreSQL server. Its installation procedure may vary depending on your operating system and it's not mentioned here.

Connect to database using your Superuser role (ex. 'postgres')

```bash
  $ psql -U postgres
```

Using SQL query create user and setup password

```
  postgres=# CREATE USER range WITH PASSWORD 'range';
```

Create development database and assign its owner

```
  postgres=# CREATE DATABASE internship_development WITH OWNER range;
```

Create test database and assign its owner

```
  postgres=# CREATE DATABASE internship_test WITH OWNER range;
```

Rename file config/database.yml.example to database.yml.

Run migrations:

```bash
  $ rake db:migrate
```

Your database should already be configured. You're now ready to run application.

#### User creating

If you want to sign in to application first you must have working database connection based on PostgreSQL and create user through console:

```ruby
  User.create(email: "your_email", password: "your_password", password_confirmation: "your_password")
```

#### Secret Token

1. `$ rake secret`

2. Rename file .env.example to .env and enter your Secret Token

### Guard-rspec

To use guard for your development workflow open new terminal and use this command in app directory

```bash
  $ bundle exec guard
```

Everytime you save a file guard will automatically launch proper specs when files are modified. [More info](https://github.com/guard/guard-rspec)

### Before you make a commit

1. Ask yourself: am I done? Is this commit a complete cohesive unit of work that can be tested by the end-user? Avoid making commits that add only a part of the functionality, e.g. only the model. Try to do less work, but make it span all levels of the application, i.e. make a real user-facing functionality. If you're not done, get back to code and commit later.

2. Run `bundle install` if you have changed Gemfile. Include updated Gemfile.lock in your commit: `git add Gemfile.lock`.

3. Run `rake db:migrate` if you have added a migration. Include updated schema.rb in your commit: `git add db/schema.rb`.

4. Make sure `git status` shows no unstaged changes, i.e. there should be no "Changes not staged for commit:" nor "Untracked files:" in the output. If there are, either `git add` them or remove them.

5. Run the tests to make sure your change didn't break anything: `bundle exec rspec`. If it did, fix it and go to step 4 again.

6. Review your own change: `git diff --cached`. Make sure everything looks as you intended. This diff is what will be reviewed later by senior developers. If you have to fix something, do it and go to step 4 again.

7. When reviewing take note if there are tests included. In particular, if you've changed (or added) a controller, view or helper, you need to change (or add) a functional test. If you've changed (or added) a model or mailer, you need to change (or add) a unit test. If the tests are missing, write them and go back to step 4.

8. Finally, commit your change, describing in the commit message the reason why it was made. Try to include information that is not clearly visible in the code.

### Lecturers

1. [Testowanie #1](http://www.youtube.com/watch?v=LnhEasE646s)
2. [Testowanie #2](https://www.youtube.com/watch?v=im84JwpYVqs)
3. [Testowanie #3](http://youtu.be/8N4LjsAEFJA)
4. [Bazy danych](http://youtu.be/8yMlE6j_dWw)
5. [Sprint #3](http://youtu.be/3WlpoaMnpEc)
6. [Standup meeting](http://youtu.be/1D1iOZajEuc)
7. [Standup meeting](http://youtu.be/cV-gEbxas_4)
8. [Summary](http://youtu.be/pdR4JRWWpcE)

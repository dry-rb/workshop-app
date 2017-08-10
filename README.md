# dry-rb/rom-rb workshop app

This is the companion app for 2017's series of [dry-rb](http://dry-rb.org/) and [rom-rb](http://rom-rb.org/) workshops conducted by [Tim Riley](https://github.com/timriley).

Follow the instructions and complete the exercises below to get to know dry-rb and rom-rb, and eventually put together a complete, working app.

## Requirements

- git 1.7.0 or newer
- A recent version of Ruby (2.3.x or 2.4.x)
- PostgreSQL

## First steps

Clone this repository:

```sh
$ git clone https://github.com/dry-rb/workshop-app
```

Set up the app:

```sh
$ ./bin/setup
```

Run the app:

```
$ bundle exec shotgun -p 3000 -o 0.0.0.0 config.ru
```

Then browse the app at [localhost:3000](http://localhost:3000).

# Exercises

Each exercise topic focuses on a specific area of the dry-rb/rom-rb stack, and is intended to follow an introduction to the topic as part of the workshop.

## ✏️ Types & validation

Merge the starter code:

```sh
$ git merge --no-edit -s recursive -X theirs 1-types-validation
```

Run the specs:

```sh
$ bundle exec rspec
```

There should be failures for examples in the following files:

```
./spec/unit/types/article_status_spec.rb
./spec/unit/entities/article_spec.rb
./spec/admin/unit/articles/form_schema_spec.rb
```

### Types

- [ ] Make a strict string enum type called `ArticleStatus`

### Structs

- [ ] Make an `Article` struct class with the following atributes
  - `title` (strict string)
  - `status` (`ArticleStatus`)
  - `published_at` (optional strict time)

### Validation

- [ ] Update `Admin::Articles::FormSchema` to validate input to match the `Article` struct attributes
- [ ] Add a high-level rule to validate that `published_at` is filled only when `status` is set to "published"

After completing these exercises, re-run the specs and ensure they're all passing.

### In practice

- Think of some examples of where and how these would have helped in your own applications:
  - [ ] Types
  - [ ] Typed structs or value objects
  - [ ] Standalone validation schemas

### Further exploration

#### Types

- [ ] Type with default
- [ ] Constrained type using predicates
- [ ] Type with custom constructor

#### Validation

- [ ] Use a custom predicate (with custom error message)
- [ ] Write a schema for nested data
- [ ] Write a high-level validation block

## ✏️ Functional objects

Merge the starter code and run the specs:

```sh
$ git merge --no-edit -s recursive -X theirs 2-functional-objects
$ bundle exec rspec
```

There should be failures for examples in this file:

```
./spec/integration/functional_object_example_spec.rb
```

Open up this file and take a look at it. It contains implementation code at the top with RSpec examples below. This will be a self-contained "playground" for thinking about and working with functional objects.

Imagine we're building a feature for a blog that imports articles from a 3rd-party feed. Your exercise:

- [ ] Consider how this might be broken apart into multiple functional objects
- [ ] Write code for the `ImportArticles` class that uses these other objects to do its work and populate the `DB` with articles (these can be example data that you hard-code into your classes).

### In practice

- [ ] Think of how something you've written before could be modelled as functional objects
- [ ] Think of something you've written that would have been better broken up into smaller units of responsibility

### Further exploration

- [ ] For the functional objects you arranged above, write unit tests for each one

## ️✏️ Containers & systems

Merge the starter code:

```sh
$ git merge --no-edit -s recursive -X theirs 3-containers-systems
```

- [ ] Inspect the `Admin::Container` container
  - [ ] Inspect its `.keys`
  - [ ] Resolve an `articles.create` object from the container
  - [ ] Update it to auto-inject an "article_repo" dependency
  - [ ] Call the object with valid/invalid attributes
- [ ] Inspect the behavior of a non-finalized container
  - [ ] Comment out the code that finalizes the container
  - [ ] Inspect the container's `.keys`
  - [ ] Initialize an `Admin::Articles::Create` object directly
  - [ ] Inspect the container's `.keys` again

### Further exploration

- [ ] Take your functional objects from the previous exercise and make them work with auto-injection within this app
- [ ] Update the tests to match
- [ ] Use dry-transaction to combine the `ImportArticles` operation with another operation to deliver an email notification once the import completes
- [ ] Add a bootable component (in `system/boot`) to configure the email notifier with recipient email addresses

## ️✏️ Persistence with rom-rb

Merge the starter code:

```sh
$ git merge --no-edit -s recursive -X theirs 4-persistence
```

Migrate the database:

```sh
$ bundle exec rake db:migrate
$ RACK_ENV=test bundle exec rake db:migrate
```

Run the specs:

```sh
$ bundle exec rspec
```

There should be failures for examples in this file:

```
./spec/admin/unit/article_repo_spec.rb
```

### Getting acquainted

Inspect the basic setup:

- [ ] Bootable component in `system/boot/persistence.rb`
- [ ] Migrations in `db/migrate`
- [ ] Relations in `lib/persistence/relations`
- [ ] Test factories in `spec/factories`
- [ ] Article repo at `apps/admin/lib/admin/article_repo.rb`

### Reading data

- [ ] Define an "author" association on articles
  - [ ] Specify a `belongs_to :author` association in articles relation
  - [ ] Update `spec/factories/articles.rb` to include this association
- [ ] Add `#by_pk` to repo for reading individual records
- [ ] Add `#listing` to repo for reading lists of articles
  - [ ] Order articles by created_at time descending
  - [ ] Aggregate articles with their author

### Writing data

- [ ] Enable `create` command on repo
- [ ] Enable `update` command on repo using `by_pk` restriction
- [ ] Test writing/reading/updating article records from the console

### Refactoring

- [ ] Return results as custom structs via a custom struct namespace
- [ ] Move lower-level query methods into relation
- [ ] Create shared method in repository to ensure all results return

### Further exploration

- [ ] Return results as wrapped in custom classes via `.as`
- [ ] Investigate using dry-struct to build custom struct classes with strict attribute types
- [ ] Build and use a custom changeset to transform data before writing

## ️✏️ Views & routes

Merge the starter code and run the specs:

```sh
$ git merge --no-edit -s recursive -X theirs 5-routes-views
$ bundle exec rspec
```

There should be failures for examples in this file:

```
./spec/main/unit/views/home_spec.rb
```

- [ ] Set up the `Main::Views::Home` view controller:
  - [ ] Configure it to render using a template named `home`
  - [ ] Inject an `article_repo` dependency
  - [ ] Add an `articles` exposure returning `article_repo.listing`
- [ ] Add the `#listing` method to `Main::ArticleRepo` (return published articles only, ordered by `published_at` descending)
- [ ] Fill in `web/templates/home.html.slim` template so it displays each article
- [ ] Test your work by running the app and viewing it in the browser

## ️✏️ Next steps

This is just the beginning of working app. We can do more!

- Add individual article pages to the public area
  - `articles/:id`
- Add article management to the admin area:
  - `admin/articles`
  - `admin/articles/new`
  - `admin/articles/:id/edit`
- Add user authentication to the admin area

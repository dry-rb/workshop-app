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

If you need to catch up, merge the completed work:

```sh
$ git merge --no-edit -s recursive -X theirs 1-types-validation-completed
```

## ✏️ Functional objects & systems

Merge the starter code and run the specs:

```sh
$ git merge --no-edit -s recursive -X theirs 2-functional-objects-and-systems
$ bundle exec rspec
```

There should be failures for examples in this file:

```
./spec/admin/unit/articles/create_spec.rb
```

### Building a functional object

- [ ] Create a functional operation class for creating an article, in `apps/admin/lib/blog/admin/articles/create.rb`
- [ ] Define a `#call` method accepting article params
- [ ] Use the `FormSchema` we already created to validate these params
- [ ] Create a dummy article repository class (with a `#create` method) at `apps/admin/lib/blog/admin/article_repo.rb`
- [ ] Inject the article_repo into the `Articles::Create` functional object
- [ ] When article params are valid, create an article using the repo and return it wrapped in a `Right`
- [ ] When article params are invalid, return the validation result wrapped in a `Left`

### Inspecting the system

- Inspect the `Blog::Admin::Container` system container
  - [ ] Open the console and inspect its `.keys`
  - [ ] Resolve an `articles.create` object from the container
  - [ ] Call the object with valid/invalid attributes to inspect its output
- Inspect the behavior of a non-finalized container
  - [ ] Comment out the code that finalizes the container (in `apps/admin/system/boot.rb`)
  - [ ] Open the console and inspect the container's `.keys`
  - [ ] Count the number of loaded Ruby source files (via `$LOADED_FEATURES.grep(/workshop-app/).count`)
  - [ ] Initialize an `Admin::Articles::Create` object directly
  - [ ] Inspect the container's `.keys` again
  - [ ] Count the number of loaded Ruby source files again (via `$LOADED_FEATURES.grep(/workshop-app/).count`)

### In practice

- [ ] Think of how something you've written before could be modelled as functional objects
- [ ] Think of something you've written that would have been better broken up into smaller units of responsibility

If you need to catch up, merge the completed work:

```sh
$ git merge --no-edit -s recursive -X theirs 2-functional-objects-and-systems-completed
```

## ️✏️ Persistence with rom-rb

Merge the starter code:

```sh
$ git merge --no-edit -s recursive -X theirs 3-persistence
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
- [ ] Articles repo at `apps/admin/lib/admin/persistence/articles_repo.rb`

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

If you need to catch up, merge the completed work:

```sh
$ git merge --no-edit -s recursive -X theirs 3-persistence-completed
```

## ️✏️ Views & routes

Merge the starter code and run the specs:

```sh
$ git merge --no-edit -s recursive -X theirs 4-routes-views
$ bundle exec rspec
```

There should be failures for examples in this file:

```
./spec/main/unit/views/home_spec.rb
```

- [ ] Set up the `Blog::Main::Views::Home` view controller:
  - [ ] Inject an `article_repo` dependency
  - [ ] Add an `articles` exposure returning `articles_repo.listing`
- [ ] Add the `#listing` method to `Blog::Main::ArticleRepo` (return published articles only, ordered by `published_at` descending)
- [ ] Fill in `web/templates/home.html.slim` template so it displays each article
- [ ] Test your work by running the app and viewing it in the browser

If you need to catch up, merge the completed work:

```sh
$ git merge --no-edit -s recursive -X theirs 4-routes-views-completed
```

## ️✏️ Next steps

This is just the beginning of working app. We can do more!

- Add individual article pages to the public area
  - `articles/:id`
- Add article management to the admin area:
  - `admin/articles`
  - `admin/articles/new`
  - `admin/articles/:id/edit`
- Add user authentication to the admin area

# Mongoid::Userstamps

Adds stamps relations to mongoid models.

## Version Support

`5.x, 6.x and 7.x`

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-simple-userstamps'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-simple-userstamps

## Usage

-   Include `Mongoid::Userstamps::Model` in your models you want user stamps.
-   Define current user throught `Mongoid::Userstamps::User.current`.

```ruby
  class User
    include Mongoid::Document
  end

  class Post
    include Mongoid::Document
    include Mongoid::Userstamps::Model

    field :title
  end

  user = User.create
  Mongoid::Userstamps::User.current = user

  post = Post.create
  post.created_by # <User _id: 1 >
  post.updated_by # nil

  post.update(title: 'title')
  post.updated_by # <User _id: 1 >

  # set manually
  other_user = User.create
  post.update(updated_by: other_user)
  post.updated_by # <User _id: 2 >

  # skip userstamps
  post.skip_userstamps.update(title: 'new_title')
  post.updated_by # <User _id: 2 >
```

## Preservation of Manually-set Values

* The `creator` is only set during the creation of new models (`before_create` callback).
Mongoid::Userstamps will not overwrite the `creator` field if it already contains a value
(i.e. was manually set.)

* The `updater` is set each time the model is updated (`before_update` callback).
Mongoid::Userstamps will not overwrite the `updater` field if it been modified since the last save,
as per Mongoid's built-in "dirty tracking" feature.

  > When the `updater` is the same and we need to preserve, we need to use `skip_userstamps` method.

### Rails

-   Define current user in your `application_controller.rb`

```ruby
  class ApplicationController < ActionController::Base
    before_action :authenticate!
    before_action :define_userstamps_current

    protected

    def define_userstamps_current
      Mongoid::Userstamps::User.current = current_user
    end
  end
```

### Warden

* Define current user in [warden callback](https://github.com/hassox/warden/wiki/Callbacks)

```ruby
Warden::Manager.after_set_user do |user, auth, opts|
  Mongoid::Userstamps::User.current = record
end
```

## Contributing

1.  Fork it (
    <http://github.com/><my-github-username>/mongoid-simple-userstamps/fork )
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create new Pull Request

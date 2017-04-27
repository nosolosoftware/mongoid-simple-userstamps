# Mongoid::Userstamps

Adds stamps relations to mongoid models.

## Version Support

| mongoid | mongoid-simple-userstamps |
| ------- | ------------------------- |
| 6.x     | 2.0                       |
| 5.x     | 1.2                       |

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-simple-userstamps'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-simple-userstamps

## Usage

* Include `Mongoid::Userstamps::User` in your 'User' model.
* Include `Mongoid::Userstamps::Model` in your models you want user stamps.
* Define current user.

```ruby
  class User
    include Mongoid::Document
    include Mongoid::Userstamps::User
  end

  class Post
    include Mongoid::Document
    include Mongoid::Userstamps::Model

    field :title
  end

  user = User.create
  Mongoid::Userstamps::Config.set_current(user)

  pòst = Post.create
  post.created_by # <User _id: 57305c268675c32e1c70a17e >
  post.updated_by # nil

  post.title = 'title'
  post.save
  post.updated_by # <User _id: 57305c268675c32e1c70a17e >
```

### Rails

* Define current user in your `application_controller.rb`

```ruby
  class ApplicationController < ActionController::Base
    before_action :authenticate!
    before_action :define_userstamps_current

    protected

    def define_userstamps_current
      Mongoid::Userstamps::Config.set_current(current_user)
    end
  end
```

### Warden

* Define current user in [warden callback](https://github.com/hassox/warden/wiki/Callbacks)

```ruby
Warden::Manager.after_set_user do |user, auth, opts|
  Mongoid::Userstamps::Config.set_current(record)
end
```

## Contributing

1. Fork it (
   http://github.com/<my-github-username>/mongoid-simple-userstamps/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

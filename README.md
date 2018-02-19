# i-am-me
Tiny gem to define `me` and `my` methods that works same as `current_user` method of [devise](https://github.com/plataformatec/devise).

## Getting started
Add this to your Gemfile:

```
gem 'i-am-me'
```

Add these lines to your controller so it looks like:

```
class UserController < ApplicationController

  # add these lines
  include IAmMe
  me_is_a :user # it must be the name of the devise user scope

end
```

## Usage

Let's say you want to get a list of books the user that is currently signed in have wrote, then you can write as below:

```
@books = Books.find_by(author: me)
# or
@books = my.books
```

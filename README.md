# RubyIdn

Wrapped idn command for Ruby.

## Requirements

- [libidn](http://www.gnu.org/software/libidn/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-idn'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install ruby-idn
```

## Usage

unicode to ascii

```ruby
require 'ruby_idn'

RubyIdn.to_ascii("ふー.com")

#=> "xn--19j6o.com"
```

ascii to unicode

```ruby
require 'ruby_idn'

RubyIdn.to_unicode("xn--19j6o.com")

#=> "ふー.com"
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


[![Build Status](https://www.travis-ci.org/mbehrendt/leipzig.rb.png?branch=master)](https://www.travis-ci.org/mbehrendt/leipzig.rb) [![Dependency Status](https://gemnasium.com/mbehrendt/leipzig.rb.png)](https://gemnasium.com/mbehrendt/leipzig.rb) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mbehrendt/leipzig.rb)

# Leipzig

Tiny client for [API Leipzig](http://www.apileipzig.de)

## Installation

Add this line to your application's Gemfile:

```bash
gem 'leipzig'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install leipzig
```

## Usage

Simply create a new instance of the client using your api key and call one of the `find` methods:

```ruby
require 'leipzig'

client = Leipzig::Mediahandbook.new('my-key')

companies = client.find_companies(:postcode => '04103')
branches  = client.find_branches(:limit => 5)
people    = client.find_people(:offset => 100)
```

All `find` methods except a hash of params which are used to change the result set. See [this link](http://www.apileipzig.de/wiki/show/allgemeineParameter) for more
information about available params.

The result set is always an array containing OpenStruct objects so one can access entry data like properties:

```ruby
client.find_companies(:limit => 10).first.name
# ==> First company's name
```

Besides `Mediahandbook` there are also classes for `District` and `Calendar` which are used the same way. Again, see
link above for more information about params and structures. Calls could look as follows:

```ruby
Leipzig::Calendar.new(key).find_events
Leipzig::District.new(key).find_streets
```

_NOTE_: Works with both ruby 1.9.2 and ruby 1.9.3

## Running the tests

One can choose to run either the fake specs or the real world specs, whereas the latter ones actually calling the
API:

```bash
$ bundle

$ # Mocked API (default)
$ rake spec

$ # Real world API
$ API_KEY='my-key' API_TYPE='real' rake spec
```

## Todo

* Refactoring

## License

(The MIT License)

Copyright (c) 2012 Mario Behrendt info@mario-behrendt.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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

key = 'my-key'

client = Leipzig::Mediahandbook.new(key)

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

## Note

At the moment only the mediahandbook entries are supported.

## Running the tests

```bash
$ bundle
$ API_KEY='my-key' rake
```

## Contributing

1. Fork it
2. Create your feature branch
3. Write code and tests
4. Check tests
5. Commit your changes if tests pass
6. Push to the branch
7. Create new Pull Request

## Todo

* Support for whole API and all available resources
* Refactoring
* Maybe model layer instead of OpenStruct?

## License

(The MIT License)

Copyright (c) 2012 Mario Behrendt info@mario-behrendt.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

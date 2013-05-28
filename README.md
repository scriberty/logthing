# logthing

* http://github.com/bleything/logthing

## Description

I have years of IM logs. They're just sitting on disk not being particularly
useful. Logthing is an effort to make them accessible again.

## Requirements

* Ruby
* ElasticSearch

## Install

In your ElasticSearch directory:

    $ bin/plugin -install bleything/logthing
    $ cd plugins/logthing
    $ bundle install
    $ bundle exec rake import
    $ open http://localhost:9200/_plugin/logthing/

## License

(The MIT License)

Copyright (c) 2013 Ben Bleything <ben@bleything.net>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

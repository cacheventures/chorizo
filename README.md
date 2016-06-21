# chorizo

![Chorizo sausage](chorizo.jpg)

Parse and set environment variables on hosting providers Cloud66 and Heroku, in
the spirit of 12factor apps.  Essentially, this is a minimal version of
laserlemon/figaro which just functions as an environment variable setter. This
has the added feature of supporting both environments, so you get to specify
config overrides and/or additions for different environments as well as
different deploy targets. Both should be represented as first-level key-values
with the key being the environment name or the deployment target's name.

## Cloud66

For Cloud66, this will output your application's config for the specified
environment and with any deployment specific values you've placed in the
config. To use it, redirect STDOUT to a file and then upload to Cloud66. Any
warnings will go to STDERR.

## Heroku

For Heroku, the command `heroku config:set` is called, which will actually
update the environment variables on your app. As such, you need to specify a
Heroku app name when using this.

## Usage

```ruby
Usage: chorizo [options]
    -t, --target           target host. one of "cloud66" or "heroku"
    -e, --environment      environment. e.x. "staging"
    -a, --app              app. (for heroku only)
    -h, --help             Display this help message.
```

## Building

`gem build chorizo.gemspec`

## Testing

`pry -Ilib -rchorizo`

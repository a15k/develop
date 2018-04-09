
a15k Developer Docs
===================

Houses developer documentation for a15k.  Built on [middleman v4](https://middlemanapp.com/) configured to use the [external pipeline](https://middlemanapp.com/advanced/external-pipeline/) with [webpack v2](https://webpack.js.org/).

## Tools
- [middleman 4](https://middlemanapp.com/)
- [webpack 2](https://webpack.js.org/)
- [BrowserSync](https://www.browsersync.io/) - no manual page reloads ;-)
- [Boostrap 4](https://v4-alpha.getbootstrap.com) - to start your frontend fast
- [Font Awesome 4.7.0](https://fontawesome.io) - to have those nice icons present
- [jQuery](http://jquery.com/)
- [Rspec](http://rspec.info/) - prepared to test your static site - lol.

## Requirements
* [Middleman 4.x](https://middlemanapp.com/basics/install/)
* [Ruby 2.x](https://github.com/rbenv/rbenv#readme)
* [Node 5.x](https://github.com/creationix/nvm#readme)
* [Webpack 2](https://webpack.js.org/)

## How does it work

- Uses `middleman`'s external pipeline to generate assets. Configuration is in the two `environment`-files `development.rb` and `production.rb`
- Runs `webpack` as it's external pipeline, as configured in `package.json`.
- `webpack` uses the the `webpack.config.js` as it's configuration.
- When run as `middleman s` in `development` it'll start `middleman`, `middleman-livereload`, `webpack` and [BrowserSync](https://www.browsersync.io/). So reloading of templates and JS/CSS-changes should be reflected without manual reloads.
- BrowserSync is configured to proxy the middleman-server from `localhost:4567` to `localhost:3000` to inject itself.
- Stuff `webpack` does is put into `.webpack_build` which `middleman` serves together with it's own files.

## Build

```
bundle exec middleman build
```

## Deploy

You need to set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables before deploying.  If you used named profiles in your `~/.aws/credentials` file and have a profile called `a15k`, you can run this script to set these environment variables.

```
source ./set_aws_env_vars.sh
```

Then

```
bundle exec middleman s3_sync
```

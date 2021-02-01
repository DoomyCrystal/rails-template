# sahli-interactive/rails-template

## Description

*Originally Forked from mattbrictson/rails-template, now based on m43nu/rails-template branch v2*

This is the application template that We use for Rails 6+ projects.

## Requirements

This template currently works with:

* Rails 6.0.x
* PostgreSQL

If you need help setting up a Ruby development environment, check out Go Rails' [Rails Setup Guide](https://gorails.com/setup/osx/11.0-big-sur).

## Installation

*Optional.*

To make this the default Rails application template on your system, create a `~/.railsrc` file with these contents:

```
-d postgresql
-m https://raw.githubusercontent.com/sahli-interactive/rails-template/master/template.rb
```

## Usage

This template assumes you will store your project in a remote git repository (e.g. Bitbucket or GitHub) and that you will deploy to a production environment. It will prompt you for this information in order to pre-configure your app, so be ready to provide:

1. The git URL of your (freshly created and empty) Bitbucket/GitHub repository
2. The hostname/url for your app.

To generate a Rails application using this template, pass the `-m` option to `rails new`, like this:

```
rails new blog \
  -d postgresql \
  -m https://raw.githubusercontent.com/sahli-interactive/rails-template/master/template.rb
```

*Remember that options must go after the name of the application.* The only database supported by this template is `postgresql`.

If you’ve installed this template as your default (using `~/.railsrc` as described above), then all you have to do is run:

```
rails new blog
```

## What does it do?

The template will perform the following steps:

1. Generate your application files and directories
2. Ensure bundler is installed
3. Create the development and test databases
4. Commit everything to git
5. Push the project to the remote git repository you specified

## What is included?

#### These gems are added to the standard Rails stack

* Core
    * [sidekiq][] – Redis-based job queue implementation for Active Job
    * [webpacker][] - Javascripts & Stylesheets via Webpack
    * [rack-cache][] - simple Caching for Rails (only Production)  
    * [rails-i18n][] - general Translations for Rails
* Configuration
    * [dotenv][] – in place of the Rails `secrets.yml`
* Utilities
    * [annotate][] – auto-generates schema documentation
    * [better_errors][] – useful error pages with interactive stack traces
    * [foreman][] - manage Procfile-based applications (start webpacker, sidekiq and Rails with one command)  
    * [inline_svg][] - display SVGs inline
    * [mailgunner][] - use [mailgun][] for transactional emails  
    * [rails_real_favicon][] - generate Favicons and a manfiest.json for your app
    * [unpoly][] - an unobtrusive JavaScript framework for server-side web applications
    * [whenever][] - Cron jobs in Ruby
* Optional
    * [alchemy_cms][] - Rails CMS
    * [alchemy_devise][] - Devise-User Management for AlchemyCMS
    * [alchemy-richmedia-essences][] - Video- and Audio-Essences for AlchemyCMS
    * [bootstrap-form][] - Form-Builder for bootstrap-Styles

#### mailgun

Action Mailer is configured to use [mailgun][] to send emails. You can change this by editing `environments/production.rb`.

#### bootstrap integration (optional)

[bootstrap][]-related features are opt-in. To apply these to your project, answer "yes" when prompted.

* bootstrap-themed scaffold templates
* Application layout that includes Bootstrap-style navbar and boilerplate
* View helpers for generating common Bootstrap markup
* Form-Builder with Bootstrap-Styles [bootstrap-form][]

#### AlchemyCMS integration (optional)

[AlchemyCMS][]-related features are opt-in. To apply these to your project, answer "yes" when prompted.

* Installs AlchemyCMS, AlchemyCMS-Devise
* Application layout ready to use with AlchemyCMS
* Custom config.yml 
* Patch a few shortcomings and Bugs in the current Release

#### Other tweaks that patch over some Rails shortcomings

* A much-improved `bin/setup` script
* Log rotation so that development and test Rails logs don’t grow out of control

#### Plus lots of documentation for your project

* `README.md`
* `PROVISIONING.md` and `DEPLOYMENT.md` for Capistrano (optional)

## How does it work?

This project works by hooking into the standard Rails [application templates][] system, with some caveats. The entry point is the [template.rb][] file in the root of this repository.

Normally, Rails only allows a single file to be specified as an application template (i.e. using the `-m <URL>` option). To work around this limitation, the first step this template performs is a `git clone` of the `sahli-interactive/rails-template` repository to a local temporary directory.

This temporary directory is then added to the `source_paths` of the Rails generator system, allowing all of its ERb templates and files to be referenced when the application template script is evaluated.

Rails generators are very lightly documented; what you’ll find is that most of the heavy lifting is done by [Thor][]. The most common methods used by this template are Thor’s `copy_file`, `template`, and `gsub_file`. You can dig into the well-organized and well-documented [Thor source code][thor] to learn more.

[sidekiq]:http://sidekiq.org
[webpacker]:https://github.com/rails/webpacker
[rack-cache]:https://github.com/rtomayko/rack-cache
[rails-i18n]:https://github.com/svenfuchs/rails-i18n
[dotenv]:https://github.com/bkeepers/dotenv
[annotate]:https://github.com/ctran/annotate_models
[better_errors]:https://github.com/charliesome/better_errors
[foreman]:https://github.com/ddollar/foreman
[inline_svg]:https://github.com/jamesmartin/inline_svg
[mailgunner]:https://www.mailgun.com/
[mailgun]:https://www.mailgun.com/
[rails_real_favicon]:https://realfavicongenerator.net/favicon/ruby_on_rails
[unpoly]:https://unpoly.com/
[whenever]:https://github.com/javan/whenever
[alchemy_cms]:https://github.com/AlchemyCMS/alchemy_cms
[alchemy_devise]:https://github.com/AlchemyCMS/alchemy-devise
[alchemy_richmedia_essences]:https://github.com/AlchemyCMS/alchemy-richmedia-essences
[bootstrap-form]:https://github.com/bootstrap-ruby/bootstrap_form
[bootstrap]:http://getbootstrap.com
[AlchemyCMS]:http://alchemy-cms.com
[application templates]:http://guides.rubyonrails.org/generators.html#application-templates
[template.rb]: template.rb
[thor]: https://github.com/erikhuda/thor

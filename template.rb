require 'bundler'
require 'json'
require 'fileutils'
RAILS_REQUIREMENT = '~> 6.1.4'.freeze

def apply_template!
  assert_minimum_rails_version
  assert_valid_options
  assert_postgresql
  add_template_repository_to_source_path

  template 'Gemfile.tt', force: true

  template 'README.md.tt', force: true
  remove_file 'README.rdoc'

  template 'example.env.tt'
  copy_file 'gitignore', '.gitignore', force: true
  copy_file 'yarnclean', '.yarnclean', force: true
  template 'ruby-version.tt', '.ruby-version', force: true
  copy_file 'Procfile.dev', 'Procfile.dev'

  apply 'app/template.rb'
  apply 'bin/template.rb'
  apply 'config/template.rb'
  apply 'doc/template.rb'
  apply 'lib/template.rb'
  apply 'public/template.rb'

  git :init unless preexisting_git_repo?
  empty_directory '.git/safe'

  run_with_clean_bundler_env 'bin/setup'
  run_with_clean_bundler_env "bin/rails webpacker:install"
  create_initial_migration unless apply_alchemycms?

  binstubs = %w[
    annotate bundler sidekiq
  ]
  run_with_clean_bundler_env "bundle binstubs #{binstubs.join(' ')} --force"
  run_with_clean_bundler_env 'yarn add unpoly @fullhuman/postcss-purgecss@3.0.0'

  # we need to do this after the webpacker:install
  copy_file 'postcss.config.js', force: true
  copy_file 'config/webpack/development.js', force: true
  copy_file 'config/webpacker.yml', force: true

  if apply_bootstrap?
    apply 'variants/bootstrap/template.rb'
    copy_file 'config/webpack/environment.js', force: true
  end

  apply 'variants/tailwind/template.rb' if apply_tailwind?

  apply 'variants/alchemycms/template.rb' if apply_alchemycms?

  unless any_local_git_commits?
    git add: '-A .'
    git commit: "-n -m 'template - set up project'"
    if git_repo_specified?
      git remote: "add origin #{git_repo_url.shellescape}"
      git push: '-u origin --all'
    end
  end
end

require 'fileutils'
require 'shellwords'

# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.
def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require 'tmpdir'
    source_paths.unshift(tempdir = Dir.mktmpdir('rails-template-'))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/sahli-interactive/rails-template.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{rails-template/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end


def assert_minimum_rails_version
  requirement = Gem::Requirement.new(RAILS_REQUIREMENT)
  rails_version = Gem::Version.new(Rails::VERSION::STRING)
  return if requirement.satisfied_by?(rails_version)

  prompt = "This template requires Rails #{RAILS_REQUIREMENT}. "\
           "You are using #{rails_version}. Continue anyway?"
  exit 1 if no?(prompt)
end

# Bail out if user has passed in contradictory generator options.
def assert_valid_options
  valid_options = {
      skip_gemfile: false,
      skip_bundle: false,
      skip_git: false,
      edge: false
  }
  valid_options.each do |key, expected|
    next unless options.key?(key)
    actual = options[key]
    unless actual == expected
      fail Rails::Generators::Error, "Unsupported option: #{key}=#{actual}"
    end
  end
end

def assert_postgresql
  return if IO.read('Gemfile') =~ /^\s*gem ['"]pg['"]/
  fail Rails::Generators::Error,
       'This template requires PostgreSQL, '\
       'but the pg gem isn’t present in your Gemfile.'
end

def git_repo_url
  @git_repo_url ||=
      ask_with_default('What is the git remote URL for this project?', :blue, 'skip')
end

def production_hostname
  @production_hostname ||=
      ask_with_default('Production hostname?', :blue, 'example.com')
end

def gemfile_requirement(name)
  @original_gemfile ||= IO.read('Gemfile')
  req = @original_gemfile[/gem\s+['"]#{name}['"]\s*(,[><~= \t\d\.\w'"]*)?.*$/, 1]
  req && req.gsub("'", %(")).strip.sub(/^,\s*"/, ', "')
end

def ask_with_default(question, color, default)
  return default unless $stdin.tty?
  question = (question.split("?") << " [#{default}]?").join
  answer = ask(question, color)
  answer.to_s.strip.empty? ? default : answer
end

def git_repo_specified?
  git_repo_url != "skip" && !git_repo_url.strip.empty?
end

def preexisting_git_repo?
  @preexisting_git_repo ||= (File.exist?(".git") || :nope)
  @preexisting_git_repo == true
end

def any_local_git_commits?
  system('git log &> /dev/null')
end

def apply_bootstrap?
  @apply_bootstrap ||= ask_with_default('Use Bootstrap gems, layouts, views, etc.?', :blue, 'no')\
     =~ /^y(es)?/i
end

def apply_tailwind?
  @apply_tailwind ||= ask_with_default('Use tailwind for css?', :blue, 'yes')\
     =~ /^y(es)?/i
end

def apply_alchemycms?
  @apply_alchemycms ||= ask_with_default('Install and setup AlchemyCMS?', :blue, 'no')\
     =~ /^y(es)?/i
end

def run_with_clean_bundler_env(cmd)
  success = if defined?(Bundler)
              Bundler.with_unbundled_env { run(cmd) }
            else
              run(cmd)
            end
  unless success
    puts "Command failed, exiting: #{cmd}"
    exit(1)
  end
end

def create_initial_migration
  return if Dir['db/migrate/**/*.rb'].any?
  run_with_clean_bundler_env 'bin/rails generate migration initial_migration'
  run_with_clean_bundler_env 'bin/rake db:migrate'
end

apply_template!

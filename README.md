# Capistrano::Scm::LocalGitUpload

[![Gem Version](https://badge.fury.io/rb/capistrano-scm-local_git_upload.svg)](https://badge.fury.io/rb/capistrano-scm-local_git_upload)
![Ruby](https://github.com/simayosi/capistrano-scm-local_git_upload/actions/workflows/test.yml/badge.svg)


Capistrano SCM Plugin for local git clone and upload.

This plugin firstly clones the git repository to the local host
and thereafter uploads files on the local host to the remote servers.


## Installation

Add this line to your application's Gemfile:
```ruby
gem 'capistrano-scm-local_git_upload'
```
And execute:
```bash
$ bundle install
```

Add to Capfile:
```ruby
require "capistrano/scm/local_git_upload"
install_plugin Capistrano::SCM::LocalGitUpload
```

## Usage

The git repository is cloned
to `work_path` (default: `work`) on the local host
before `deploy:started`.

Then,
files under `upload_path` (default: `upload`) on the local host
are uploaded to `release_path` on the remote servers
after `deploy:new_release_path`.

Therefore, you need to prepare `upload_path` using `work_path` files
until `deploy:new_release_path`.

This is a simple copy example from `work/public` to `upload/public`.
```ruby
namespace :sample_app do
  task :copy_to_upload do
    run_locally do
      execute :cp, '-pr', work_path.join('public'), upload_path
    end
  end
  before 'deploy:new_release_path', 'sample_app:copy_to_upload'
end
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

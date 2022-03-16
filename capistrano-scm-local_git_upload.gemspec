# frozen_string_literal: true

require_relative 'lib/capistrano/scm/local_git_upload/version'

Gem::Specification.new do |spec|
  spec.name = 'capistrano-scm-local_git_upload'
  spec.version = Capistrano::Scm::LocalGitUpload::VERSION
  spec.authors = ['SHIMAYOSHI, Takao']
  spec.email = ['simayosi@cc.kyushu-u.ac.jp']

  spec.summary = 'Capistrano::SCM::LocalGitUpload'
  spec.description =
    'Capistrano SCM plugin for local git clone and upload.'
  spec.homepage = 'https://github.com/simayosi/capistrano-scm-local_git_upload'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['documentation_uri'] = spec.homepage

  spec.files = Dir['lib/**/*', 'LICENSE.txt', 'README.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.1'
end

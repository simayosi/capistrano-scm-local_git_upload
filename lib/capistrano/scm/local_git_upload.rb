# frozen_string_literal: true

require 'capistrano/scm/plugin'
require 'capistrano/scm/git'

module Capistrano
  module DSL
    # DSL extension for LocalGitUpload
    module LocalGitUpload
      def work_path
        Pathname.new fetch(:work_path)
      end

      def upload_path
        Pathname.new fetch(:upload_path)
      end
    end
  end
end
extend Capistrano::DSL::LocalGitUpload    # rubocop:disable Style/MixinUsage
include Capistrano::DSL::LocalGitUpload   # rubocop:disable Style/MixinUsage

module Capistrano
  class SCM
    # Capistrano SCM plugin for local git clone followed by upload
    class LocalGitUpload < ::Capistrano::SCM::Plugin
      def initialize
        super
        @git_plugin = Capistrano::SCM::Git.new
      end

      def set_defaults
        @git_plugin.set_defaults
        set_if_empty :local_top, Dir.getwd
        set_if_empty :repo_path, local_path('repo')
        set_if_empty :work_path, local_path('work')
        set_if_empty :upload_path, local_path('upload')
      end

      def define_tasks
        eval_rakefile File.expand_path('tasks/git_local.rake', __dir__)
        eval_rakefile File.expand_path('tasks/upload.rake', __dir__)
      end

      def register_hooks
        before 'deploy:check', 'upload:check_directory'
        before 'deploy:started', 'git_local:create_work'
        after 'deploy:new_release_path', 'upload:create_release'
        before 'deploy:set_current_revision', 'git_local:set_current_revision'
        after 'deploy:finishing', 'git_local:remove_directory'
        after 'deploy:finishing', 'upload:remove_directory'
      end

      private

      def local_path(path)
        Pathname.new(fetch(:local_top)).join(path).to_s
      end
    end
  end
end

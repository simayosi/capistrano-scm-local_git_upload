# frozen_string_literal: true

git_plugin = @git_plugin

namespace :git_local do
  desc 'Clone the repo to the local cache'
  task :clone do
    run_locally do
      execute :mkdir, '-p', repo_path
      if git_plugin.repo_mirror_exists?
        info t(:mirror_exists, at: repo_path)
      else
        with fetch(:git_environmental_variables) do
          git_plugin.clone_repo
        end
      end
    end
  end

  desc 'Update the local repo mirror to reflect the origin state'
  task update: :clone do
    run_locally do
      within repo_path do
        with fetch(:git_environmental_variables) do
          git_plugin.update_mirror
          git_plugin.verify_commit if fetch(:git_verify_commit)
        end
      end
    end
  end

  desc 'Copy repo to the working directory'
  task create_work: :update do
    run_locally do
      with fetch(:git_environmental_variables) do
        set :release_path, work_path
        within repo_path do
          execute :mkdir, '-p', release_path
          git_plugin.archive_to_release_path
        end
      end
    end
  end

  desc 'Determine the revision that will be deployed'
  task :set_current_revision do
    run_locally do
      within repo_path do
        with fetch(:git_environmental_variables) do
          set :current_revision, git_plugin.fetch_revision
        end
      end
    end
  end

  desc 'Remove the working directory'
  task :remove_directory do
    run_locally do
      execute :rm, '-rf', work_path
    end
  end
end

# frozen_string_literal: true

namespace :upload do
  desc 'Check the local upload directory'
  task :check_directory do
    run_locally do
      execute :mkdir, '-p', upload_path
    end
  end

  desc 'Upload the local upload directory recursively'
  task :create_release do
    on release_roles :all do
      upload! upload_path.to_s, release_path, recursive: true
    end
  end

  desc 'Remove the local upload directory'
  task :remove_directory do
    run_locally do
      execute :rm, '-rf', upload_path
    end
  end
end

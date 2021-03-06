# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

#set :application, "my_app_name"
#set :repo_url, "git@example.com:me/my_repo.git"

set :application, "treasurehunt.com"
set :repo_url, "git@github.com:Muzzamil123/treasure_hunt.git"
set :branch, "master"

set :rails_env, "production"

set :stages, ["staging", "production"]

#set :default_env, { path: "/usr/bin/rbenv:$PATH" }

#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/bin/rbenv exec"

set :deploy_to, "/home/ubuntu/apps/treasure_hunt"

# append :linked_files, "config/database.yml", "config/master.key", "config/credentials.yml", "config/credentials.yml.enc"
append :linked_dirs, "log", "storage"
append :linked_files, "config/database.yml"
# append :linked_files, ".env"
# append :linked_files, "config/master.key"
# append :linked_files, "config/credentials.yml"
# append :linked_files, "config/credentials.yml.enc"

# append :linked_files, "config/credentials/staging.key"
# append :linked_files, "config/credentials/staging.yml.enc"

namespace :deploy do
  task :start_new_rails_server do
    on roles(:app) do
      execute "cd #{current_path}; touch tmp/restart.txt"
    end
  end
end

# before 'deploy:check:linked_files', 'deploy:symlink:linked_files'
after 'deploy:finished', 'deploy:start_new_rails_server'

# --- --- --- --- ---

# namespace :deploy do
#   namespace :check do
#     before :linked_files, :set_master_key do
#       on roles(:app), in: :sequence, wait: 10 do
#         unless test("[ -f #{shared_path}/config/credentials/staging.key ]")
#           upload! 'config/credentials/staging.key', "#{shared_path}/config/credentials/staging.key"
#         end
#         # unless test("[ -f #{shared_path}/config/credentials/staging.yml.enc ]")
#         #   upload! 'config/credentials/staging.yml.enc', "#{shared_path}/config/credentials/staging.yml.enc"
#         # end
#       end
#     end
#   end
# end

# set :default_env, {
# PATH: '$HOME/.npm-packages/bin/:$PATH',
# NODE_ENVIRONMENT: 'staging',
# "RAILS_MASTER_KEY" => ENV["RAILS_MASTER_KEY"]
# }

# namespace :deploy do
#   desc "Run rake yarn install"
#   task :yarn_install do
#     on roles(:web) do
#       within release_path do
#         execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
#       end
#     end
#   end
# end

# before "assets:precompile", "deploy:yarn_install"

# --- --- --- --- ---

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

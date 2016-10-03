lock '3.6.1'

set :application, 'taskmanager'
set :repo_url, 'git@github.com:antonovga/taskmanager.git'

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'

set :branch, ENV["branch"] || :master

server deploysecret(:server1), user: deploysecret(:user), roles: %w[web app db importer cron background]
server deploysecret(:server2), user: deploysecret(:user), roles: %w[web app db importer]

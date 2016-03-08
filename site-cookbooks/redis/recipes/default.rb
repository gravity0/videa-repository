
cookbook_file "Redis" do
  source "redis-3.0.7.tar.gz"
  path "/tmp/redis-3.0.7.tar.gz"
  not_if "ls /tmp/redis-3.0.7"
end

bash "install_redis" do
  user "root"
  cwd "/tmp/"
  code <<-EOH
    tar xzf redis-3.0.7.tar.gz
    cd redis-3.0.7
    make && make install
  EOH
  not_if "ls /tmp/redis-3.0.7"
end

directory "/etc/redis" do
  mode 755
  owner "root"
  group "root"
  recursive true
  action :create
  not_if { File.exists?("/etc/redis") }
end

template "/etc/redis/redis.conf" do
  source "redis.conf.erb"
  mode 755
  owner "root"
  group "root"
  action :create
end

bash "start_redis_server" do
  user "root"
  code <<-EOH
    firewall-cmd --add-port=6379/tcp --zone=public --permanent
    /usr/local/bin/redis-server /etc/redis/redis.conf &
  EOH
  not_if "ps aux | grep redis-server | grep -v"
end

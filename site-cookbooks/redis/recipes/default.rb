
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


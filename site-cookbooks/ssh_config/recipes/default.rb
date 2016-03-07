
directory "/home/vagrant/.ssh" do
  mode 0700
  owner 'root'
  group 'root'
end

cookbook_file "/home/vagrant/.ssh/config" do
  source "ssh_config"
  mode 0700
  owner 'root'
  group 'root'
end

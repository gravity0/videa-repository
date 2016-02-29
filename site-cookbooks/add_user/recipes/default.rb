
data_ids = data_bag('users')

data_ids.each do |id|
  item = data_bag_item('users', id)

  item['groups'].each do |g|
    group g['name'] do
      gid g['gid']
      action :create
    end
  end

  item['users'].each do |u|
    user u['name'] do
      home u['home']
      uid u['uid']
      gid u['gid']
      action :create
    end
    directory "/#{u['home']}/.ssh" do
      owner u['uid']
      group u['gid']
      mode '0700'
      action :create
    end
    file "/#{u['home']}/.ssh/authorized_keys" do
      content u['ssh_pub_key']
      owner u['uid']
      group u['gid']
      mode '0700'
      action :create_if_missing
    end
  end
end



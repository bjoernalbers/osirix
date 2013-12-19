if platform_family?('mac_os_x')
  dmg_package 'OsiriX' do
    source      node[:osirix][:source]
    checksum    node[:osirix][:checksum] if node[:osirix][:checksum]
    destination node[:osirix][:destination] if node[:osirix][:destination]
    action      :install
  end
else
  Chef::Log.warn 'Skipping recipe since we are not on Mac OS X.'
end

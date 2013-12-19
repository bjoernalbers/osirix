if platform_family?('mac_os_x')
  [
    'BurnWeasis -boolean NO',
    'BurnOsirixApplication -boolean NO',
    'BurnHtml -boolean YES',
    'BurnSupplementaryFolder -boolean YES',
    'SupplementaryBurnPath ~/Library/Application\ Support/OsiriX/iq-view_2.5.0b'
  ].each do |setting|
    execute "defaults write com.rossetantoine.osirix #{setting}" do
      user 'radiologie'
    end
  end

  zip = 'iq-view_2.5.0b.zip'

  remote_file File.join(Chef::Config[:file_cache_path], zip) do
    source "http://gandalf/chef/#{zip}"
  end

  execute "unzip #{File.join(Chef::Config[:file_cache_path], zip)}" do
    user 'radiologie'
    cwd '/Users/radiologie/Library/Application Support/OsiriX'
  end

  dmg_package 'OsiriX' do
    source      node[:osirix][:source]
    checksum    node[:osirix][:checksum] if node[:osirix][:checksum]
    destination node[:osirix][:destination] if node[:osirix][:destination]
    action      :install
  end
else
  Chef::Log.warn 'Skipping recipe since we are not on Mac OS X.'
end

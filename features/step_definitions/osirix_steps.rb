Before do
  @aruba_timeout_seconds = 30
end

def cookbook_path
  File.expand_path('../../../vendor/cookbooks', __FILE__)
end

def file_cache_path
  cwd
end

def sample_dmg
  File.expand_path("../../assets/osirix.dmg", __FILE__)
end


def cwd
  File.expand_path(current_dir)
end

# Change default install destination (We don't mess up "/Applications"!).
def destination
  File.join(cwd, 'Applications')
end

# SHA-1 checksum of sample dmg.
def checksum
  Digest::SHA256.file(sample_dmg).hexdigest
end

def create_config_file
  content = <<-END.gsub(/^\s+\|/, '')
    |cookbook_path '#{ cookbook_path }'
    |file_cache_path '#{ file_cache_path }'
  END
  write_file('solo.rb', content)
end

def create_attrib_file
  content = <<-END.gsub(/^\s+\|/, '')
    |{
    |  "osirix" : {
    |    "source":      "http://example.com/osirix.dmg",
    |    "checksum":    "#{ checksum }",
    |    "destination": "#{ destination }"
    |  },
    |  "run_list":      [ "recipe[osirix]" ]
    |}
  END
  write_file('node.json', content)
end

Given(/^chef is setup$/) do
  create_config_file
  create_attrib_file
end

Given(/^OsiriX was already downloaded$/) do
  dmg = File.join(file_cache_path, 'osirix.dmg')
  FileUtils.cp(sample_dmg, dmg)
  check_file_presence([dmg], true)
end

When(/^I run chef$/) do
  run_simple('chef-solo -c solo.rb -j node.json', true)
end

Then(/^OsiriX should be installed$/) do
  app_path = File.join(destination, 'OsiriX.app')
  check_directory_presence([app_path], true)
end

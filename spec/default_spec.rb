require 'spec_helper'

describe 'osirix::default' do
  let(:chef_run) do
    runner = ChefSpec::Runner.new(platform: 'mac_os_x', version: '10.8.2')
    runner.converge(described_recipe)
  end

  def expect_to_execute(cmd)
    expect(chef_run).to run_execute(cmd).with(user: 'radiologie')
  end

  it 'does not burn with weasis' do
    expect_to_execute 'defaults write com.rossetantoine.osirix BurnWeasis -boolean NO'
  end

  it 'does not burn with osirix lite' do
    expect_to_execute 'defaults write com.rossetantoine.osirix BurnOsirixApplication -boolean NO'
  end

  it 'burns with html' do
    expect_to_execute 'defaults write com.rossetantoine.osirix BurnHtml -boolean YES'
  end

  it 'burns with supplementary folder' do
    expect_to_execute 'defaults write com.rossetantoine.osirix BurnSupplementaryFolder -boolean YES'
  end

  it 'sets the supplementary folder to burn' do
    expect_to_execute 'defaults write com.rossetantoine.osirix SupplementaryBurnPath ~/Library/Application\ Support/OsiriX/iq-view_2.5.0b'
  end

  it 'downloads the dicom viewer' do
    expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/iq-view_2.5.0b.zip").
      with(source: 'http://gandalf/chef/iq-view_2.5.0b.zip')
  end

  it 'unzips the dicom viewer' do
    cmd = "unzip #{Chef::Config[:file_cache_path]}/iq-view_2.5.0b.zip"
    expect(chef_run).to run_execute(cmd).with(user: 'radiologie', cwd: '/Users/radiologie/Library/Application Support/OsiriX')
  end
end

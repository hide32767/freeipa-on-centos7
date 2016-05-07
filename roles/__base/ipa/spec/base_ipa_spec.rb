require 'spec_helper'


describe "checking base_ipa" do

  context file('/etc/hosts') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    its(:content) { should match /^#{property['ipa']['master']['ipaddr']} #{property['ipa']['master']['hostname']}/ }
    its(:content) { should match /^#{property['ipa']['replica']['ipaddr']} #{property['ipa']['replica']['hostname']}/ }
  end

  property['ipa']['packages'].each do |pkg|
    context package(pkg), :if => os[:family] == 'redhat' do
      it { should be_installed }
    end
  end

  context file('/etc/httpd/conf.d/nss.conf') do
    it { should be_file }
    its(:content) { should_not match /^NSSProtocol .*SSLv3/ }
  end

end

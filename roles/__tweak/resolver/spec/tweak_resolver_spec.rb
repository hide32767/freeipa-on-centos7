require 'spec_helper'


describe "checking tweak_resolver" do

  context file('/etc/NetworkManager/NetworkManager.conf') do
    it { should be_file }
    its(:content) { should match /^\[main\]\ndns=none/ }
  end

  context file('/etc/resolv.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    its(:content) { should match /^search #{property['ipa']['domain_name']}/ }
    its(:content) { should match /^nameserver 127.0.0.1/ }
  end

end

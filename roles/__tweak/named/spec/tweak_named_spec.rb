require 'spec_helper'


describe "checking tweak_named" do

  context file('/etc/named.conf') do
    it { should be_file }
    its(:content) { should match /^\t+dnssec-enable no;/ }
    its(:content) { should match /^\t+dnssec-validation no;/ }
  end

end

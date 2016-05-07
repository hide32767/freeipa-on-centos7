require 'spec_helper'


describe "checking base/environment misc" do

  %w{yum-utils}.each do |pkg|
    context package(pkg), :if => os[:family] == 'redhat' do
      it { should be_installed }
    end
  end

  context selinux do
    it { should be_disabled }
  end

  context service('firewalld') do
    it { should_not be_enabled }
    it { should_not be_running.under('systemd') }
  end

  context command(%q{locale -a}) do
    its(:stdout) { should match /ja_JP.utf8/ }
  end

  context command(%q{timedatectl | grep 'Time zone'}) do
    its(:stdout) { should match /#{property['timezone']}/ }
  end

end

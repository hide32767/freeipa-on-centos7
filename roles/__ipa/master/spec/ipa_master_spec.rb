require 'spec_helper'


describe "checking ipa_master_ready" do

  context command(%q{uname -n}) do
    its(:stdout) { should match /^#{property['ipa']['master']['hostname']}/ }
  end

  context service('ipa') do
    it { should be_enabled }
    it { should be_running.under('systemd') }
  end

  describe "IPA replication" do
    %w{ipa-replica-manage ipa-csreplica-manage}.each do |cmd|
      context command(%Q{#{cmd} -p #{property['ipa']['dm_password']} list}) do
        its(:stdout) { should match /^#{property['ipa']['master']['hostname']}: master/ }
        its(:stdout) { should match /^#{property['ipa']['replica']['hostname']}: master/ }
      end
    end
  end

  describe "HTTP(S) ports" do
    %w{80 443}.each do |port|
      context port(port) do
        it { should be_listening.with('tcp6') }
      end
    end
  end

  describe "LDAP(S) ports" do
    %w{389 636}.each do |port|
      context port(port) do
        it { should be_listening.with('tcp6') }
      end
    end
  end

  describe "Kerberos ports" do
    %w{88 464}.each do |port|
      context port(port) do
        it { should be_listening.with('tcp') }
        it { should be_listening.with('udp') }
      end
    end
  end

  describe "DNS port" do
    context port(53) do
      it { should be_listening.with('tcp') }
      it { should be_listening.with('udp') }
    end
  end

  describe "NTP port" do
    context port(123) do
      it { should be_listening.with('udp') }
    end
  end

end

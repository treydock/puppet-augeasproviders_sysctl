require 'spec_helper'

describe 'sysctl' do
  include_context :defaults

  let(:facts) { default_facts }

  it { should create_class('sysctl') }
  it { should contain_class('sysctl::params') }

  it { should contain_package('procps').with_ensure('present') }
  it { should contain_package('initscripts').with_ensure('present') }

  it do
    should contain_file('/etc/sysctl.conf').with({
      'ensure'  => 'present',
      'path'    => '/etc/sysctl.conf',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
    })
  end

  it { should have_sysctl_resource_count(0) }

  context  "with values => {'vm.foo' => {'value' => '0'}}" do
    let :params do
      {
        :values => {
          'vm.foo' => {'value' => '0'},
        },
      }
    end

    it { should have_sysctl_resource_count(1) }

    it do
      should contain_sysctl('vm.foo').with({
        'ensure'  => 'present',
        'target'  => '/etc/sysctl.conf',
        'apply'   => 'true',
        'value'   => '0',
      })
    end
  end

  describe 'invalid parameters' do
    context 'with values => "vm.foo,value,0"' do
      let(:params) {{ :values => 'vm.foo,value,0' }}
      it { expect { should create_class('sysctl') }.to raise_error(Puppet::Error, /is not a Hash/) }
    end
  end

  describe 'unsupported osfamily' do
    context 'with osfamily => "Debian"' do
      let(:facts) { default_facts.merge({ :osfamily => "Debian" }) }
      it { expect { should contain_class('sysctl::params')}.to raise_error(Puppet::Error, /Unsupported osfamily: Debian/) }
    end
  end
end

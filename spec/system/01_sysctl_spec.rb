require 'spec_helper_system'

describe 'sysctl class:' do
  context 'should run successfully' do
    pp = "class { 'sysctl': }"
  
    context puppet_apply(pp) do
       its(:stderr) { should be_empty }
       its(:exit_code) { should_not == 1 }
       its(:refresh) { should be_nil }
       its(:stderr) { should be_empty }
       its(:exit_code) { should be_zero }
    end

    describe linux_kernel_parameter('vm.swappiness') do
      its(:value) { should eq 60 }
    end
  end

  context 'defining values parameter' do
    pp =<<-EOS
      class { 'sysctl': 
        values  => {'vm.swappiness' => { 'value' => '1' }},
      }
    EOS

    context puppet_apply(pp) do
       its(:stderr) { should be_empty }
       its(:exit_code) { should_not == 1 }
       its(:refresh) { should be_nil }
       its(:stderr) { should be_empty }
       its(:exit_code) { should be_zero }
    end

    describe linux_kernel_parameter('vm.swappiness') do
      its(:value) { should eq 1 }
    end

    describe file('/etc/sysctl.conf') do
      it { should contain 'vm.swappiness = 1'}
    end
  end
end

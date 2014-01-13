require 'spec_helper_system'

describe 'sysctl class:' do
  context 'with default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'sysctl': }
      EOS
  
      puppet_apply(pp) do |r|
       r.exit_code.should_not == 1
       r.refresh
       r.exit_code.should be_zero
      end
    end

    describe linux_kernel_parameter('vm.swappiness') do
      its(:value) { should eq 60 }
    end
  end

  context 'defining values parameter' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'sysctl': 
          values  => {'vm.swappiness' => { 'value' => '1' }},
        }
      EOS

      puppet_apply(pp) do |r|
       r.exit_code.should_not == 1
       r.refresh
       r.exit_code.should be_zero
      end
    end

    describe linux_kernel_parameter('vm.swappiness') do
      its(:value) { should eq 1 }
    end

    describe file('/etc/sysctl.conf') do
      it { should contain 'vm.swappiness = 1'}
    end
  end
end

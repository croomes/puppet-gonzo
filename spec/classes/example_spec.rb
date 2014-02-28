require 'spec_helper'

describe 'gonzo' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "gonzo class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('gonzo::params') }
        it { should contain_class('gonzo::install').that_comes_before('gonzo::config') }
        it { should contain_class('gonzo::config') }
        it { should contain_class('gonzo::service').that_subscribes_to('gonzo::config') }

        it { should contain_service('gonzo') }
        it { should contain_package('gonzo').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'gonzo class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('gonzo') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

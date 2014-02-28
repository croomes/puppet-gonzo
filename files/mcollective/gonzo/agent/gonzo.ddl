metadata    :name        => "gonzo",
            :description => "Utilities for Gonzo impact analysis",
            :author      => "Simon Croome",
            :license     => "Apache 2.0",
            :version     => "0.0.1",
            :url         => "https://github.com/croomes/puppet-gonzo",
            :timeout     => 300

requires :mcollective => "2.2.1"

action "run", :description => "Run Puppet in enforcement mode" do

    input :environment,
          :prompt      => "Environment",
          :description => "Which Puppet environment(release tag) to run against",
          :type        => :string,
          :validation  => :puppet_variable,
          :optional    => true,
          :maxlength   => 50

    output :output,
           :description  => "Output from the Puppet run",
           :display_as   => "Output",
           :default      => ""

    output :exitcode,
           :description  => "Exit Code from the Puppet run",
           :display_as   => "Exit Code",
           :default      => 1

end

action "check", :description => "Run Puppet in noop mode" do

    input :environment,
          :prompt      => "Environment",
          :description => "Which Puppet environment(release tag) to run against",
          :type        => :string,
          :validation  => :puppet_variable,
          :optional    => true,
          :maxlength   => 50

    output :output,
           :description  => "Output from the Puppet run",
           :display_as   => "Output",
           :default      => ""

    output :exitcode,
           :description  => "Exit Code from the Puppet run",
           :display_as   => "Exit Code",
           :default      => 1

end
Facter.add(:gonzo_role) do
  setcode do
    input = Facter.value('puppet_vardir') + '/classes.txt'
    if File.exist? input
      # Avoid loading whole file into memory, even tho' small
      open(input) { |f| f.each_line.detect { |line| /^role/.match(line) } }
    end
  end
end

Facter.add(:gonzo_tier) do
  setcode do
    case Facter.value('operatingsystem')
    when /CentOS|RedHat/
        input = "/etc/sysconfig/gonzo"
    when /(?i:Debian|Ubuntu|Mint)/
        input = "/etc/default/gonzo"
    else
        input = "/etc/gonzo"
    end

    if File.exist? input
      # Get first line matching release= then get value
      open(input) { |f| f.each_line.detect { |line| /^tier=.+$/i.match(line) } }.match(/\w+=(.+)/)[1]
    end
  end
end

Facter.add(:gonzo_release) do
  setcode do
    case Facter.value('operatingsystem')
    when /CentOS|RedHat/
        input = "/etc/sysconfig/gonzo"
    when /(?i:Debian|Ubuntu|Mint)/
        input = "/etc/default/gonzo"
    else
        input = "/etc/gonzo"
    end

    if File.exist? input
      # Get first line matching release= then get value
      open(input) { |f| f.each_line.detect { |line| /^release=.+$/i.match(line) } }.match(/\w+=(.+)/)[1]
    end
  end
end

Facter.add(:gonzo_available_releases) do
  setcode do
    # TODO: remove hardcoded directory / support open-source
    environment_dir = "/etc/puppetlabs/puppet/environments"
    if Dir.exist? environment_dir
      Pathname.glob("#{environment_dir}/*/").sort.map { |i| i.basename.to_s }
    end
  end
end
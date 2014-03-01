Facter.add(:gonzo_role) do
  setcode do
    input = Facter.value('puppet_vardir') + '/classes.txt'
    if File.exist? input
      # Avoid loading whole file into memory, even tho' small
      open(input) { |f| f.each_line.detect { |line| /^role/.match(line) } }
    end
  end
end

Facter.add(:gonzo_release) do
  setcode do
    input = "/etc/sysconfig/gonzo"
    if File.exist? input
      # Get first line matching release= then get value
      open(input) { |f| f.each_line.detect { |line| /^release=.+$/i.match(line) } }.match(/\w+=(.+)/)[1]
    end
  end
end
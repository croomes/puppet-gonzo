Facter.add(:gonzo_role) do
  setcode do
    
    classes = Facter.value('puppet_vardir') + '/classes.txt'
    if File.exist? classes
      # Avoid loading whole file into memory, even tho' small
      open(classes) { |f| f.each_line.detect { |line| /^role/.match(line) } }
    end
  end
end

Facter.add(:gonzo_release) do
  setcode do
    gonzo = "/etc/sysconfig.d/gonzo"
    if File.exist? gonzo
      open(classes) { |f| f.each_line.detect { |line| /^release=(.+)$/i.match(line)[1] } }
    end
  end
end
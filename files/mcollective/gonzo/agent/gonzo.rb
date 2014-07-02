module MCollective
  module Agent
    class Gonzo < RPC::Agent

      activate_when do
        require 'mcollective/util/puppet_agent_mgr'
        true
      end

      def startup_hook
        configfile = @config.pluginconf.fetch("puppet.config", nil)
        @puppet_command = @config.pluginconf.fetch("puppet.command", "puppet agent")
      end

      action "run" do

        environment = request[:environment] if request[:environment]
        tags = request[:tags] if request[:tags]
        options = []
        options << "--test"
        options << "--detailed-exitcodes"
        options << "--color false"
        options << "--environment %s" % environment if environment
        m = MCollective::Util::PuppetAgentMgr.manager
        options << "--tags %s" % tags if tags and !m.daemon_present?
        command = [@puppet_command].concat(options).join(" ")

        # If an agent is already applying a catalog, wait for it to finish
        sleep(1) while m.applying?

        out = []
        err = ""
        reply[:status] = run(command, :stdout => :out, :stderr => :err,
          :chomp => true)
        Log.info("status: " + reply[:status].to_s)

        case reply[:status]
          when 0
            reply[:msg] = "No Changes Made  running '%s' ( env '%s' )" % [command,environment]
          when 2
            reply[:msg] = "Changes Made  running '%s'" % command
          when 4
            reply.fail! "Failures Occurred running '%s'" % command
          when 6
            reply.fail! "Changes Made; Failures Occurred running '%s'" % command
          else
            reply.fail! "UNKNOWN error  running '%s'" % command
        end
      end

      action "check" do

        environment = request[:environment] if request[:environment]
        tags = request[:tags] if request[:tags]
        options = []
        options << "--test"
        options << "--detailed-exitcodes"
        options << "--noop"
        options << "--color false"
        options << "--environment %s" % environment if environment
        m = MCollective::Util::PuppetAgentMgr.manager
        options << "--tags %s" % tags if tags and !m.daemon_present?
        command = [@puppet_command].concat(options).join(" ")

        # If an agent is already applying a catalog, wait for it to finish
        sleep(1) while m.applying?

        out = []
        err = ""
        reply[:status] = run(command, :stdout => :out, :stderr => :err,
          :chomp => true)
        Log.info("status: " + reply[:status].to_s)

        case reply[:status]
          when 0
            reply[:msg] = "No Changes Made  running '%s'" % command
          when 2
            reply.fail! "Pending Changes running '%s'" % command
          when 4
            reply.fail! "Failures Occurred running '%s'" % command
          when 6
            reply.fail! "Pending Changes; Failures Occurred  running '%s'" % command
          else
            reply.fail! "UNKNOWN error running '%s'" % command
        end
      end

    end
  end
end

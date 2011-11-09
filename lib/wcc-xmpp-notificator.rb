
require 'xmpp4r/client'

class XMPPNotificator
	@@client = nil
	@@tpl = {}
		
	def initialize(opts)
		@jid = Jabber::JID.new(opts)
	end
	
	def notify!(data)
		# prepare message
		subject = self.class.get_tpl(:subject, 'xmpp-subject.plain.erb').result(binding)
		body = self.class.get_tpl(:body, 'xmpp-body.plain.erb').result(binding)
		m = Jabber::Message.new(@jid, body)
		m.type = :normal
		m.subject = subject
		# send it
		c = self.class.get_client
		c.send(m) unless c.nil?
	end
	
	def self.parse_conf(conf)
		if conf.is_a?(Hash)
			if conf['jid'].nil?
				WCC.logger.fatal "Missing jabber ID!"
				return {:xmpp_jid => nil}
			elsif conf['password'].nil?
				WCC.logger.fatal "Missing jabber password!"
			else
				return {
					:xmpp_jid => Jabber::JID.new(conf['jid']),
					:xmpp_password => conf['password']
				}
			end
		end
		# no defaults
		{}
	end
	
	def self.shut_down
		if not @@client.nil?
			@@client.send(Jabber::Presence.new.set_type(:unavailable))
			@@client.close
		end
	end
	
	def self.get_client
		if @@client.nil? and not WCC::Conf[:xmpp_jid].nil?
			@@client = Jabber::Client.new(WCC::Conf[:xmpp_jid])
			@@client.connect
			begin
				@@client.auth(WCC::Conf[:xmpp_password])
				@@client.send(Jabber::Presence.new.set_status('At your service every night.'))
			rescue Jabber::ClientAuthenticationFailure => ex
				WCC.logger.fatal "Wrong jabber password for #{WCC::Conf[:xmpp_jid]}!"
				@@client.close
				@@client = nil
			end
		end
		@@client
	end
	
	def self.get_tpl(id, name)
		if @@tpl[id].nil?
			@@tpl[id] = WCC::Prog.load_template(name)
			if @@tpl[id].nil?
				src_path = Pathname.new(__FILE__) + "../../assets/template.d/#{name}"
				t = File.open(src_path, 'r') { |f| f.read }
				WCC::Prog.save_template(name, t)
				# retry load
				@@tpl[id] = WCC::Prog.load_template(name)
			end
			if @@tpl[id].nil?
				@@tpl[id] = ERB.new("ERROR LOADING TEMPLATE '#{name}'!", 0, "<>")
			end
		end
		@@tpl[id]
	end
end

WCC::Notificators.map "xmpp", XMPPNotificator

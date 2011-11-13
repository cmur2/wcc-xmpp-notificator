
Gem::Specification.new do |s|
	s.name		= "wcc-xmpp-notificator"
	s.version	= "0.0.2"
	s.summary	= "XMPP/Jabber notificator plugin for wcc"
	s.author	= "Christian Nicolai"
	s.email		= "chrnicolai@gmail.com"
	s.homepage	= "https://github.com/cmur2/wcc-xmpp-notificator"
	s.rubyforge_project = "wcc-xmpp-notificator"
	
	s.files = [
		"assets/template.d/xmpp-body.plain.erb",
		"lib/wcc-xmpp-notificator.rb",
		"README.md"
	]
	
	s.require_paths = ["lib"]
	
	s.add_runtime_dependency "xmpp4r", "~> 0.5"
end

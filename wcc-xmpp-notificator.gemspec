
Gem::Specification.new do |s|
	s.name		= "wcc-xmpp-notificator"
	s.version	= "0.0.1"
	s.summary	= ""
	s.author	= "Christian Nicolai"
	s.email		= "chrnicolai@gmail.com"
	s.homepage	= "https://github.com/cmur2/wcc-xmpp-notificator"
	s.rubyforge_project = "wcc-xmpp-notificator"
	
	s.files = [
		"assets/template.d/xmpp-subject.plain.erb",
		"assets/template.d/xmpp-body.plain.erb",
		"lib/wcc-xmpp-notificator.rb"
	]
	
	s.require_paths = ["lib"]
	
	s.add_runtime_dependency "xmpp4r"
end

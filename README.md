wcc-xmpp-notificator
====================

This adds XMPP/Jabber support to [wcc](https://github.com/cmur2/wcc) encapsuled
in a separate gem.

Note: This notificator does not need to have an (and even not supports establishing some)
authorization/subscription to talk to the recipients jabber accounts.

What you need to add to your conf.yml:

	conf:
	  [...]
	  # jid is the address wcc will talk from
	  xmpp:
	    jid: wcc@example.com/wcc
	    password: s3cr3t
	
	recipients:
	  [...]
	  - me:
	    [...]
	    # address to be notified via Jabber
	    - xmpp: me@mydomain.com

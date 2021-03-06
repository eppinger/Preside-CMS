component output=false {

	private struct function prepareMessage( event, rc, prc, args={} ) output=false {

		args.resetLink = event.buildAdminLink(
			  linkto      = "login.resetpassword"
			, querystring = "token=" & ( args.resetToken ?: "" )
		);
		args.websiteName  = args.websiteName ?: event.getSite().domain;
		args.emailAddress = args.to[1]       ?: "";
		args.userName     = args.userName    ?: "";

		var message = {
			  subject  = "Welcome to PresideCMS"
			, textBody = renderView( view="/emailTemplates/cmsWelcome/text", args=args )
			, htmlBody = renderView( view="/emailTemplates/cmsWelcome/html", args=args )
		};

		message.htmlBody = renderView( view="/emailTemplates/_adminHtmlLayout", args={ body=message.htmlBody, subject=message.subject } );

		return message;
	}

}
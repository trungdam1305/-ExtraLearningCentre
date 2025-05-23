jQuery.noConflict();

jQuery(document).ready(function($){
	"use strict";								
	//MAIN CONTACT FORM...
	jQuery(".contact-frm").validate({ 
      onfocusout: function(element){ $(element).valid(); },
        rules: { 
			cname: { required: true, minlength: 2 },
			cemail: { required: true, email: true },
			cmessage: { required: true, minlength: 10 },
			txtcap: { required: true, minlength: 4, equalTo: "#txthidcap" }
		}
	});
});
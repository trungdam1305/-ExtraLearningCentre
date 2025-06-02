jQuery.noConflict();
jQuery(document).ready(function() {
  
  // Tabs Shortcodes
  "use strict";
  if(jQuery('ul.dt-sc-tabs').length > 0) {
    jQuery('ul.dt-sc-tabs').jtabs('> .dt-sc-tabs-content');
  }
  
  if(jQuery('ul.dt-sc-tabs-frame').length > 0){
    jQuery('ul.dt-sc-tabs-frame').jtabs('> .dt-sc-tabs-frame-content');
  }
  
  if(jQuery('.dt-sc-tabs-vertical-frame').length > 0){
    
    jQuery('.dt-sc-tabs-vertical-frame').jtabs('> .dt-sc-tabs-vertical-frame-content');
    
    jQuery('.dt-sc-tabs-vertical-frame').each(function(){
      jQuery(this).find("li:first").addClass('first').addClass('current');
      jQuery(this).find("li:last").addClass('last');
    });
    
    jQuery('.dt-sc-tabs-vertical-frame li').on('click', function(){
      jQuery(this).parent().children().removeClass('current');
      jQuery(this).addClass('current');
    });
    
  }/*Tabs Shortcode Ends*/
  
  /*Toggle shortcode*/
  jQuery('.dt-sc-toggle').toggleClick(function(){ jQuery(this).addClass('active'); },function(){ jQuery(this).removeClass('active'); });
  jQuery('.dt-sc-toggle').on('click', function(){ jQuery(this).next('.dt-sc-toggle-content').slideToggle(); });
  jQuery('.dt-sc-toggle-frame-set').each(function(){
    var $this = jQuery(this),
        $toggle = $this.find('.dt-sc-toggle-accordion');
    
    $toggle.on('click', function(){
      if( jQuery(this).next().is(':hidden') ) {
        $this.find('.dt-sc-toggle-accordion').removeClass('active').next().slideUp();
        jQuery(this).toggleClass('active').next().slideDown();
      }
      return false;
    });
    
    //Activate First Item always
    $this.find('.dt-sc-toggle-accordion:first').addClass("active");
    $this.find('.dt-sc-toggle-accordion:first').next().slideDown();
  });/* Toggle Shortcode end*/
  
  /*Tooltip*/
  if(jQuery(".dt-sc-tooltip-bottom").length){
    jQuery(".dt-sc-tooltip-bottom").each(function(){	jQuery(this).tipTip({maxWidth: "auto"}); });
  }
  
  if(jQuery(".dt-sc-tooltip-top").length){
    jQuery(".dt-sc-tooltip-top").each(function(){ jQuery(this).tipTip({maxWidth: "auto",defaultPosition: "top"}); });
  }
  
  if(jQuery(".dt-sc-tooltip-left").length){
    jQuery(".dt-sc-tooltip-left").each(function(){ jQuery(this).tipTip({maxWidth: "auto",defaultPosition: "left"}); });
  }
  
  if(jQuery(".dt-sc-tooltip-right").length){
    jQuery(".dt-sc-tooltip-right").each(function(){ jQuery(this).tipTip({maxWidth: "auto",defaultPosition: "right"}); });
  }/*Tooltip End*/

  //Newsletter ajax submit...
  jQuery('form[name="frmsubscribe"]').on('submit', function () {

    var $this = jQuery(this);
    var $mc_fname = $this.find('#dt_mc_fname').val(),
      $mc_email = $this.find('#dt_mc_emailid').val(),
      $mc_apikey = $this.find('#dt_mc_apikey').val(),
      $mc_listid = $this.find('#dt_mc_listid').val();

    jQuery.ajax({
      type: "POST",
      url: mytheme_urls.ajaxurl,
      data:
      {
        action: 'dt_theme_mailchimp_subscribe',
        mc_fname: $mc_fname,
        mc_email: $mc_email,
        mc_apikey: $mc_apikey,
        mc_listid: $mc_listid
      },
      success: function (response) {
        $this.parent().find('#ajax_newsletter_msg').html(response);
        $this.parent().find('#ajax_newsletter_msg').slideDown('slow');
        if (response.match('success') != null){
          $this.find("input[name='submit']").attr('disabled', 'disabled');
          $this.find("input[name='submit']").addClass('disabled');
        }
      }
    });

    return false;
  });

  //CONTACT FORM AJAX SUBMIT...
  jQuery('.contact-frm').submit(function () {

    var This = jQuery(this);
        var data_value = null;

    if( jQuery(This).valid() ) {
      var action = jQuery(This).attr('action');

      data_value = decodeURI( jQuery(This).serialize() );
      jQuery.ajax({
                 type: "POST",
                 url:action,
                 data: data_value,
                 success: function (response) {
                   jQuery('#ajax_message').html(response);
                   jQuery('#ajax_message').slideDown('slow');
                   if (response.match('success') !== null){ jQuery(This).slideUp('slow'); }
                 }
            });
        }
        return false;
  });

  //Scroll to top
  jQuery("a.scrollTop").each(function(){
    jQuery(this).on('click', function(e){
      jQuery("html, body").animate({ scrollTop: 0 }, 600);
      e.preventDefault();
    });
  });//Scroll to top end

  //Skillset
  animateSkillBars();
  jQuery(window).scroll(function(){ animateSkillBars(); });
  function animateSkillBars(){
    var applyViewPort = ( jQuery("html").hasClass('csstransforms') ) ? ":in-viewport" : "";
    jQuery('.dt-sc-progress'+applyViewPort).each(function(){
      var progressBar = jQuery(this),
          progressValue = progressBar.find('.dt-sc-bar').attr('data-value');
      
      if (!progressBar.hasClass('animated')) {
        progressBar.addClass('animated');
        progressBar.find('.dt-sc-bar').animate({width: progressValue + "%"},600,function(){ progressBar.find('.dt-sc-bar-text').fadeIn(400); });
      }
    });
  }
});
jQuery.noConflict();
jQuery(document).ready(function($){

	"use strict";	
	function megaMenu() {
		var screenWidth = $(document).width(),
			containerWidth = $(".container").width(),
			containerMinuScreen = (screenWidth - containerWidth)/2;
			
		$("li.menu-item-megamenu-parent .megamenu-child-container").each(function(){
			var ParentLeftPosition = $(this).parent("li.menu-item-megamenu-parent").offset().left,
			MegaMenuChildContainerWidth = $(this).width();

      if( (ParentLeftPosition + MegaMenuChildContainerWidth) > containerWidth ){
					 
         var marginFromLeft = ( ParentLeftPosition + MegaMenuChildContainerWidth ) - screenWidth;
         var marginLeftFromContainer = containerMinuScreen + marginFromLeft + 20;
						 
         if( MegaMenuChildContainerWidth > containerWidth ){
           var MegaMinuContainer        = ( (MegaMenuChildContainerWidth - containerWidth)/2 ) + 10;                         
           var marginLeftFromContainerVal = marginLeftFromContainer - MegaMinuContainer;
           marginLeftFromContainerVal = "-"+marginLeftFromContainerVal+"px";
           $(this).css('left',marginLeftFromContainerVal);
         }
         else {
           marginLeftFromContainer = "-"+marginLeftFromContainer+"px";
           $(this).css('left',marginLeftFromContainer);
         }
       }
	  });
	}
	
	megaMenu();
	$(window).smartresize(function(){
		megaMenu();
		dt_smart_resize_block();
	});
	
	//Menu Hover Animation...
	$("li.menu-item-depth-0,li.menu-item-simple-parent ul li" ).mouseenter(function() {
		//mouseenter
		if( $(this).find(".megamenu-child-container").length  ){
			$(this).find(".megamenu-child-container").stop().fadeIn('normal');
		} else {
			$(this).find("> ul.sub-menu").stop().fadeIn('normal');
		}
		
	}).mouseleave(function() {
		//mouseleave
		if( $(this).find(".megamenu-child-container").length ){
			$(this).find(".megamenu-child-container").stop().fadeOut('fast');
		} else {
			$(this).find('> ul.sub-menu').stop().fadeOut('fast');
		}
	});
	
	//Select arrow
	$("select").each(function(){
		if($(this).css('display') != 'none') {
			$(this).wrap( '<div class="selection-box"></div>' );
		}
	});
	
	//ONEPAGE NAV...
	if( $(".onepage_menu").length) {
	    $('.onepage_menu').onePageNav({
			currentClass: 'current_page_item',
    	    filter: ':not(.external)',
	        scrollSpeed: 750,
    	    scrollOffset: 90
	    });
	}

	//NICE SCROLL...
	if(typeof mytheme_urls !== 'undefined') {
        if (mytheme_urls.scroll == "enable" && $(window).width() > 767 && ! navigator.userAgent.match(/(Android|iPod|iPhone|iPad|IEMobile|Opera Mini)/) && ! navigator.platform.match(/(Mac|iPhone|iPod|iPad)/i)) {
			$("html").niceScroll({
				zindex: 999999,
				cursorborder: "1px solid #424242"
			});
        }
    }

	//STICKY NAV MENU....
	if(mytheme_urls.stickynav === "enable") {
		$("#header-wrapper").sticky({ topSpacing: 0 });
	}
	
	//MOBILE MENU...
	$('nav#main-menu').meanmenu({ meanMenuContainer :  $('.menu-main-menu-container #primary-menu'), meanRevealPosition:  'right', meanScreenWidth : 767 , meanRemoveAttrs: true });

	var currentWidth = window.innerWidth || document.documentElement.clientWidth;
	if( currentWidth > 767 ) {
		if( $('#primary').hasClass('with-left-sidebar') ) {
			if( $('#secondary').is(':empty') ){
				$('#primary').addClass("content-full-width").removeClass("with-left-sidebar");
			}
		} else if( $('#primary').hasClass('with-right-sidebar') ) {
			if( $('#secondary').is(':empty') ){
				$('#primary').addClass("content-full-width").removeClass("with-right-sidebar");
			}
		}
	}
								
	//TEXTBOX CLEAR...
	$('input.Textbox, textarea.Textbox').focus(function() {
      if (this.value === this.title) {
        $(this).val("");
      }}).blur(function() {
      if (this.value === "") {
        $(this).val(this.title);
      }
    });
	
	//UI TO TOP PLUGIN...
	$().UItoTop({ easingType: 'easeOutQuart' });
	
	//DONUT CHART...
	$('.donutChart').each(function(){
		$(this).one('inview', function (event, visible) {
			if(visible === true) {
				var bgcolor, fgcolor = "";
				
				if($(this).attr('data-bgcolor') !== "") bgcolor = $(this).attr('data-bgcolor'); else bgcolor = '#f5f5f5';
				if($(this).attr('data-fgcolor') !== "") fgcolor = $(this).attr('data-fgcolor'); else fgcolor = '#E74D3C';
				
				$(this).donutchart({'size': 140, 'donutwidth': 10, 'fgColor': fgcolor, 'bgColor': bgcolor, 'textsize': 45 });
				$(this).donutchart('animate');
			}
		}); 
	});
	
	$(window).on('load', function(){
		var $container = $('.gallery-container');
		var $gw;
	
		if ($('.gallery-container .gallery').hasClass('with-sidebar')) {
			if ($(".container").width() == 710 && ($('.gallery-container .gallery').hasClass('dt-sc-one-half') || $('.gallery-container .gallery').hasClass('dt-sc-one-fourth'))) {
				$gw = 10;
			} else {
				$gw = 14;
			}
		} else {
			if (($(".container").width() == 710 || $(".container").width() == 900) && ($('.gallery-container .gallery').hasClass('dt-sc-one-half') || $('.gallery-container .gallery').hasClass('dt-sc-one-fourth'))) {
				$gw = 15;
			} else {
				$gw = 20;
			}
		}
		if ($('.gallery-container .gallery').hasClass('no-space')) {
			$gw = 0;
		}
	
		if ($container.length) {
			$container.isotope({
				filter: '*',
				animationOptions: {
					duration: 750,
					easing: 'linear',
					queue: false
				},
				masonry: {
					columnWidth: $('.gallery-container .gallery').width(),
					gutter: $gw
				}
			});
			$container.isotope('reloadItems');
		}
	
		$('.sorting-container a').on('click',function () {
			$('.sorting-container').find('a').removeClass('active-sort');
			$(this).addClass('active-sort');
	
			var selector = $(this).attr('data-filter');
			$container.isotope({
				filter: selector,
				animationOptions: {
					duration: 750,
					easing: 'linear',
					queue: false
				},
				masonry: {
					columnWidth: $('.gallery-container .gallery').width(),
					gutter: $gw
				}
			});

		    // don't proceed if no Shadowbox yet
			//if ( !shadowbox ) {
			// return false;
			//}

			//shadowbox.clearCache();

			var $sortedItems = $container.data('isotope').$filteredAtoms;
			console.log($container);

			//$container.data('isotope').$filteredAtoms.each(function(){
				//console.log($(this));
				//shadowbox.addCache( $(this).find('a[data-gal^="prettyPhoto[gallery]"]')[0] );
			//});

			return false;
		});

		dt_smart_resize_block();
	});

    //PrettyPhoto...	
    var $pphoto = $('a[data-gal^="prettyPhoto[gallery]"]');
    if ($pphoto.length) {
        //PRETTYPHOTO...
        $("a[data-gal^='prettyPhoto[gallery]']").prettyPhoto({
			hook:'data-gal',
            show_title: false,
            social_tools: false,
            deeplinking: false
        });
    }
	
    //Gallery CarouFredSel...
	if( ($(".gallery-slider").length) && ($(".gallery-slider li").length > 1) ) {
		$('.gallery-slider').bxSlider({ auto:false, video:true, useCSS:false, pager:'', autoHover:true, adaptiveHeight:true });
	}
	
	//Flickr...
	$('.flickrs div.flickr_badge_image:nth-child(3n+4)').addClass('last');
	
	//Gallery Carousel...
	if($(".gallery-carousel-wrapper").length) {
      $('.gallery-carousel-wrapper').carouFredSel({
        responsive: true,
		auto: false,
		width: '100%',
		prev: '.prev-arrow',
		next: '.next-arrow',
		height: 'auto',
		scroll: 1,
		items: { width: 220,  visible: { min: 1, max: 4 } }
      });
	}
	
	//Reviews Carousel...
	if($(".reviews-carousel-wrapper").length) {
      $('.reviews-carousel-wrapper').carouFredSel({
        responsive: true,
		width: '100%',
		scroll: {
			fx: "crossfade"
		},
		auto: {
			pauseDuration: 5000,
		},
		items: {
			height: 'variable',
			visible: {
				min: 1,
				max: 1
			}
		}
      });
	}
	
	//Fitvids...
	$("div.dt-video-wrap").fitVids();
	$('.wp-video').css('width', '100%');
	
	//Gallery Blog Slider...
    if( ($("ul.entry-gallery-post-slider").length) && ( $("ul.entry-gallery-post-slider li").length > 1 ) ){
     $("ul.entry-gallery-post-slider").bxSlider({auto:false, video:true, useCSS:false, pager:'', autoHover:true, adaptiveHeight:true});
    }
	
	//Parallax Sections...
	$('.dt-sc-parallax-section').on('inview', function (event, visible) {
		if(visible === true) {
			$(this).parallax("50%", 0.5);
		} else {
			$(this).css('background-position', '');
		}
	});

	//Team ajax load...	
	if ( $(window).innerWidth() > 1102 ) {
		$("a[data-gal^='prettyPhoto[pp_gal]']").prettyPhoto({ deeplinking: false, default_width: 930, default_height: 500 });
    } else if ( $(window).innerWidth() > 900 ) {
		$("a[data-gal^='prettyPhoto[pp_gal]']").prettyPhoto({ deeplinking: false, default_width: 770, default_height: 430 });
    } else if ( $(window).innerWidth() > 748 ) {
		$("a[data-gal^='prettyPhoto[pp_gal]']").prettyPhoto({ deeplinking: false, default_width: 700, default_height: 400 });
    } else if ( $(window).innerWidth() > 420 || $(window).innerWidth() < 420) {
		$("a[data-gal^='prettyPhoto[pp_gal]']").prettyPhoto({ deeplinking: false, default_width: 190, default_height: 350, social_tools: false });
	}

	$(window).on('load', function(){
		//Events Carousel...
		if( ($(".dt-event-carousel").length) && ( $(".dt-event-carousel div").length > 1 ) ){
			$(".dt-event-carousel").each(function() {
				$(this).bxSlider({ minSlides: 1, maxSlides: 1, pager: false, useCSS: false, prevText: '', nextText: '' });
			});
		}
	
		// Course Carousel...
		if(($(".dt-courses-carousel").length) && ( $(".dt-courses-carousel div").length > 1 ) ){
			$(".dt-courses-carousel").each(function() {
			  //Getting values...			
			  var $prev = $(this).find('.prev-arrow');
			  var $next = $(this).find('.next-arrow');
			  var $w = $(this).find('.column').width();
			  $(this).carouFredSel({
				responsive: true,
				auto: false,
				width: '100%',
				prev: '.prev-arrow',
				next: '.next-arrow',
				height: 'auto',
				scroll: 1,
				items: { width: $w,  visible: { min: 1, max: 3 } }
			  });
			});
		}
	});			
	
	//Animate Number...
	$('.dt-sc-num-count').each(function(){
	  $(this).one('inview', function (event, visible) {
		  if(visible === true) {
			  var val = $(this).attr('data-value');
			  $(this).animateNumber({ number: val	}, 2000);
		  }
	  });
	});

	
	// Gutenberg - Fullwidth Section Fix
	$('.alignfull').each(function() {
		if($(this).parents('body').hasClass('has-gutenberg-blocks') && $(this).parents('#primary').hasClass('content-full-width')) {
			if($(this).parents('body').hasClass('layout-boxed')) {
				var containerWidth = $('.layout-boxed .wrapper').width();
				$(this).css('width', containerWidth);

				var mainLeft = $('#main').offset().left;
				var primaryLeft = $('#primary').offset().left;

				var sectionMargin = parseInt(primaryLeft, 10) - parseInt(mainLeft, 10);

				var offset = 0 - sectionMargin;
				$(this).css('left', offset);
			} else {

				var windowWidth = $(window).width();
				$(this).css('width', windowWidth);

				var $container = '';

				$container = $(this).parents('.entry-detail').find('p');
				if(!$container.length) {
					$container = $(this).parents('.content-full-width');
				}

				var offset = 0 - $container.offset().left;
				$(this).css('left', offset);
			}
		}
	});

	// Gutenberg - WP Category Widget Fix
	if($('.wp-block-categories-list').length) {

		$('.wp-block-categories-list').find('li').each(function() {

			var span_text = $(this).find('span:first').html();
			$(this).find('span:first').remove()
			$('<span>'+span_text+'</span>').insertAfter($(this).find('a:first')); 
			
		});

	}

});

// ANUMATE CSS + JQUERY INVIEW CONFIGURATION
(function ($) {
    "use strict";
    $(".animate").each(function () {
        $(this).on('inview', function (event, visible) {
            var $delay = "";
            var $this = $(this),
                $animation = ($this.data("animation") !== undefined) ? $this.data("animation") : "slideUp";
            $delay = ($this.data("delay") !== undefined) ? $this.data("delay") : 300;

            if (visible === true) {
                setTimeout(function () {
                    $this.addClass($animation);
                }, $delay);
            } else {
                setTimeout(function () {
                    $this.removeClass($animation);
                }, $delay);
            }
        });
    });
})(jQuery);

function dt_smart_resize_block() {
	//Blog Isotope...
	if( jQuery(".blog-isotope-wrapper").length ){
		var $gw = 19; if(jQuery(".container").width() == 710 || jQuery('.blog-isotope-wrapper .column').hasClass('with-sidebar')) { $gw = 14; }

		jQuery(".blog-isotope-wrapper").isotope({
			itemSelector : '.column',
			transformsEnabled: false,
			masonry: {
				gutter: $gw
			}
		});
	}
}
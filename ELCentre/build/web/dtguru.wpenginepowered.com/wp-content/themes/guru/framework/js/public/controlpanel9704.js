if (typeof mytheme_urls === 'undefined') {
    var mytheme_urls = "";
}
var $patterns = "";
for (var i = 1; i <= 13; i++) {
    var $img = mytheme_urls.theme_base_url + "images/style-picker/pattern" + i + ".jpg";
    $patterns += '<li>';
    $patterns += '<a id="pattern' + i + '"  href="" title="">';
    $patterns += '<img src="' + $img + '" alt="pattern' + i + '" title="pattern' + i + '"/>';
    $patterns += '</a>';
    $patterns += '</li>';
}

var $color = [ "dark-blue", 'cyan', 'cyan-yellow', 'dark-pink', 'grayish-blue', 'grayish-green', 'grayish-orange', 'light-red', 'magenta', 'orange', 'pink', 'white-avocado', 'white-blueiris', 'white-brown', 'white-chillipepper'];
var $colors = "";
for (var i = 0; i < $color.length; i++) {
    $img = mytheme_urls.theme_base_url + "images/style-picker/" + $color[i] + ".jpg";
    $colors += '<li>';
    $colors += '<a id="' + $color[i] + '" href="" title="">';
    $colors += '<img src="' + $img + '" alt="color-' + $color[i] + '" title="color-' + $color[i] + '"/>';
    $colors += '</a>';
    $colors += '</li>';
}

var $str = '<!-- **DT Style Picker Wrapper** -->';
$str += '<div class="dt-style-picker-wrapper">';
$str += '	<a href="" title="" class="style-picker-ico"> <img src="' + mytheme_urls.theme_base_url + 'images/style-picker/picker-icon.jpg" alt="" title="" /> </a>';
$str += '	<div id="dt-style-picker">';
$str += '    <h2> Select Style </h2>';
$str += '    <h3> Choose your layout </h3>';
$str += '    <ul class="layout-picker">';
$str += '     <li> <a id="fullwidth" href="" title="" class="selected"> <img src="' + mytheme_urls.theme_base_url + 'images/style-picker/fullwidth.jpg" alt="" title="" /> </a> </li>';
$str += '     <li> <a id="boxed" href="" title=""> <img src="' + mytheme_urls.theme_base_url + 'images/style-picker/boxed.jpg" alt="" title="" /> </a> </li>';
$str += '		</ul>';
$str += '		<div class="hr"> </div>';
$str += '		<div id="pattern-holder" style="display:none;">';
$str += '			<h3> Patterns for Boxed Layout </h3>';
$str += '			<ul class="pattern-picker">';
$str += $patterns;
$str += '			</ul>';
$str += '			<div class="hr"> </div>';
$str += '		</div>';
$str += '		<div class="color-scheme">';
$str += '		  <h3> Color scheme </h3>';
$str += '		  <ul class="color-picker">';
$str += $colors;
$str += '		  </ul>';
$str += '		</div>';
$str += '	</div>';
$str += '</div><!-- **DT Style Picker Wrapper - End** -->';

jQuery(document).ready(function ($) {
    "use strict";
    $("body > .main-content > div#wrapper").before($str);
    var $picker_container = $("div.dt-style-picker-wrapper");

    //Applying Cookies
    if ($.cookie('control-open') == 1) {
        $picker_container.animate({
            left: -230
        });
        $('a.style-picker-ico').addClass('control-open');
    }

    //Check Cookies in diffent pages and do the following things
    if ($.cookie("gurutheme_skin") != null) {
		var $href = mytheme_urls.theme_base_url + 'skins/' + $.cookie("gurutheme_skin") + "/style.css";
        $("link[id='guru-skin-css']").attr("href", $href);
        $("ul.color-picker a[id='" + $.cookie("gurutheme_skin") + "']").addClass("selected");
    } else {
        $("ul.color-picker a:first").addClass("selected");
    }

    //Apply Layout
    if ($.cookie("gurutheme_layout") == "boxed") {
        $("ul.layout-picker li a").removeAttr("class");
        $("ul.layout-picker li a[id='" + $.cookie("gurutheme_layout") + "']").addClass("selected");
        $("div#pattern-holder").removeAttr("style");

        var $i = ($.cookie("gurutheme_pattern")) ? $.cookie("gurutheme_pattern") : 'pattern1';
        $img = mytheme_urls.theme_base_url + "images/patterns/" + $i + ".jpg";
        $('body').css('background-image', 'url(' + $img + ')').addClass('boxed');
        $("ul.pattern-picker a[id=" + $.cookie("gurutheme_pattern") + "]").addClass('selected');
    }
    //Applying Cookies End

    //Picker On/Off
    $("a.style-picker-ico").on('click',function (e) {
        var $this = $(this);
        if ($this.hasClass('control-open')) {
            $picker_container.animate({
                left: 0
            }, function () {
                $this.removeClass('control-open');
            });
            $.cookie('control-open', 0);
        } else {
            $picker_container.animate({
                left: -230
            }, function () {
                $this.addClass('control-open');
            });
            $.cookie('control-open', 1);
        }
        e.preventDefault();
    }); //Picker On/Off end

    //Layout Picker
    $("ul.layout-picker a").on('click',function (e) {
        var $this = $(this);
        $("ul.layout-picker a").removeAttr("class");
        $this.addClass("selected");
        $.cookie("gurutheme_layout", $this.attr("id"));

        if ($.cookie("gurutheme_layout") === "boxed") {
            $("body").addClass("boxed");
            $("div#pattern-holder").slideDown();

            if ($.cookie("gurutheme_pattern") === null) {
                $("ul.pattern-picker a:first").addClass('selected');
                $.cookie("gurutheme_pattern", "pattern1", {
                    path: '/'
                });
            } else {
                $("ul.pattern-picker a[id=" + $.cookie("gurutheme_pattern") + "]").addClass('selected');
                $img = mytheme_urls.theme_base_url + "images/patterns/" + $.cookie("gurutheme_pattern") + ".jpg";
                $('body').css('background-image', 'url(' + $img + ')');
            }
        } else {
            $("body").removeAttr("style").removeClass("boxed");
            $("div#pattern-holder").slideUp();
            $("ul.pattern-picker a").removeAttr("class");
        }
        window.location.href = location.href;
        e.preventDefault();
    }); //Layout Picker End

    //Pattern Picker
    $("ul.pattern-picker a").on('click',function (e) {
        if ($.cookie("gurutheme_layout") == "boxed") {
            var $this = $(this);
            $("ul.pattern-picker a").removeAttr("class");
            $this.addClass("selected");
            $.cookie("gurutheme_pattern", $this.attr("id"), {
                path: '/'
            });
            $img = mytheme_urls.theme_base_url + "images/patterns/" + $.cookie("gurutheme_pattern") + ".jpg";
            $('body').css('background-image', 'url(' + $img + ')');
        }
        e.preventDefault();
    }); //Pattern Picker End


    //Color Picker
    $("ul.color-picker a").on('click', function(e){
        var $this = $(this);
        $("ul.color-picker a").removeAttr("class");
        $this.addClass("selected");
        $.cookie("gurutheme_skin", $this.attr("id"), {
            path: '/'
        });

        var $href = mytheme_urls.theme_base_url + 'skins/' + $this.attr("id") + "/style.css";
        $("link[id='guru-skin-css']").attr("href", $href);
        e.preventDefault();
    }); //Color Picker End

});
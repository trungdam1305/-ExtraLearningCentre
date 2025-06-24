<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<body class="bp-legacy page-template-default page page-id-2385 page-child parent-pageid-45 wp-embed-responsive theme-guru woocommerce-js tribe-js js"><div id="yith-wcwl-popup-message" style="display: none;"><div id="yith-wcwl-message"></div></div>
			  <!-- breadcrumb ends here -->
	  <!-- content starts here -->
	  <div class="content">
          <div class="container">
              <section class="with-left-sidebar" id="primary">
                  <article id="post-2385" class="post-2385 page type-page status-publish hentry">
                      <div class="woocommerce columns-4">
                                <ul class="products columns-4" style="display: flex; flex-wrap: wrap; gap: 3px; padding: 0; list-style: none;">
                                    <c:forEach var="khoaHoc" items="${khoaHocList}">
                                        <li class="post product type-product post-${khoaHoc.ID_KhoaHoc} status-publish instock has-post-thumbnail product-type-simple"
                                            style="flex: 0 0 calc(25% - 20px); box-sizing: border-box; display: flex; flex-direction: column; border: 1px solid #ddd; border-radius: 8px; overflow: hidden; background-color: #fff; min-height: 300px;" data-idkhoi="${khoaHoc.ID_Khoi}">
                                            <div class="product-wrapper" style="display: flex; flex-direction: column; height: 100%;">
                                                <div class="product-thumb" style="text-align: center;">
                                                    <a href="#" class="woocommerce-LoopProduct-link woocommerce-loop-product__link">
                                                        <img src="${pageContext.request.contextPath}/img/avatar/${khoaHoc.image}"
                                                             alt="${khoaHoc.tenKhoaHoc}" width="100%" height="auto"
                                                             style="object-fit: cover; height: 200px;" />
                                                    </a>
                                                    <a href="#" class="small button product_type_simple add_to_cart_button ajax_add_to_cart" data-product_id="${khoaHoc.ID_KhoaHoc}" rel="nofollow" style="font-size: 12px; padding: 5px;"> 
                                                        Đăng Ký Nhận Tư Vấn 
                                                    </a>
                                                </div>

                                                <div class="product-title" style="padding: 10px; flex-grow: 0;">
                                                    <a href="#">
                                                        <h2 class="woocommerce-loop-product__title" style="font-size: 16px; min-height: 48px;">${khoaHoc.tenKhoaHoc}</h2>
                                                    </a>
                                                </div>

                                                <div class="product-details" style="padding: 0 10px 10px 10px; flex-grow: 1;">
                                                    <p style="font-size: 14px; max-height: 60px; overflow: hidden; text-overflow: ellipsis;">${khoaHoc.moTa}</p>
                                                    <span class="price" style="margin-top: auto;">
                                                        <span class="woocommerce-Price-amount amount">
                                                            <bdi>
                                                                <a href="#" class="woocommerce-Price-currencySymbol">Xem Chi Tiết Khóa Học</a>
                                                            </bdi>
                                                        </span>
                                                    </span>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                                    <div class="pagination" style="text-align: center; margin-top: 20px;">
                                        <c:forEach begin="1" end="${totalPage}" var="i">
                                            <a href="?page=${i}" style="
                                                display: inline-block;
                                                margin: 0 5px;
                                                padding: 8px 12px;
                                                background-color: ${i == currentPage ? '#007bff' : '#f0f0f0'};
                                                color: ${i == currentPage ? 'white' : 'black'};
                                                text-decoration: none;
                                                border-radius: 4px;
                                            ">
                                                ${i}
                                            </a>
                                        </c:forEach>
                                    </div>                 
                            </div>
                <div class="social-bookmark"></div>                  
                  </article>
              </section>
              <section class="left-sidebar" id="secondary">
                  <div><h3>Tìm kiếm Khóa Học</h3>
                          
                      </div>
                    <form method="get" action="HomePageCourse">
                        <select name="ID_Khoi" style="margin-top: 10px; width: 100%; padding: 6px;">
                            <option value="">-- Tất Cả Khối Học --</option>
                            <c:forEach var="mh" items="${allKhoi}">
                                <option value="${mh.ID_Khoi}" ${param.ID_Khoi == mh.ID_Khoi ? 'selected' : ''}>
                                    ${mh.tenKhoi}
                                </option>
                            </c:forEach>
                        </select>

                        <input type="text" name="keyword" placeholder="Tìm Khóa Học" value="${param.keyword}" />
                        <button type="submit">Lọc / Tìm</button>
                    </form>
                  <aside id="woocommerce_product_categories-7" class="widget woocommerce widget_product_categories">
                        <div class="widget-title"><h3>Phân loại khóa học</h3><div class="title-sep"><span></span></div>
                        </div>
                        <li>
                            <a href="#" title="">Toán <span>${numToan}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Văn <span>${numVan}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Anh <span>${numAnh}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Lý <span>${numLy}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Hóa <span>${numHoa}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Sinh <span>${numSinh}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Sử <span>${numSu}</span></a> 
                        </li>
                        <li>
                            <a href="#" title="">Địa <span>${numDia}</span></a> 
                        </li>
                    </aside>
              </section>
                      	
          </div>
      </div>
    </div>
</div>

    
		<script>
		( function ( body ) {
			'use strict';
			body.className = body.className.replace( /\btribe-no-js\b/, 'tribe-js' );
		} )( document.body );
		</script>
		<script> /* <![CDATA[ */var tribe_l10n_datatables = {"aria":{"sort_ascending":": activate to sort column ascending","sort_descending":": activate to sort column descending"},"length_menu":"Show _MENU_ entries","empty_table":"No data available in table","info":"Showing _START_ to _END_ of _TOTAL_ entries","info_empty":"Showing 0 to 0 of 0 entries","info_filtered":"(filtered from _MAX_ total entries)","zero_records":"No matching records found","search":"Search:","all_selected_text":"All items on this page were selected. ","select_all_link":"Select all pages","clear_selection":"Clear Selection.","pagination":{"all":"All","next":"Next","previous":"Previous"},"select":{"rows":{"0":"","_":": Selected %d rows","1":": Selected 1 row"}},"datepicker":{"dayNames":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"dayNamesShort":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"dayNamesMin":["S","M","T","W","T","F","S"],"monthNames":["January","February","March","April","May","June","July","August","September","October","November","December"],"monthNamesShort":["January","February","March","April","May","June","July","August","September","October","November","December"],"monthNamesMin":["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"nextText":"Next","prevText":"Prev","currentText":"Today","closeText":"Done","today":"Today","clear":"Clear"}};/* ]]> */ </script>	<script type="text/javascript">
		(function () {
			var c = document.body.className;
			c = c.replace(/woocommerce-no-js/, 'woocommerce-js');
			document.body.className = c;
		})()
	</script>
	<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.tipTip.minified.js?ver=6.7.1" id="dt-tooltip-sc-script-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.tabs.min.js?ver=6.7.1" id="dt-tabs-script-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.viewport.js?ver=6.7.1" id="dt-viewport-script-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.toggle.click.js?ver=6.7.1" id="dt-sc-toggle-click-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/shortcodes.js?ver=6.7.1" id="dt-sc-script-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/yith-woocommerce-wishlist/assets/js/jquery.selectBox.min.js?ver=1.2.0" id="jquery-selectBox-js"></script>
<script type="text/javascript" id="jquery-yith-wcwl-js-extra">
/* <![CDATA[ */
var yith_wcwl_l10n = {"ajax_url":"\/wp-admin\/admin-ajax.php","redirect_to_cart":"no","multi_wishlist":"","hide_add_button":"1","enable_ajax_loading":"","ajax_loader_url":"https:\/\/dtguru.wpengine.com\/wp-content\/plugins\/yith-woocommerce-wishlist\/assets\/images\/ajax-loader-alt.svg","remove_from_wishlist_after_add_to_cart":"1","is_wishlist_responsive":"1","time_to_close_prettyphoto":"3000","fragments_index_glue":".","reload_on_found_variation":"1","labels":{"cookie_disabled":"We are sorry, but this feature is available only if cookies on your browser are enabled.","added_to_cart_message":"<div class=\"woocommerce-notices-wrapper\"><div class=\"woocommerce-message\" role=\"alert\">Product added to cart successfully<\/div><\/div>"},"actions":{"add_to_wishlist_action":"add_to_wishlist","remove_from_wishlist_action":"remove_from_wishlist","reload_wishlist_and_adding_elem_action":"reload_wishlist_and_adding_elem","load_mobile_action":"load_mobile","delete_item_action":"delete_item","save_title_action":"save_title","save_privacy_action":"save_privacy","load_fragments":"load_fragments"}};
/* ]]> */
</script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/yith-woocommerce-wishlist/assets/js/jquery.yith-wcwl.js?ver=3.0.17" id="jquery-yith-wcwl-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-includes/js/comment-reply.min.js?ver=6.7.1" id="comment-reply-js" async="async" data-wp-strategy="async"></script>
<script type="text/javascript" id="contact-form-7-js-extra">
/* <![CDATA[ */
var wpcf7 = {"apiSettings":{"root":"https:\/\/dtguru.wpengine.com\/wp-json\/contact-form-7\/v1","namespace":"contact-form-7\/v1"},"cached":"1"};
/* ]]> */
</script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/contact-form-7/includes/js/scripts.js?ver=5.3.2" id="contact-form-7-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/designthemes-fb-pixel/script.js?ver=6.7.1" id="dt-fbpixel-script-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/jquery-blockui/jquery.blockUI.min.js?ver=2.70" id="jquery-blockui-js"></script>
<script type="text/javascript" id="wc-add-to-cart-js-extra">
/* <![CDATA[ */
var wc_add_to_cart_params = {"ajax_url":"\/wp-admin\/admin-ajax.php","wc_ajax_url":"\/?wc-ajax=%%endpoint%%","i18n_view_cart":"View cart","cart_url":"https:\/\/dtguru.wpengine.com\/cart\/","is_cart":"","cart_redirect_after_add":"no"};
/* ]]> */
</script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/frontend/add-to-cart.min.js?ver=4.8.3" id="wc-add-to-cart-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/js-cookie/js.cookie.min.js?ver=2.1.4" id="js-cookie-js"></script>
<script type="text/javascript" id="woocommerce-js-extra">
/* <![CDATA[ */
var woocommerce_params = {"ajax_url":"\/wp-admin\/admin-ajax.php","wc_ajax_url":"\/?wc-ajax=%%endpoint%%"};
/* ]]> */
</script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/frontend/woocommerce.min.js?ver=4.8.3" id="woocommerce-js"></script>
<script type="text/javascript" id="wc-cart-fragments-js-extra">
/* <![CDATA[ */
var wc_cart_fragments_params = {"ajax_url":"\/wp-admin\/admin-ajax.php","wc_ajax_url":"\/?wc-ajax=%%endpoint%%","cart_hash_key":"wc_cart_hash_7744c75059fc33b0412f73e1f3599070","fragment_name":"wc_fragments_7744c75059fc33b0412f73e1f3599070","request_timeout":"5000"};
/* ]]> */
</script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/frontend/cart-fragments.min.js?ver=4.8.3" id="wc-cart-fragments-js"></script>
<script type="text/javascript" id="wp-postratings-js-extra">
/* <![CDATA[ */
var ratingsL10n = {"plugin_url":"https:\/\/dtguru.wpengine.com\/wp-content\/plugins\/wp-postratings","ajax_url":"https:\/\/dtguru.wpengine.com\/wp-admin\/admin-ajax.php","text_wait":"Please rate only 1 item at a time.","image":"stars_crystal","image_ext":"gif","max":"5","show_loading":"1","show_fading":"1","custom":"0"};
var ratings_mouseover_image=new Image();ratings_mouseover_image.src="https://dtguru.wpenginepowered.com/wp-content/plugins/wp-postratings/images/stars_crystal/rating_over.gif";;
/* ]]> */
</script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/wp-postratings/js/postratings-js.js?ver=1.89" id="wp-postratings-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/prettyPhoto/jquery.prettyPhoto.min.js?ver=3.1.6" id="prettyPhoto-js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/html5shiv.min.js?ver=3.7.2" id="jq-html5-js"></script>
<![endif]-->
<!--[if lt IE 8]>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/excanvas.js?ver=2.0" id="jq-canvas-js"></script>
<![endif]-->
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/retina.js?ver=6.7.1" id="retina-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.sticky.js?ver=6.7.1" id="jquery-stickynav-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.smartresize.js?ver=6.7.1" id="jquery-smartresize-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery-smoothscroll.js?ver=6.7.1" id="jquery-smoothscroll-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery-easing-1.3.js?ver=6.7.1" id="jquery-easing-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.inview.js?ver=6.7.1" id="jquery-inview-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.validate.min.js?ver=6.7.1" id="jquery-validate-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.carouFredSel-6.2.0-packed.js?ver=6.7.1" id="jquery-caroufredsel-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.isotope.min.js?ver=6.7.1" id="jquery-isotope-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.prettyPhoto.js?ver=6.7.1" id="jquery-prettyphoto-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.ui.totop.min.js?ver=6.7.1" id="jquery-uitotop-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/jquery-cookie/jquery.cookie.min.js?ver=1.4.1" id="jquery-cookie-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.meanmenu.js?ver=6.7.1" id="jquery-meanmenu-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/contact.js?ver=6.7.1" id="guru-contact-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.donutchart.js?ver=6.7.1" id="jquery-donutchart-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.fitvids.js?ver=6.7.1" id="jquery-fitvids-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.bxslider.js?ver=6.7.1" id="jquery-bxslider-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.parallax-1.1.3.js?ver=6.7.1" id="jquery-parallax-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.animateNumber.min.js?ver=6.7.1" id="jquery-animateNumber-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/custom.js?ver=6.7.1" id="guru-custom-js"></script>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/magnific/jquery.magnific-popup.min.js?ver=6.7.1" id="jquery-magnific-popup-js"></script>

<a href="#" id="toTop" style="display: none;"><span id="toTopHover"></span>To Top</a><div id="extension-mmplj"></div></body>
</html>
    

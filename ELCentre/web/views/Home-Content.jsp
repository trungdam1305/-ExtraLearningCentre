<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Trung Tâm Đào Tạo</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
        }
        h1, h2, h3, h4, h5, h6 {
             font-family: 'Be Vietnam Pro', sans-serif;
        }
        
        .course-category-card .dt-sc-course-meta {
            display: flex;
            justify-content: space-between; 
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
         .course-category-card .dt-sc-course-meta:last-child {
            border-bottom: none;
        }
        .course-category-card .dt-sc-course-meta a {
            float: none !important; 
            margin-right: 0 !important;
            font-weight: 700;
        }
    </style>
</head>

<body>
    <div class="banner">
        <div id="layerslider_1_5r4q8o8aqo3t" class="ls-wp-container fitvidsignore" style="width:1000px;height:630px;margin:0 auto;margin-bottom: 0px; position: relative;">
            <c:forEach var="slide" items="${sliders}">
                <div class="ls-slide" data-ls="duration:5000;transition2d:1,4;timeshift:-1000;">
                    <img src="${pageContext.request.contextPath}/${slide.image}" class="ls-bg" alt="${slide.title}" decoding="async" fetchpriority="high" style='height:530px; width: 1024px'/>
                    <p class="ls-l" style="position: absolute;top: 0px;left: 10px;margin: 0;font-weight: bold;text-transform: uppercase;font-size: 35px;color: #355c7d;pointer-events: none;white-space: nowrap;">
                        ${slide.title}
                    </p>
                    <a href="${slide.backLink}" class="ls-l" style="position: absolute;top: 5px;left: 840px;padding: 10px 20px;background: rgba(0,0,0,0.5);color: #fff;text-decoration: none;font-weight: bold;white-space: nowrap;">
                        Xem chi tiết
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
      
    <div class="content">
        <section class="content-full-width" id="primary">
            <article id="post-8" class="post-8 page type-page status-publish hentry">
                <!--Slogan-->
                <div class='fullwidth-section' style="background-repeat:no-repeat;background-position:left top;">
                    <div class="fullwidth-bg">    
                        <div class="container">
                            <div class='column dt-sc-one-fourth first'>
                                <div class="dt-sc-services">
                                    <div class="dt-sc-iconbox"><div class="dt-sc-icon"><img decoding="async" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/uploads/2014/05/service-ico1.png" alt="service-alt" /></div></div>
                                    <h3>Giảng dạy dễ hiểu</h3>
                                    <span>Học theo cách tốt nhất</span>
                                    <p>Hehe Huhuhu Tung tung tung sahur</p>
                                </div>
                            </div>
                            <div class='column dt-sc-one-fourth'>
                                <div class="dt-sc-services">
                                    <div class="dt-sc-iconbox"><div class="dt-sc-icon"><img decoding="async" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/uploads/2014/05/service-ico2.png" alt="service-alt" /></div></div>
                                    <h3>Khóa Học Sáng Tạo</h3>
                                    <span>Cách giảng dạy thông minh</span>
                                    <p>Bululbulu bombini guchini tralalero tralala</p>
                                </div>
                            </div>
                            <div class='column dt-sc-one-fourth'>
                                <div class="dt-sc-services">
                                    <div class="dt-sc-iconbox"><div class="dt-sc-icon"><img decoding="async" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/uploads/2014/05/service-ico3.png" alt="service-alt" /></div></div>
                                    <h3>Ý Tưởng Độc Đáo</h3>
                                    <span>Đóng góp vào bài giảng</span>
                                    <p>Cappuchino Assassino Brrr Brrr Patapim</p>
                                </div>
                            </div>
                            <div class='column dt-sc-one-fourth'>
                                <div class="dt-sc-services">
                                    <div class="dt-sc-iconbox"><div class="dt-sc-icon"><img decoding="async" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/uploads/2014/05/service-ico4.png" alt="service-alt" /></div></div>
                                    <h3>Cơ sở vật chất xịn xò</h3>
                                    <span>Up-to-date Phòng học</span>
                                    <p>Bombadiro Crocodilo Ballerina Cappuchina</p>
                                </div>
                            </div>
                            <div class='dt-sc-hr-invisible'></div>      
                        </div>
                    </div>
                </div>
                <!--Hot Teacher-->
                <div class="fullwidth-section" style="padding: 60px 0; background-color: #f8f9fa;">
                    <div class="container">
                        <div class='hr-title'><h2>Đội Ngũ Của Chúng Tôi</h2><div class='title-sep'><span></span></div></div>
                        <c:forEach var="gv" items="${listSpecialGV}" varStatus="status">
                            <div class="column dt-sc-one-fifth ${status.first ? 'first' : ''}">
                                <div class="dt-sc-team">
                                    <div class="dt-sc-entry-thumb">
                                        <a href="#"><img fetchpriority="high" decoding="async" width="420" height="420" src="${pageContext.request.contextPath}/img/avatar/${gv.avatar}" class="attachment-full size-full wp-post-image" alt="${gv.hoTen}" title="${gv.hoTen}" sizes="(max-width: 420px) 100vw, 420px" /></a>
                                    </div>
                                    <div class="dt-sc-entry-title">
                                        <h2><a href="#">${gv.hoTen}</a></h2>
                                        <h6>${gv.chuyenMon}</h6>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class='dt-sc-hr-invisible-medium'></div>    
                    </div>
                </div>
                <!--Centre's Achievement-->
                <div class='fullwidth-section dt-sc-skin' style="background-color:#355C7D;">
                    <div class="fullwidth-bg">    
                        <div class="container">
                            <div class='dt-sc-hr-invisible'></div>
                             <div class='column dt-sc-one-third first'>
                                <div class="dt-sc-animate-num" >
                                    <div class="dt-sc-icon"><i class="fa fa-group"></i></div>
                                    <span class="dt-sc-num-count" data-value="${numHocSinh}" >${numHocSinh}</span>
                                    <h3 style="color:white">Số học sinh đã được trung tâm đào tạo</h3>
                                </div>
                            </div>
                            <div class='column dt-sc-one-third'>
                                <div class="dt-sc-animate-num">
                                    <div class="dt-sc-icon"><i class="fa fa-flag"></i></div>
                                    <span class="dt-sc-num-count" data-value="${numLopHoc}">${numLopHoc}</span>
                                    <h3 style="color:white">Số lớp học đã và đang hoạt động</h3>
                                </div>
                            </div>
                            <div class='column dt-sc-one-third'>
                                <div class="dt-sc-animate-num">
                                    <div class="dt-sc-icon"><i class="fa fa-book"></i></div>
                                    <span class="dt-sc-num-count" data-value="${numKhoaHoc}">${numKhoaHoc}</span>
                                    <h3 style="color:white">Khóa Học sẵn có</h3>
                                </div>
                            </div>
                            <div class='dt-sc-hr-invisible'></div>    
                        </div>
                    </div>                    
                </div>
                
                <!--Featured Class-->               
                            <div class="container">
                                <div class='dt-sc-hr-invisible-medium  '>
                                </div>
                                <div class='hr-title'>
                                    <h2 style= "font-family:'Open Sans'" >Các lớp học nổi bật</h2>
                                    <div class='title-sep'>
                                        <span></span>
                                    </div>
                                </div>
                                <div class="dt-courses-wrapper">
                                    <!--Arrow to next and prev-->
                                    <div class="course-carousel-arrows">
                                        <a class="prev-arrow fa fa-angle-left"></a>
                                        <a class="next-arrow fa fa-angle-right"></a>
                                    </div>
                                    <!--Information of Class-->
                                    <div class="dt-courses-carousel">
                                        <c:forEach var="lop" items="${lopHoc}" varStatus="status">
                                            <div class="column dt-sc-one-third">
                                                <article class="dt-sc-course">
                                                    <div class="dt-sc-course-thumb">
                                                        <a href="${pageContext.request.contextPath}/ClassDetailsServlet?classId=${lop.getID_LopHoc()}">
                                                            <img src="${pageContext.request.contextPath}/${lop.image}" 
                                                                 alt="${lop.tenLopHoc}" 
                                                                 style="width:100%; height:250px; object-fit: cover; border-radius: 5px;" />
                                                        </a>
                                                    </div>
                                                    <div class="dt-sc-course-content">
                                                        <p class="dt-sc-course-meta">
                                                            <a href="${pageContext.request.contextPath}/ClassDetailsServlet?classId=${lop.getID_LopHoc()}">Khóa học ID: ${lop.ID_KhoaHoc}</a>
                                                        </p>
                                                        <h2 class="dt-sc-course-title">
                                                            <a href="${pageContext.request.contextPath}/ClassDetailsServlet?classId=${lop.getID_LopHoc()}" style= "font-family:'Open Sans'; font-weight: bold;" >${lop.tenLopHoc}</a>
                                                        </h2>
                                                         <span class="dt-sc-lessons">Giáo viên chủ nhiệm: ${lop.tenGiaoVien}</span> <!-- Gợi ý đổi thành slotThoiGian -->
                                                    </div>
                                                </article>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>               
                                    
                <div class='fullwidth-section' style="padding: 60px 0;">
                    <div class="container">
                        <!--Secondary-School-->
                        <div class='hr-title'><h2>Trung Học Phổ Thông</h2><div class='title-sep'><span></span></div></div>
                        <c:forEach var="khoi" items="${listKhoi}">
                            <c:if test="${khoi.ID_Khoi > 4}">
                                <div class="column dt-sc-one-fourth first" style="margin-bottom: 30px; padding: 15px">
                                    <article id="post-${khoi.tenKhoi}" class="dt-sc-course post-${khoi.tenKhoi} course type-course course-category-card" style=" margin:15px;">
                                        <div class="dt-sc-course-thumb">
                                            <a href="#" title="${khoi.tenKhoi}"><img src="${pageContext.request.contextPath}/${khoi.image}" alt="${khoi.tenKhoi}" style="width:100%; height:180px; object-fit: cover; border-radius: 5px;" /></a>
                                        </div>
                                        <p style="font-weight: 700; font-size: 1.5em; text-align: center;">${khoi.tenKhoi}</p>

                                        <!--Get Total Lop-->
                                        <c:set var="toanSoLop" value="0" /><c:set var="vanSoLop" value="0" /><c:set var="khacSoLop" value="0" />
                                        <c:forEach var="lh" items="${listLopHoc}">
                                            <c:if test="${lh.idKhoi == khoi.ID_Khoi}">
                                                <c:choose>
                                                    <c:when test="${lh.nhomMonHoc == 'Toán'}"><c:set var="toanSoLop" value="${lh.tongSoLopHoc}" /></c:when>
                                                    <c:when test="${lh.nhomMonHoc == 'Văn'}"><c:set var="vanSoLop" value="${lh.tongSoLopHoc}" /></c:when>
                                                    <c:otherwise><c:set var="khacSoLop" value="${lh.tongSoLopHoc}" /></c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:forEach>

                                        <p class="dt-sc-course-meta">Toán: <a href="HomePageCourse?ID_Khoi=${khoi.ID_Khoi}&keyword=Toán" rel="tag">${toanSoLop} Lớp Học</a></p>
                                        <p class="dt-sc-course-meta">Văn: <a href="HomePageCourse?ID_Khoi=${khoi.ID_Khoi}&keyword=Văn" rel="tag">${vanSoLop} Lớp Học</a></p>
                                        <p class="dt-sc-course-meta">Các môn khác: <a href="HomePageCourse?ID_Khoi=${khoi.ID_Khoi}&keyword=Khac" rel="tag">${khacSoLop} Lớp Học</a></p>
                                    </article>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <div class="container" style="padding: 60px 0;">
                        <!--High-School-->
                        <div class='hr-title'><h2>Trung Học Cơ Sở</h2><div class='title-sep'><span></span></div></div>
                        <c:forEach var="khoi" items="${listKhoi}">
                            <c:if test="${khoi.ID_Khoi <= 4}">
                                <div class="column dt-sc-one-fourth first" style="margin-bottom: 30px; padding: 15px">
                                    <article id="post-${khoi.tenKhoi}" class="dt-sc-course post-${khoi.tenKhoi} course type-course course-category-card">
                                        <div class="dt-sc-course-thumb">
                                            <a href="#" title="${khoi.tenKhoi}"><img src="${pageContext.request.contextPath}/${khoi.image}" alt="${khoi.tenKhoi}" style="width:100%; height:180px; object-fit: cover; border-radius: 5px;" /></a>
                                        </div>
                                        <p style="font-weight: 700; font-size: 1.5em; text-align: center; margin: 0px 15px;">${khoi.tenKhoi}</p>

                                        <!--Calculate Total lop-->
                                        <c:set var="toanSoLop" value="0" /><c:set var="vanSoLop" value="0" /><c:set var="khacSoLop" value="0" />
                                        <c:forEach var="lh" items="${listLopHoc}">
                                            <c:if test="${lh.idKhoi == khoi.ID_Khoi}">
                                                    <c:choose>
                                                    <c:when test="${lh.nhomMonHoc == 'Toán'}"><c:set var="toanSoLop" value="${lh.tongSoLopHoc}" /></c:when>
                                                    <c:when test="${lh.nhomMonHoc == 'Văn'}"><c:set var="vanSoLop" value="${lh.tongSoLopHoc}" /></c:when>
                                                    <c:otherwise><c:set var="khacSoLop" value="${lh.tongSoLopHoc}" /></c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:forEach>

                                        <p class="dt-sc-course-meta">Toán: <a href="HomePageCourse?ID_Khoi=${khoi.ID_Khoi}&keyword=Toán" rel="tag">${toanSoLop} Lớp Học</a></p>
                                        <p class="dt-sc-course-meta">Văn: <a href="HomePageCourse?ID_Khoi=${khoi.ID_Khoi}&keyword=Văn" rel="tag">${vanSoLop} Lớp Học</a></p>
                                        <p class="dt-sc-course-meta">Các môn khác: <a href="HomePageCourse?ID_Khoi=${khoi.ID_Khoi}&keyword=Khac" rel="tag">${khacSoLop} Lớp Học</a></p>
                                    </article>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                  <!--Post List-->  
                 <div class='fullwidth-section dt-sc-parallax-section' style="background-color:#ffffff;background-repeat:repeat;background-position:left top;background-attachment:fixed;">
                    <div class="fullwidth-bg">    
                        <div class="container">
                            <div class='dt-sc-hr-invisible'></div>
                            <h2 style="text-align: center; font-weight: 700;">BÀI VIẾT CỦA CHÚNG TÔI</h2>
                            <div class="margin25"></div>
                            <c:forEach var="blog" items="${listBlog}">
                                <div class="column dt-sc-one-half first">
                                    <article id="post-${blog.getID_Blog()}" class="blog-post post-${blog.getID_Blog()} post type-post status-publish format-link has-post-thumbnail hentry category-design post_format-post-format-link">
                                        <div class="post-details" style="transform: translateX(25px); border-radius: 5px ">
                                            <div class="date">
                                                <p>
                                                    <span>${blog.getBlogDate().dayOfMonth}</span>
                                                    ${blog.getBlogDate().month.name()}&nbsp;${blog.getBlogDate().year}
                                                </p>
                                            </div>
                                        </div>
                                        <div class="post-content">
                                            <div class="entry-thumb">
                                                <a href="${pageContext.request.contextPath}/BlogDetailServlet?id=${blog.getID_Blog()}" title="${blog.getBlogTitle()}"><img loading="lazy" decoding="async" width="300" height="90" src="${pageContext.request.contextPath}/${blog.getImage()}" alt="${blog.getBlogTitle()}" title="${blog.getBlogTitle()}" /></a>
                                            </div>
                                            <div class="entry-detail">
                                                <h2><a href="${pageContext.request.contextPath}/BlogDetailServlet?id=${blog.getID_Blog()}" title="${blog.getBlogTitle()}">${blog.getBlogTitle()}</a></h2>
                                                <p>${blog.getBlogDescription()}</p>
                                            </div>
                                            <div class="post-meta">
                                                <div class="post-format"><span class="post-icon-format"></span></div>
                                                <ul>
                                                    <li><span class="fa fa-thumb-tack"></span><a href="${pageContext.request.contextPath}/HomePageBlog?keywordId=0&keytagId=${blog.getID_KeyTag()}"> ${blog.getKeyTag()}</a></li>
                                                    <li><span class="fa "></span><a href="${pageContext.request.contextPath}/HomePageBlog?keywordId=${blog.getID_Keyword()}&keytagId=0"> ${blog.getKeyWord()}</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </article>
                                </div>
                            </c:forEach>
                            <div class='dt-sc-hr-invisible'></div>    
                        </div>      
                    </div>
                </div>
                
            </article>
        </section>
    </div></body>
</html>
    
    <!-- JavaScript -->
<script type="text/javascript">
            jQuery(function() { 
                _initLayerSlider( 
                        '#layerslider_1_5r4q8o8aqo3t', {sliderVersion: '6.11.2', type: 'fullwidth', responsiveUnder: 940, allowFullscreen: false, slideBGSize: 'auto', pauseOnHover: 'disabled', skin: 'noskin', globalBGColor: 'transparent', globalBGSize: 'cover', yourLogoStyle: 'left: 10px; top: 10px;', skinsPath: 'https://dtguru.wpengine.com/wp-content/plugins/LayerSlider/assets/static/layerslider/skins/'}); });
            document.getElementById('regPhone').addEventListener('input', function(e) {
  this.value = this.value.replace(/[^0-9]/g, '');
});
    </script>
    


<script>
  const swiper = new Swiper('.swiper-container', {
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    slidesPerView: 4,
    spaceBetween: 20,
  });
</script>
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
		})();
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.tipTip.minified9704.js?ver=6.7.1" id="dt-tooltip-sc-script-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.tabs.min9704.js?ver=6.7.1" id="dt-tabs-script-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.viewport9704.js?ver=6.7.1" id="dt-viewport-script-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/jquery.toggle.click9704.js?ver=6.7.1" id="dt-sc-toggle-click-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/js/shortcodes9704.js?ver=6.7.1" id="dt-sc-script-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/yith-woocommerce-wishlist/assets/js/jquery.selectBox.min7359.js?ver=1.2.0" id="jquery-selectBox-js"></script>
<script type="text/javascript" id="jquery-yith-wcwl-js-extra">
/* <![CDATA[ */
var yith_wcwl_l10n = {"ajax_url":"\/wp-admin\/admin-ajax.php","redirect_to_cart":"no","multi_wishlist":"","hide_add_button":"1","enable_ajax_loading":"","ajax_loader_url":"https:\/\/dtguru.wpengine.com\/wp-content\/plugins\/yith-woocommerce-wishlist\/assets\/images\/ajax-loader-alt.svg","remove_from_wishlist_after_add_to_cart":"1","is_wishlist_responsive":"1","time_to_close_prettyphoto":"3000","fragments_index_glue":".","reload_on_found_variation":"1","labels":{"cookie_disabled":"We are sorry, but this feature is available only if cookies on your browser are enabled.","added_to_cart_message":"<div class=\"woocommerce-notices-wrapper\"><div class=\"woocommerce-message\" role=\"alert\">Product added to cart successfully<\/div><\/div>"},"actions":{"add_to_wishlist_action":"add_to_wishlist","remove_from_wishlist_action":"remove_from_wishlist","reload_wishlist_and_adding_elem_action":"reload_wishlist_and_adding_elem","load_mobile_action":"load_mobile","delete_item_action":"delete_item","save_title_action":"save_title","save_privacy_action":"save_privacy","load_fragments":"load_fragments"}};
/* ]]> */
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/yith-woocommerce-wishlist/assets/js/jquery.yith-wcwld4e0.js?ver=3.0.17" id="jquery-yith-wcwl-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-includes/js/comment-reply.min9704.js?ver=6.7.1" id="comment-reply-js" async="async" data-wp-strategy="async"></script>
<script type="text/javascript" id="contact-form-7-js-extra">
/* <![CDATA[ */
var wpcf7 = {"apiSettings":{"root":"https:\/\/dtguru.wpengine.com\/wp-json\/contact-form-7\/v1","namespace":"contact-form-7\/v1"},"cached":"1"};
/* ]]> */
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/contact-form-7/includes/js/scripts9dff.js?ver=5.3.2" id="contact-form-7-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-fb-pixel/script9704.js?ver=6.7.1" id="dt-fbpixel-script-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/jquery-blockui/jquery.blockUI.min44fd.js?ver=2.70" id="jquery-blockui-js"></script>
<script type="text/javascript" id="wc-add-to-cart-js-extra">
/* <![CDATA[ */
var wc_add_to_cart_params = {"ajax_url":"\/wp-admin\/admin-ajax.php","wc_ajax_url":"\/?wc-ajax=%%endpoint%%","i18n_view_cart":"View cart","cart_url":"https:\/\/dtguru.wpengine.com\/cart\/","is_cart":"","cart_redirect_after_add":"no"};
/* ]]> */
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/frontend/add-to-cart.min7bcd.js?ver=4.8.3" id="wc-add-to-cart-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/js-cookie/js.cookie.min6b25.js?ver=2.1.4" id="js-cookie-js"></script>
<script type="text/javascript" id="woocommerce-js-extra">
/* <![CDATA[ */
var woocommerce_params = {"ajax_url":"\/wp-admin\/admin-ajax.php","wc_ajax_url":"\/?wc-ajax=%%endpoint%%"};
/* ]]> */
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/frontend/woocommerce.min7bcd.js?ver=4.8.3" id="woocommerce-js"></script>
<script type="text/javascript" id="wc-cart-fragments-js-extra">
/* <![CDATA[ */
var wc_cart_fragments_params = {"ajax_url":"\/wp-admin\/admin-ajax.php","wc_ajax_url":"\/?wc-ajax=%%endpoint%%","cart_hash_key":"wc_cart_hash_7744c75059fc33b0412f73e1f3599070","fragment_name":"wc_fragments_7744c75059fc33b0412f73e1f3599070","request_timeout":"5000"};
/* ]]> */
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/frontend/cart-fragments.min7bcd.js?ver=4.8.3" id="wc-cart-fragments-js"></script>
<script type="text/javascript" id="wp-postratings-js-extra">
/* <![CDATA[ */
var ratingsL10n = {"plugin_url":"https:\/\/dtguru.wpengine.com\/wp-content\/plugins\/wp-postratings","ajax_url":"https:\/\/dtguru.wpengine.com\/wp-admin\/admin-ajax.php","text_wait":"Please rate only 1 item at a time.","image":"stars_crystal","image_ext":"gif","max":"5","show_loading":"1","show_fading":"1","custom":"0"};
var ratings_mouseover_image=new Image();ratings_mouseover_image.src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/wp-postratings/images/stars_crystal/rating_over.gif";;
/* ]]> */
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/wp-postratings/js/postratings-js40d5.js?ver=1.89" id="wp-postratings-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/prettyPhoto/jquery.prettyPhoto.min005e.js?ver=3.1.6" id="prettyPhoto-js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/html5shiv.min.js?ver=3.7.2" id="jq-html5-js"></script>
<![endif]-->
<!--[if lt IE 8]>
<script type="text/javascript" src="https://dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/excanvas.js?ver=2.0" id="jq-canvas-js"></script>
<![endif]-->
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/retina9704.js?ver=6.7.1" id="retina-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.sticky9704.js?ver=6.7.1" id="jquery-stickynav-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.smartresize9704.js?ver=6.7.1" id="jquery-smartresize-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery-smoothscroll9704.js?ver=6.7.1" id="jquery-smoothscroll-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery-easing-1.39704.js?ver=6.7.1" id="jquery-easing-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.inview9704.js?ver=6.7.1" id="jquery-inview-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.validate.min9704.js?ver=6.7.1" id="jquery-validate-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.carouFredSel-6.2.0-packed9704.js?ver=6.7.1" id="jquery-caroufredsel-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.isotope.min9704.js?ver=6.7.1" id="jquery-isotope-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.prettyPhoto9704.js?ver=6.7.1" id="jquery-prettyphoto-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.ui.totop.min9704.js?ver=6.7.1" id="jquery-uitotop-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/js/jquery-cookie/jquery.cookie.min330a.js?ver=1.4.1" id="jquery-cookie-js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.meanmenu9704.js?ver=6.7.1" id="jquery-meanmenu-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/contact9704.js?ver=6.7.1" id="guru-contact-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.donutchart9704.js?ver=6.7.1" id="jquery-donutchart-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.fitvids9704.js?ver=6.7.1" id="jquery-fitvids-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.bxslider9704.js?ver=6.7.1" id="jquery-bxslider-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.parallax-1.1.39704.js?ver=6.7.1" id="jquery-parallax-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/jquery.animateNumber.min9704.js?ver=6.7.1" id="jquery-animateNumber-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/custom9704.js?ver=6.7.1" id="guru-custom-js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/js/public/magnific/jquery.magnific-popup.min9704.js?ver=6.7.1" id="jquery-magnific-popup-js"></script>
<a href="#" id="toTop" style="display: none;"><span id="toTopHover"></span>To Top</a><div id="extension-mmplj"></div></body>    
</html>

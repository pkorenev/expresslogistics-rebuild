$(document).ready(function() {


    $('.service-list-car').click( function(){
        window.location.href = "/services/18";
    });

    $('.service-list-bag').click( function(){
        window.location.href = "/services/17";
    });

    $('.service-list-water').click( function(){
        window.location.href = "/services/16";
    });

    $('.service-list-train').click( function(){
        window.location.href = "/services/15";
    });

    $('.service-list-air').click( function(){
        window.location.href = "/services/14";
    });

    $('.service-list-letter').click( function(){
        window.location.href = "/services/13";
    });



    $("ul.head-menu li.li-about-us").hover(function() {
        $(".hover-eff-about-us").show();
        $(".hover-eff-about-us img").effect("bounce", { direction:'up', times:2, distance:8 }, 450);
    },function(){
        $(".hover-eff-about-us").hide();
    });

    $("ul.head-menu li.li-about-us, .hover-eff-about-us").click(function() {
        window.location.href = "/about";
    });

    $("ul.head-menu li.li-our-park").hover(function() {
        $(".hover-eff-our-park").show();
        $(".hover-eff-our-park img").effect("bounce", { direction:'up', times:2, distance:8 }, 450);
    },function(){
        $(".hover-eff-our-park").hide();
    });

    $("ul.head-menu li.li-our-park, .hover-eff-our-park").click(function() {
        window.location.href = "/orders";
    });

    $("ul.head-menu li.li-services").hover(function() {
        $(".hover-eff-services").show();
        $(".hover-eff-services img").effect("bounce", { direction:'up', times:2, distance:8 }, 450);
    },function(){
        $(".hover-eff-services").hide();
    });

    $("ul.head-menu li.li-services, .hover-eff-services").click(function() {
        window.location.href = "/services";
    });

    $("ul.head-menu li.li-contact").hover(function() {
        $(".hover-eff-contact").show();
        $(".hover-eff-contact img").effect("bounce", { direction:'up', times:4, distance:8 }, 450);
    },function(){
        $(".hover-eff-contact").hide();
    });

    $("ul.head-menu li.li-contact, .hover-eff-contact").click(function() {
        window.location.href = "/contact-us";
    });

    $("#eng").click(function() {
        $.cookie('language', 'eng', { expires: 30, path: '/' });
        window.location.reload();
    });

    $("#rus").click(function() {
        $.cookie('language', 'rus', { expires: 30, path: '/' });
        window.location.reload();
    });

    $("#de").click(function() {
        $.cookie('language', 'de', { expires: 30, path: '/' });
        window.location.reload();
    });

    $("#ua").click(function() {
        $.cookie('language', 'ukr', { expires: 30, path: '/' });
        window.location.reload();
    });

    $(".fancybox").fancybox({
        openEffect  : 'none',
        closeEffect : 'none'
    });



});

$(document).ready(function() {
    $('#banner_j').mobilyslider({
        content: '.sliderContent',
        children: 'div',
        transition: 'fade',
        animationSpeed: 2400,
        autoplay: true,
        autoplaySpeed: 12000,
        pauseOnHover: false,
        bullets: false,
        arrows: true,
        arrowsHide: false,
        prev: 'prev',
        next: 'next',
        animationStart: function(){  },
        animationComplete: function(){ $('.flex-info-block').fadeIn('slow'); }
    });
    $('.flex-info-block').fadeIn('slow');

    //$("#banner_j .sliderContent").bxSlider({
    //
    //})
});

$(document).ready(function() {
    $('.background-randoms').css("background","url('/attachments/44/el-web-bg-3-1.jpg') right top no-repeat transparent");
});
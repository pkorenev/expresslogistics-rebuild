// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/dist/jquery.min.js
//= require fancybox/source/jquery.fancybox.pack
//= require jquery-ui/jquery-ui.min



$(document).on("ready", function(){
    alert("ready")
    $("div.flash-notice").fadeOut()
})

//TODO: Work on IE8 Bugs with this js and console error

//var console = console;
var root_dom = $('body');

$(document).ready(function() {

    var env = $('body').data('envariment');
    var br = $('body').data('loader');
    var api = $('body').data('api');

    if(env == 'development'){
        localStorage.clear();
        console.log('Cache has been cleaned!');
        console.log('Develop mode loaded!');
    }else{
        console.log('Production mode loaded!');
        //localStorage.clear();
    }


    // Insert data on resize action
    var resizeTimer;
    $(window).resize(function() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            var body_size = $('body').width();
            var body_height = $('body').height();
            console.log('Current document width: ' + body_size + ' and height is: ' + body_height + '!');
        }, 200);
    });


});


$(document).ready(function() {








    //Map
    map = new GMaps({
        div: '#map',
        lat: 49.81571,
        lng: 23.919465,
        zoomControl : true,
        zoomControlOpt: {
            style : 'SMALL',
            position: 'TOP_LEFT'
        },
        panControl : false,
        streetViewControl : false,
        mapTypeControl: false,
        overviewMapControl: false
    });

    map.addMarker({
        lat: 49.81571,
        lng: 23.919465,
        content: '<div class="overlay">Lima</div>'
    });


});

//= require_directory .
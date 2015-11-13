$(document).on("ready", function(){
    //alert("ready")
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




initializeGoogleMap = function(){
    $map = $("#map map")

    //lat = 49.829182
    //lng = 24.01275
    lat = 49.81571
    lng = 23.919465

    latlng = new google.maps.LatLng(lat, lng)

    mapOptions = {
        zoom: 17,
        center: latlng,
        scrollwheel: true
    }


    map = new google.maps.Map($map.get(0), mapOptions)

    marker = new google.maps.Marker({
        map: map,
        draggable: true,
        animation: google.maps.Animation.DROP,
        position: {lat: lat, lng: lng}
    });
}

$(document).ready(function() {






    if(window.GMaps != undefined) {

        //Map
        map = new GMaps({
            div: '#map',
            lat: 49.81571,
            lng: 23.919465,
            zoomControl: true,
            zoomControlOpt: {
                style: 'SMALL',
                position: 'TOP_LEFT'
            },
            panControl: false,
            streetViewControl: false,
            mapTypeControl: false,
            overviewMapControl: false
        });

        map.addMarker({
            lat: 49.81571,
            lng: 23.919465,
            content: '<div class="overlay">Lima</div>'
        });

    }
});


initializeGoogleMap()




/*
 * jQuery FlexSlider v2.2.0 (from develop branch)
 * Copyright 2012 WooThemes
 * Contributing Author: Tyler Smith
 */
;(function(c){c.flexslider=function(j,l){var a=c(j);a.vars=c.extend({},c.flexslider.defaults,l);var d=a.vars.namespace,s=("ontouchstart"in window||window.DocumentTouch&&document instanceof DocumentTouch)&&a.vars.touch,g="",t,n="vertical"===a.vars.direction,p=a.vars.reverse,k=0<a.vars.itemWidth,q="fade"===a.vars.animation,r=""!==a.vars.asNavFor,f={};c.data(j,"flexslider",a);f={init:function(){a.animating=!1;a.currentSlide=a.vars.startAt;a.animatingTo=a.currentSlide;a.atEnd=0===a.currentSlide||a.currentSlide===
    a.last;a.containerSelector=a.vars.selector.substr(0,a.vars.selector.search(" "));a.slides=c(a.vars.selector,a);a.container=c(a.containerSelector,a);a.count=a.slides.length;a.syncExists=0<c(a.vars.sync).length;"slide"===a.vars.animation&&(a.vars.animation="swing");a.prop=n?"top":"marginLeft";a.args={};a.manualPause=!1;var b=a,e;if(e=!a.vars.video)if(e=!q)if(e=a.vars.useCSS)a:{e=document.createElement("div");var h=["perspectiveProperty","WebkitPerspective","MozPerspective","OPerspective","msPerspective"],
    d;for(d in h)if(void 0!==e.style[h[d]]){a.pfx=h[d].replace("Perspective","").toLowerCase();a.prop="-"+a.pfx+"-transform";e=!0;break a}e=!1}b.transitions=e;""!==a.vars.controlsContainer&&(a.controlsContainer=0<c(a.vars.controlsContainer).length&&c(a.vars.controlsContainer));""!==a.vars.manualControls&&(a.manualControls=0<c(a.vars.manualControls).length&&c(a.vars.manualControls));a.vars.randomize&&(a.slides.sort(function(){return Math.round(Math.random())-0.5}),a.container.empty().append(a.slides));
    a.doMath();r&&f.asNav.setup();a.setup("init");a.vars.controlNav&&f.controlNav.setup();a.vars.directionNav&&f.directionNav.setup();a.vars.keyboard&&(1===c(a.containerSelector).length||a.vars.multipleKeyboard)&&c(document).bind("keyup",function(b){b=b.keyCode;if(!a.animating&&(39===b||37===b))b=39===b?a.getTarget("next"):37===b?a.getTarget("prev"):!1,a.flexAnimate(b,a.vars.pauseOnAction)});a.vars.mousewheel&&a.bind("mousewheel",function(b,e){b.preventDefault();var c=0>e?a.getTarget("next"):a.getTarget("prev");
        a.flexAnimate(c,a.vars.pauseOnAction)});a.vars.pausePlay&&f.pausePlay.setup();a.vars.slideshow&&(a.vars.pauseOnHover&&a.hover(function(){!a.manualPlay&&!a.manualPause&&a.pause()},function(){!a.manualPause&&!a.manualPlay&&a.play()}),0<a.vars.initDelay?setTimeout(a.play,a.vars.initDelay):a.play());s&&a.vars.touch&&f.touch();(!q||q&&a.vars.smoothHeight)&&c(window).bind("resize focus",f.resize);setTimeout(function(){a.vars.start(a)},200)},asNav:{setup:function(){a.asNav=!0;a.animatingTo=Math.floor(a.currentSlide/
    a.move);a.currentItem=a.currentSlide;a.slides.removeClass(d+"active-slide").eq(a.currentItem).addClass(d+"active-slide");a.slides.click(function(b){b.preventDefault();b=c(this);var e=b.index();!c(a.vars.asNavFor).data("flexslider").animating&&!b.hasClass("active")&&(a.direction=a.currentItem<e?"next":"prev",a.flexAnimate(e,a.vars.pauseOnAction,!1,!0,!0))})}},controlNav:{setup:function(){a.manualControls?f.controlNav.setupManual():f.controlNav.setupPaging()},setupPaging:function(){var b=1,e;a.controlNavScaffold=
    c('<ol class="'+d+"control-nav "+d+("thumbnails"===a.vars.controlNav?"control-thumbs":"control-paging")+'"></ol>');if(1<a.pagingCount)for(var h=0;h<a.pagingCount;h++)e="thumbnails"===a.vars.controlNav?'<img src="'+a.slides.eq(h).attr("data-thumb")+'"/>':"<a>"+b+"</a>",a.controlNavScaffold.append("<li>"+e+"</li>"),b++;a.controlsContainer?c(a.controlsContainer).append(a.controlNavScaffold):a.append(a.controlNavScaffold);f.controlNav.set();f.controlNav.active();a.controlNavScaffold.delegate("a, img",
    "click touchend",function(b){b.preventDefault();if(""===g||g===b.type){var e=c(this),h=a.controlNav.index(e);e.hasClass(d+"active")||(a.direction=h>a.currentSlide?"next":"prev",a.flexAnimate(h,a.vars.pauseOnAction))}""===g&&(g=b.type);f.setToClearWatchedEvent()})},setupManual:function(){a.controlNav=a.manualControls;f.controlNav.active();a.controlNav.bind("click touchend",function(b){b.preventDefault();if(""===g||g===b.type){var e=c(this),h=a.controlNav.index(e);e.hasClass(d+"active")||(h>a.currentSlide?
    a.direction="next":a.direction="prev",a.flexAnimate(h,a.vars.pauseOnAction))}""===g&&(g=b.type);f.setToClearWatchedEvent()})},set:function(){a.controlNav=c("."+d+"control-nav li "+("thumbnails"===a.vars.controlNav?"img":"a"),a.controlsContainer?a.controlsContainer:a)},active:function(){a.controlNav.removeClass(d+"active").eq(a.animatingTo).addClass(d+"active")},update:function(b,e){1<a.pagingCount&&"add"===b?a.controlNavScaffold.append(c("<li><a>"+a.count+"</a></li>")):1===a.pagingCount?a.controlNavScaffold.find("li").remove():
    a.controlNav.eq(e).closest("li").remove();f.controlNav.set();1<a.pagingCount&&a.pagingCount!==a.controlNav.length?a.update(e,b):f.controlNav.active()}},directionNav:{setup:function(){var b=c('<ul class="'+d+'direction-nav"><li><a class="'+d+'prev" href="#">'+a.vars.prevText+'</a></li><li><a class="'+d+'next" href="#">'+a.vars.nextText+"</a></li></ul>");a.controlsContainer?(c(a.controlsContainer).append(b),a.directionNav=c("."+d+"direction-nav li a",a.controlsContainer)):(a.append(b),a.directionNav=
    c("."+d+"direction-nav li a",a));f.directionNav.update();a.directionNav.bind("click touchend",function(b){b.preventDefault();var h;if(""===g||g===b.type)h=c(this).hasClass(d+"next")?a.getTarget("next"):a.getTarget("prev"),a.flexAnimate(h,a.vars.pauseOnAction);""===g&&(g=b.type);f.setToClearWatchedEvent()})},update:function(){var b=d+"disabled";1===a.pagingCount?a.directionNav.addClass(b):a.vars.animationLoop?a.directionNav.removeClass(b):0===a.animatingTo?a.directionNav.removeClass(b).filter("."+
    d+"prev").addClass(b):a.animatingTo===a.last?a.directionNav.removeClass(b).filter("."+d+"next").addClass(b):a.directionNav.removeClass(b)}},pausePlay:{setup:function(){var b=c('<div class="'+d+'pauseplay"><a></a></div>');a.controlsContainer?(a.controlsContainer.append(b),a.pausePlay=c("."+d+"pauseplay a",a.controlsContainer)):(a.append(b),a.pausePlay=c("."+d+"pauseplay a",a));f.pausePlay.update(a.vars.slideshow?d+"pause":d+"play");a.pausePlay.bind("click touchend",function(b){b.preventDefault();if(""===
    g||g===b.type)c(this).hasClass(d+"pause")?(a.manualPause=!0,a.manualPlay=!1,a.pause()):(a.manualPause=!1,a.manualPlay=!0,a.play());""===g&&(g=b.type);f.setToClearWatchedEvent()})},update:function(b){"play"===b?a.pausePlay.removeClass(d+"pause").addClass(d+"play").text(a.vars.playText):a.pausePlay.removeClass(d+"play").addClass(d+"pause").text(a.vars.pauseText)}},touch:function(){function b(b){m=n?c-b.touches[0].pageY:c-b.touches[0].pageX;r=n?Math.abs(m)<Math.abs(b.touches[0].pageX-d):Math.abs(m)<
    Math.abs(b.touches[0].pageY-d);if(!r||500<Number(new Date)-l)b.preventDefault(),!q&&a.transitions&&(a.vars.animationLoop||(m/=0===a.currentSlide&&0>m||a.currentSlide===a.last&&0<m?Math.abs(m)/g+2:1),a.setProps(f+m,"setTouch"))}function e(){j.removeEventListener("touchmove",b,!1);if(a.animatingTo===a.currentSlide&&!r&&null!==m){var k=p?-m:m,n=0<k?a.getTarget("next"):a.getTarget("prev");a.canAdvance(n)&&(550>Number(new Date)-l&&50<Math.abs(k)||Math.abs(k)>g/2)?a.flexAnimate(n,a.vars.pauseOnAction):
    q||a.flexAnimate(a.currentSlide,a.vars.pauseOnAction,!0)}j.removeEventListener("touchend",e,!1);f=m=d=c=null}var c,d,f,g,m,l,r=!1;j.addEventListener("touchstart",function(m){a.animating?m.preventDefault():1===m.touches.length&&(a.pause(),g=n?a.h:a.w,l=Number(new Date),f=k&&p&&a.animatingTo===a.last?0:k&&p?a.limit-(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo:k&&a.currentSlide===a.last?a.limit:k?(a.itemW+a.vars.itemMargin)*a.move*a.currentSlide:p?(a.last-a.currentSlide+a.cloneOffset)*g:(a.currentSlide+
    a.cloneOffset)*g,c=n?m.touches[0].pageY:m.touches[0].pageX,d=n?m.touches[0].pageX:m.touches[0].pageY,j.addEventListener("touchmove",b,!1),j.addEventListener("touchend",e,!1))},!1)},resize:function(){!a.animating&&a.is(":visible")&&(k||a.doMath(),q?f.smoothHeight():k?(a.slides.width(a.computedW),a.update(a.pagingCount),a.setProps()):n?(a.viewport.height(a.h),a.setProps(a.h,"setTotal")):(a.vars.smoothHeight&&f.smoothHeight(),a.newSlides.width(a.computedW),a.setProps(a.computedW,"setTotal")))},smoothHeight:function(b){if(!n||
    q){var e=q?a:a.viewport;b?e.animate({height:a.slides.eq(a.animatingTo).height()},b):e.height(a.slides.eq(a.animatingTo).height())}},sync:function(b){var e=c(a.vars.sync).data("flexslider"),d=a.animatingTo;switch(b){case "animate":e.flexAnimate(d,a.vars.pauseOnAction,!1,!0);break;case "play":!e.playing&&!e.asNav&&e.play();break;case "pause":e.pause()}},setToClearWatchedEvent:function(){clearTimeout(t);t=setTimeout(function(){g=""},3E3)}};a.flexAnimate=function(b,e,h,g,j){r&&1===a.pagingCount&&(a.direction=
    a.currentItem<b?"next":"prev");if(!a.animating&&(a.canAdvance(b,j)||h)&&a.is(":visible")){if(r&&g)if(h=c(a.vars.asNavFor).data("flexslider"),a.atEnd=0===b||b===a.count-1,h.flexAnimate(b,!0,!1,!0,j),a.direction=a.currentItem<b?"next":"prev",h.direction=a.direction,Math.ceil((b+1)/a.visible)-1!==a.currentSlide&&0!==b)a.currentItem=b,a.slides.removeClass(d+"active-slide").eq(b).addClass(d+"active-slide"),b=Math.floor(b/a.visible);else return a.currentItem=b,a.slides.removeClass(d+"active-slide").eq(b).addClass(d+
    "active-slide"),!1;a.animating=!0;a.animatingTo=b;a.vars.before(a);e&&a.pause();a.syncExists&&!j&&f.sync("animate");a.vars.controlNav&&f.controlNav.active();k||a.slides.removeClass(d+"active-slide").eq(b).addClass(d+"active-slide");a.atEnd=0===b||b===a.last;a.vars.directionNav&&f.directionNav.update();b===a.last&&(a.vars.end(a),a.vars.animationLoop||a.pause());if(q)s?(a.slides.eq(a.currentSlide).css({opacity:0,zIndex:1}),a.slides.eq(b).css({opacity:1,zIndex:2}),a.animating=!1,a.currentSlide=a.animatingTo):
    (a.slides.eq(a.currentSlide).css({zIndex:1}).animate({opacity:0},a.vars.animationSpeed,a.vars.easing),a.slides.eq(b).css({zIndex:2}).animate({opacity:1},a.vars.animationSpeed,a.vars.easing,a.wrapup));else{var l=n?a.slides.filter(":first").height():a.computedW;k?(b=a.vars.itemMargin,b=(a.itemW+b)*a.move*a.animatingTo,b=b>a.limit&&1!==a.visible?a.limit:b):b=0===a.currentSlide&&b===a.count-1&&a.vars.animationLoop&&"next"!==a.direction?p?(a.count+a.cloneOffset)*l:0:a.currentSlide===a.last&&0===b&&a.vars.animationLoop&&
    "prev"!==a.direction?p?0:(a.count+1)*l:p?(a.count-1-b+a.cloneOffset)*l:(b+a.cloneOffset)*l;a.setProps(b,"",a.vars.animationSpeed);if(a.transitions){if(!a.vars.animationLoop||!a.atEnd)a.animating=!1,a.currentSlide=a.animatingTo;a.container.unbind("webkitTransitionEnd transitionend");a.container.bind("webkitTransitionEnd transitionend",function(){a.wrapup(l)})}else a.container.animate(a.args,a.vars.animationSpeed,a.vars.easing,function(){a.wrapup(l)})}a.vars.smoothHeight&&f.smoothHeight(a.vars.animationSpeed)}};
    a.wrapup=function(b){!q&&!k&&(0===a.currentSlide&&a.animatingTo===a.last&&a.vars.animationLoop?a.setProps(b,"jumpEnd"):a.currentSlide===a.last&&(0===a.animatingTo&&a.vars.animationLoop)&&a.setProps(b,"jumpStart"));a.animating=!1;a.currentSlide=a.animatingTo;a.vars.after(a)};a.animateSlides=function(){a.animating||a.flexAnimate(a.getTarget("next"))};a.pause=function(){clearInterval(a.animatedSlides);a.playing=!1;a.vars.pausePlay&&f.pausePlay.update("play");a.syncExists&&f.sync("pause")};a.play=function(){a.animatedSlides=
        setInterval(a.animateSlides,a.vars.slideshowSpeed);a.playing=!0;a.vars.pausePlay&&f.pausePlay.update("pause");a.syncExists&&f.sync("play")};a.canAdvance=function(b,e){var c=r?a.pagingCount-1:a.last;return e?!0:r&&a.currentItem===a.count-1&&0===b&&"prev"===a.direction?!0:r&&0===a.currentItem&&b===a.pagingCount-1&&"next"!==a.direction?!1:b===a.currentSlide&&!r?!1:a.vars.animationLoop?!0:a.atEnd&&0===a.currentSlide&&b===c&&"next"!==a.direction?!1:a.atEnd&&a.currentSlide===c&&0===b&&"next"===a.direction?
        !1:!0};a.getTarget=function(b){a.direction=b;return"next"===b?a.currentSlide===a.last?0:a.currentSlide+1:0===a.currentSlide?a.last:a.currentSlide-1};a.setProps=function(b,e,c){var d,f=b?b:(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo;d=-1*function(){if(k)return"setTouch"===e?b:p&&a.animatingTo===a.last?0:p?a.limit-(a.itemW+a.vars.itemMargin)*a.move*a.animatingTo:a.animatingTo===a.last?a.limit:f;switch(e){case "setTotal":return p?(a.count-1-a.currentSlide+a.cloneOffset)*b:(a.currentSlide+a.cloneOffset)*
        b;case "setTouch":return b;case "jumpEnd":return p?b:a.count*b;case "jumpStart":return p?a.count*b:b;default:return b}}()+"px";a.transitions&&(d=n?"translate3d(0,"+d+",0)":"translate3d("+d+",0,0)",c=void 0!==c?c/1E3+"s":"0s",a.container.css("-"+a.pfx+"-transition-duration",c));a.args[a.prop]=d;(a.transitions||void 0===c)&&a.container.css(a.args)};a.setup=function(b){if(q)a.slides.css({width:"100%","float":"left",marginRight:"-100%",position:"relative"}),"init"===b&&(s?a.slides.css({opacity:0,display:"block",
        webkitTransition:"opacity "+a.vars.animationSpeed/1E3+"s ease",zIndex:1}).eq(a.currentSlide).css({opacity:1,zIndex:2}):a.slides.css({opacity:0,display:"block",zIndex:1}).eq(a.currentSlide).css({zIndex:2}).animate({opacity:1},a.vars.animationSpeed,a.vars.easing)),a.vars.smoothHeight&&f.smoothHeight();else{var e,h;"init"===b&&(a.viewport=c('<div class="'+d+'viewport"></div>').css({overflow:"hidden",position:"relative"}).appendTo(a).append(a.container),a.cloneCount=0,a.cloneOffset=0,p&&(h=c.makeArray(a.slides).reverse(),
        a.slides=c(h),a.container.empty().append(a.slides)));a.vars.animationLoop&&!k&&(a.cloneCount=2,a.cloneOffset=1,"init"!==b&&a.container.find(".clone").remove(),a.container.append(a.slides.first().clone().addClass("clone")).prepend(a.slides.last().clone().addClass("clone")));a.newSlides=c(a.vars.selector,a);e=p?a.count-1-a.currentSlide+a.cloneOffset:a.currentSlide+a.cloneOffset;n&&!k?(a.container.height(200*(a.count+a.cloneCount)+"%").css("position","absolute").width("100%"),setTimeout(function(){a.newSlides.css({display:"block"});
        a.doMath();a.viewport.height(a.h);a.setProps(e*a.h,"init")},"init"===b?100:0)):(a.container.width(200*(a.count+a.cloneCount)+"%"),a.setProps(e*a.computedW,"init"),setTimeout(function(){a.doMath();a.newSlides.css({width:a.computedW,"float":"left",display:"block"});a.vars.smoothHeight&&f.smoothHeight()},"init"===b?100:0))}k||a.slides.removeClass(d+"active-slide").eq(a.currentSlide).addClass(d+"active-slide")};a.doMath=function(){var b=a.slides.first(),e=a.vars.itemMargin,c=a.vars.minItems,d=a.vars.maxItems;
        a.w=a.width();a.h=b.height();a.boxPadding=b.outerWidth()-b.width();k?(a.itemT=a.vars.itemWidth+e,a.minW=c?c*a.itemT:a.w,a.maxW=d?d*a.itemT-e:a.w,a.itemW=a.minW>a.w?(a.w-e*(c-1))/c:a.maxW<a.w?(a.w-e*(d-1))/d:a.vars.itemWidth>a.w?a.w:a.vars.itemWidth,a.visible=Math.floor(a.w/a.itemW),a.move=0<a.vars.move&&a.vars.move<a.visible?a.vars.move:a.visible,a.pagingCount=Math.ceil((a.count-a.visible)/a.move+1),a.last=a.pagingCount-1,a.limit=1===a.pagingCount?0:a.vars.itemWidth>a.w?a.itemW*(a.count-1)+e*(a.count-
            1):(a.itemW+e)*a.count-a.w-e):(a.itemW=a.w,a.pagingCount=a.count,a.last=a.count-1);a.computedW=a.itemW-a.boxPadding};a.update=function(b,c){a.doMath();k||(b<a.currentSlide?a.currentSlide+=1:b<=a.currentSlide&&0!==b&&(a.currentSlide-=1),a.animatingTo=a.currentSlide);if(a.vars.controlNav&&!a.manualControls)if("add"===c&&!k||a.pagingCount>a.controlNav.length)f.controlNav.update("add");else if("remove"===c&&!k||a.pagingCount<a.controlNav.length)k&&a.currentSlide>a.last&&(a.currentSlide-=1,a.animatingTo-=
        1),f.controlNav.update("remove",a.last);a.vars.directionNav&&f.directionNav.update()};a.addSlide=function(b,e){var d=c(b);a.count+=1;a.last=a.count-1;n&&p?void 0!==e?a.slides.eq(a.count-e).after(d):a.container.prepend(d):void 0!==e?a.slides.eq(e).before(d):a.container.append(d);a.update(e,"add");a.slides=c(a.vars.selector+":not(.clone)",a);a.setup();a.vars.added(a)};a.removeSlide=function(b){var d=isNaN(b)?a.slides.index(c(b)):b;a.count-=1;a.last=a.count-1;isNaN(b)?c(b,a.slides).remove():n&&p?a.slides.eq(a.last).remove():
        a.slides.eq(b).remove();a.doMath();a.update(d,"remove");a.slides=c(a.vars.selector+":not(.clone)",a);a.setup();a.vars.removed(a)};f.init()};c.flexslider.defaults={namespace:"flex-",selector:".slides > li",animation:"fade",easing:"swing",direction:"horizontal",reverse:!1,animationLoop:!0,smoothHeight:!1,startAt:0,slideshow:!0,slideshowSpeed:7E3,animationSpeed:600,initDelay:0,randomize:!1,pauseOnAction:!0,pauseOnHover:!1,useCSS:!0,touch:!0,video:!1,controlNav:!0,directionNav:!0,prevText:"Previous",
    nextText:"Next",keyboard:!0,multipleKeyboard:!1,mousewheel:!1,pausePlay:!1,pauseText:"Pause",playText:"Play",controlsContainer:"",manualControls:"",sync:"",asNavFor:"",itemWidth:0,itemMargin:0,minItems:0,maxItems:0,move:0,start:function(){},before:function(){},after:function(){},end:function(){},added:function(){},removed:function(){}};c.fn.flexslider=function(j){void 0===j&&(j={});if("object"===typeof j)return this.each(function(){var a=c(this),d=a.find(j.selector?j.selector:".slides > li");1===
    d.length?(d.fadeIn(400),j.start&&j.start(a)):void 0===a.data("flexslider")&&new c.flexslider(this,j)});var l=c(this).data("flexslider");switch(j){case "play":l.play();break;case "pause":l.pause();break;case "next":l.flexAnimate(l.getTarget("next"),!0);break;case "prev":case "previous":l.flexAnimate(l.getTarget("prev"),!0);break;default:"number"===typeof j&&l.flexAnimate(j,!0)}}})(jQuery);

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  $(".new_commnet_form").submitWithAjax();
})

$(document).ready(function(){
    show_hide_comments();
    show_hide_add_comment();

    //Show the paging and activate its first link
    //$(".paging").show();
    $(".paging a:first").addClass("active");

    //Get size of the image, how many images there are, then determin the size of the image reel.
    var imageWidth = $(".window").width();
    var imageSum = $(".image_reel img").size();
    var imageReelWidth = imageWidth * imageSum;

    //Adjust the image reel to its new size
    $(".image_reel").css({'width' : imageReelWidth});

    //Paging  and Slider Function
    rotate = function(){
        var triggerID = $active.attr("rel") - 1; //Get number of times to slide
        var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide

        $(".paging a").removeClass('active'); //Remove all active class
        $active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)

        //Slider Animation
        $(".image_reel").animate({
            left: -image_reelPosition
        }, 500 );

    };

    //Rotation  and Timing Event
    rotateSwitch = function(){
        play = setInterval(function(){ //Set timer - this will repeat itself every 7 seconds
            $active = $('.paging a.active').next(); //Move to the next paging
            if ( $active.length === 0) { //If paging reaches the end...
                $active = $('.paging a:first'); //go back to first
            }
            rotate(); //Trigger the paging and slider function
        }, 7000); //Timer speed in milliseconds (7 seconds)
    };

    //On Hover
    $(".image_reel a").hover(function() {
        clearInterval(play); //Stop the rotation
    }, function() {
        rotateSwitch(); //Resume rotation timer
    });

    //On Click
    $(".paging a").click(function() {
        $active = $(this); //Activate the clicked paging
        //Reset Timer
        clearInterval(play); //Stop the rotation
        rotate(); //Trigger rotation immediately
        rotateSwitch(); // Resume rotation timer
        return false; //Prevent browser jump to link anchor
    });

    rotateSwitch(); //Run function on launch

    p3_sidebar_drawers();

    if($('.richTextArea').length){
        $('.richTextArea').wysiwyg();
    }

    p3_lightbox_gallery();
});

function show_hide_comments() {
    $('.comments-count').click(function(){
        var comments_section = $(this).parents('.entry-comments');
        if ( $('.comments-body-inner div', comments_section).length ) {
            comments_section.toggleClass('comments-count-active');
            $('.comments-body', comments_section).slideToggle(400);
        }
    });
}

function show_hide_add_comment(){
    $('.addacomment a').click(function(){
        $("#addcomment-holder-" + get_id(this.id,1)).slideToggle(400);
        return false;
    });
    $('#cancel_add_comment').click(function(){
        $("#addcomment-holder-" + get_id(this.id,3)).slideToggle(400);
        return false;
    });
}

function get_id(obj_id,index){
    return obj_id.split('_')[index];
}

function p3_sidebar_drawers() {
    var drawer_padding = 40;

    // set initial opacity and height of drawers
    $('.drawer_content, .tab').css('opacity', 0.85);
    $('.drawer_content').css('height', ($(window).height() - 40) + 'px' );
                                            
    // function-scoped timeout var object
    var p3_close_drawer_timeout = new Object();

    // instrument each drawer
    var drawer = $('#drawer_1');
    var id     = drawer.attr('id');
    var tab    = jQuery('.tab', this);
    var width  = parseInt( $('.drawer_content', drawer).css( 'width' ) ) + 40;
    var speed  = parseInt( width * 0.75);
    var tab    = $('#tab_1');

    // show the drawer on tab mouseover
    tab.mouseover(function(){
        drawer
            .css( 'z-index', '10000' )
            .animate( { left:'0px' }, speed, 'swing' )
            .addClass( 'open' );
    });

    /* // handle iphone/ipad show/hides
    if ( is_ipad || is_iphone ) {
        $('#inner-wrap').unbind('touchstart').bind('touchstart',function(){
            drawer.mouseleave();
        });
        tab.bind('touchstart',function(){
            if ( drawer.hasClass('open') ) drawer.trigger('mouseleave');
        });
    }
    */
        
    // set the timeout to close drawer on mouseleave
    drawer.mouseleave(function(){
        //var delay = ( is_ipad || is_iphone ) ? 1 : 1000;
        var delay = 1000;
        clearTimeout( p3_close_drawer_timeout[id] );
        p3_close_drawer_timeout[id] = setTimeout( function(){
            drawer.animate( { left:'-' + width + 'px' }, speed, 'swing', function(){
                drawer.css( 'z-index', '5000' ).removeClass('open');
            } );
        }, delay );
    });

        // restart the close drawer timout on mouseenter
    drawer.mouseenter(function(){
        clearTimeout( p3_close_drawer_timeout[id] );
    });
}

function p3_lightbox_gallery() {
    $('.p3-lightbox-gallery').each(function(){
        $('a.lightbox_links').lightBox();
    });
    $(".p3-lightbox-gallery-thumbs img").css('opacity', 0.65).hover(function(){
        $(this).stop().animate({opacity:1},200);
    }, function(){
        $(this).stop().animate({opacity:0.65},200);
    });
}
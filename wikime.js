$("img").each(function() {
  var src = $(this).attr("src").replace("/thumb", "").replace(/\/[^\/]+$/,"");
  $(this).parent("a").attr("href", src);
});
$("a.image").attr("data-featherlight", "image");
$("img.flaggedrevs-icon").css("display", "none");
$("table.infobox.geography.vcard tbody tr td div.noresize div span a img").css("display", "none");

$(document).ready(function() {
   $('.menu-link').bigSlide();
   $('.sb-search').on('submit',function() {
    var getWiki = $('#search').val();
    var addWiki = "https://en.wikipedia.org/wiki/" + getWiki;
    window.open(addWiki);
  });
});

$(".sb-search-input").autocomplete({
  source: function(request, response) {
    $.ajax({
    url: "http://en.wikipedia.org/w/api.php",
    dataType: "jsonp",
    data: {
      'action': "opensearch",
      'format': "json",
      'search': request.term
    },
    success: function(data) {
        response(data[1]);
    }
    });
  }
});

var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('header').outerHeight();
$(window).scroll(function(event){
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);

function hasScrolled() {
    var st = $(this).scrollTop();
    
    // Make sure they scroll more than delta
    if(Math.abs(lastScrollTop - st) <= delta)
        return;
    
    // If they scrolled down and are past the navbar, add class .nav-up.
    // This is necessary so you never see what is "behind" the navbar.
    if (st > lastScrollTop && st > navbarHeight){
        // Scroll Down
        $('header').removeClass('nav-down').addClass('nav-up');
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('header').removeClass('nav-up').addClass('nav-down');
        }
    }
    
    lastScrollTop = st;
}



// $(function(){
//   $('a').not(".image").click(function(){
//     $("#content").empty();
//     var url = $(this).attr('href');
//     $( "#content" ).load( url, "#content" );
//     return false;
//   });
// });
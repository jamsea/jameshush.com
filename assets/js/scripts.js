
$(document).ready(function() {
  $('.panel-collapse').on('show.bs.collapse', function () {
    $(this).siblings('.panel-heading').addClass('active');
  });

  $('.panel-collapse').on('hide.bs.collapse', function () {
    $(this).siblings('.panel-heading').removeClass('active');
  });

});




$(window).on("load", function () { 
    let hash = window.location.hash;

    if(hash == "#workshop"){
        jQuery('.navbar-nav li a[href=\"' + hash + '\"]').closest('li').addClass('active-new');
    }else if(hash == "#about"){
        jQuery('.navbar-nav li a[href=\"' + hash + '\"]').closest('li').addClass('active-new');
    }else{ 
        jQuery('.navbar-nav li.active').addClass('active-new'); 
    }

    jQuery('.workshop-item a, .about-item a').on('click', function(){
        jQuery('.navbar-nav li.active-new').removeClass('active-new');
        jQuery(this).parent('li').addClass('active-new');
    });
});



$(document).ready(function($) {

    $("#sideber-nav ul li a, #navbarNav ul li a").click(function() {
        $(this).parent().addClass('active').siblings().removeClass('active');
        $("#sideber-nav .hold-btn").removeClass("active");
        $("#left-sidebar .hold-btn").removeClass("active");
        $("#navbarNav .hold-btn").removeClass("active");
    });

    $(".navbar-dark .navbar-nav .nav-link, .hold-btn").click(function(){
        $("#navbarNav").removeClass("show");
    });

    $(".hold-btn").click(function(){
        $("#navbarNav ul li").removeClass("active");
        $("#sideber-nav ul li").removeClass("active");/*
        $("#left-sidebar .hold-btn").addClass("active");
        $("#navbarNav .hold-btn").addClass("active");*/
    });
});



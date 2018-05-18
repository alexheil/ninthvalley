//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var menuToggle = function() {

  $('#menu-click').click(function() {
    $('#menu-container').fadeIn(300);
    $('.back').fadeIn(300);
    $(".wrapper").addClass("blur");
  });

  $('.back').click(function() {
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
  });

  $('#close-menu').click(function() {
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
  });

};

$(document).ready(menuToggle);
$(document).on('turbolinks:load', menuToggle);


var flashTimeout = function() {

  setTimeout(function() {
    $('.flash_js').fadeOut();
  }, 5000);

};

$(document).ready(flashTimeout);
$(document).on('turbolinks:load', flashTimeout);


var signInAndRegister = function() {

  $('#sign-in').click(function() {
    $('#sign-in-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#register').click(function() {
    $('#register-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#menu-sign-in').click(function() {
    $('#sign-in-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#menu-register').click(function() {
    $('#register-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('.back').click(function() {
    $('#sign-in-form').fadeOut(300);
    $('#register-form').fadeOut(300);
    $('#sign-in').fadeIn(300);
    $('#register').fadeIn(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur", 300);
  });

  $('.close').click(function() {
    $('#sign-in-form').fadeOut(300);
    $('#register-form').fadeOut(300);
    $('#sign-in').fadeIn(300);
    $('#register').fadeIn(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur", 300);
  });

  $('#student-sign-in-click').click(function() {
    $('#student-sign-in-container').show();
    $('#instructor-sign-in-container').hide();
    $('#student-sign-in-click').removeClass("inactive-tab");
    $('#student-sign-in-click').addClass("active-tab");
    $('#instructor-sign-in-click').removeClass("active-tab");
    $('#instructor-sign-in-click').addClass("inactive-tab");
  });

  $('#instructor-sign-in-click').click(function() {
    $('#instructor-sign-in-container').show();
    $('#student-sign-in-container').hide();
    $('#instructor-sign-in-click').removeClass("inactive-tab");
    $('#instructor-sign-in-click').addClass("active-tab");
    $('#student-sign-in-click').removeClass("active-tab");
    $('#student-sign-in-click').addClass("inactive-tab");
  });

  $('#student-register-click').click(function() {
    $('#student-register-container').show();
    $('#instructor-register-container').hide();
    $('#why-student').show();
    $('#why-instructor').hide();
    $('#student-register-click').removeClass("inactive-tab");
    $('#student-register-click').addClass("active-tab");
    $('#instructor-register-click').removeClass("active-tab");
    $('#instructor-register-click').addClass("inactive-tab");
  });

  $('#instructor-register-click').click(function() {
    $('#instructor-register-container').show();
    $('#student-register-container').hide();
    $('#why-instructor').show();
    $('#why-student').hide();
    $('#instructor-register-click').removeClass("inactive-tab");
    $('#instructor-register-click').addClass("active-tab");
    $('#student-register-click').removeClass("active-tab");
    $('#student-register-click').addClass("inactive-tab");
  });

  $('#student-sign-in-click-page').click(function() {
    $('#student-sign-in-container-page').show();
    $('#instructor-sign-in-container-page').hide();
    $('#student-sign-in-click-page').removeClass("inactive-tab");
    $('#student-sign-in-click-page').addClass("active-tab");
    $('#instructor-sign-in-click-page').removeClass("active-tab");
    $('#instructor-sign-in-click-page').addClass("inactive-tab");
  });

  $('#instructor-sign-in-click-page').click(function() {
    $('#instructor-sign-in-container-page').show();
    $('#student-sign-in-container-page').hide();
    $('#instructor-sign-in-click-page').removeClass("inactive-tab");
    $('#instructor-sign-in-click-page').addClass("active-tab");
    $('#student-sign-in-click-page').removeClass("active-tab");
    $('#student-sign-in-click-page').addClass("inactive-tab");
  });

  $('#student-register-click-page').click(function() {
    $('#student-register-container-page').show();
    $('#instructor-register-container-page').hide();
    $('#why-student-page').show();
    $('#why-instructor-page').hide();
    $('#student-register-click-page').removeClass("inactive-tab");
    $('#student-register-click-page').addClass("active-tab");
    $('#instructor-register-click-page').removeClass("active-tab");
    $('#instructor-register-click-page').addClass("inactive-tab");
  });

  $('#instructor-register-click-page').click(function() {
    $('#instructor-register-container-page').show();
    $('#student-register-container-page').hide();
    $('#why-instructor-page').show();
    $('#why-student-page').hide();
    $('#instructor-register-click-page').removeClass("inactive-tab");
    $('#instructor-register-click-page').addClass("active-tab");
    $('#student-register-click-page').removeClass("active-tab");
    $('#student-register-click-page').addClass("inactive-tab");
  });

  $('#search-icon').click(function() {
    $('#search-container').fadeIn(300);
  });

};

$(document).ready(signInAndRegister);
$(document).on('turbolinks:load', signInAndRegister);


var editProfile = function() {

  $('#edit-profile-click').click(function() {
    $('#profile-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('.back').click(function() {
    $('#profile-form').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur", 300);
  });

  $('.close').click(function() {
    $('#profile-form').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur", 300);
  });

  $('#remove-image-inactive').change(function(){
    if($(this).is(":checked")) {
        $('#remove-image-tab').addClass("active-removal-tab");
        $('#remove-image-tab').removeClass("inactive-removal-tab");
    } else {
        $('#remove-image-tab').removeClass("active-removal-tab");
        $('#remove-image-tab').addClass("inactive-removal-tab");
    }
  });

};

$(document).ready(editProfile);
$(document).on('turbolinks:load', editProfile);
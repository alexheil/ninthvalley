//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var menuToggle = function() {

  $('#menu-click').click(function() {
    $('#menu-container').fadeIn(300);
    $('.back').fadeIn(300);
    $(".wrapper").addClass("blur");
    $('.background').addClass('blur');
  });

  $('.back').click(function() {
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
    $('.background').removeClass('blur');
  });

  $('#close-menu').click(function() {
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $(".wrapper").removeClass("blur");
    $('.background').removeClass('blur');
  });

};

$(document).ready(menuToggle);
$(document).on('turbolinks:load', menuToggle);


var flashTimeout = function() {

  setTimeout(function() {
    $('.flash_js').fadeOut();
  }, 5000);

  $(".image-fade-in").fadeIn(500);
  $(".thumbnail-image-home").fadeIn(500);
  $(".thumbnail-image").fadeIn(500);
  $(".video-player").fadeIn(500);

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
    $('.wrapper').addClass("blur");
    $('.background').addClass('blur');
  });

  $('#register').click(function() {
    $('#register-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur");
    $('.background').addClass('blur');
  });

  $('#menu-sign-in').click(function() {
    $('#sign-in-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur");
    $('.background').addClass('blur');
  });

  $('#menu-register').click(function() {
    $('#register-form').fadeIn(300);
    $('#sign-in').fadeOut(300);
    $('#register').fadeOut(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur");
    $('.background').addClass('blur');
  });

  $('.back').click(function() {
    $('#sign-in-form').fadeOut(300);
    $('#register-form').fadeOut(300);
    $('#sign-in').fadeIn(300);
    $('#register').fadeIn(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur");
    $('.background').removeClass('blur');
  });

  $('.close').click(function() {
    $('#sign-in-form').fadeOut(300);
    $('#register-form').fadeOut(300);
    $('#sign-in').fadeIn(300);
    $('#register').fadeIn(300);
    $('#menu-container').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur");
    $('.background').removeClass('blur');
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

  $('#profile-button-click').click(function() {
    $('#profile-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#post-button-click').click(function() {
    $('#post-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#course-button-click').click(function() {
    $('#course-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#track-button-click').click(function() {
    $('#track-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#purchase-button-click').click(function() {
    $('#purchase-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#unsubscribe-button-click').click(function() {
    $('#unsubscribe-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('.edit-track-button-click').click(function() {
    $('.edit-track-form').hide();
    $(this).parent().parent().parent().next().fadeIn(100);
    $('.back').fadeIn(300);
  });

  $('.video-button-click').click(function() {
    $('.video-form').hide();
    $(this).parent().parent().parent().next().next().fadeIn(100);
    $('.back').fadeIn(300);
  });

  $('#video-button-click').click(function() {
    $('#video-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('#review-button-click').click(function() {
    $('#review-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('.edit-review-button-click').click(function() {
    $('.edit-review-form').hide();
    $(this).parent().parent().parent().next().fadeIn(100);
    $('.back').fadeIn(300);
  });

  $('#comment-button-click').click(function() {
    $('#comment-form').fadeIn(300);
    $('.back').fadeIn(300);
    $('.wrapper').addClass("blur", 300);
  });

  $('.edit-comment-button-click').click(function() {
    $('.edit-comment-form').hide();
    $(this).parent().parent().parent().next().fadeIn(100);
    $('.back').fadeIn(300);
  });

  $('.back').click(function() {
    $('#profile-form').fadeOut(300);
    $('#post-form').fadeOut(300);
    $('#course-form').fadeOut(300);
    $('#track-form').fadeOut(300);
    $('.edit-track-form').fadeOut(300);
    $('.video-form').fadeOut(300);
    $('#video-form').fadeOut(300);
    $('#review-form').fadeOut(300);
    $('#comment-form').fadeOut(300);
    $('.edit-review-form').fadeOut(300);
    $('.edit-comment-form').fadeOut(300);
    $('#purchase-form').fadeOut(300);
    $('#unsubscribe-form').fadeOut(300);
    $('.back').fadeOut(300);
    $('.wrapper').removeClass("blur", 300);
  });

  $('.close').click(function() {
    $('#profile-form').fadeOut(300);
    $('#post-form').fadeOut(300);
    $('#course-form').fadeOut(300);
    $('#track-form').fadeOut(300);
    $('.edit-track-form').fadeOut(300);
    $('.video-form').fadeOut(300);
    $('#video-form').fadeOut(300);
    $('#review-form').fadeOut(300);
    $('#comment-form').fadeOut(300);
    $('.edit-review-form').fadeOut(300);
    $('.edit-comment-form').fadeOut(300);
    $('#purchase-form').fadeOut(300);
    $('#unsubscribe-form').fadeOut(300);
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


var purchaseForms = function() {

  $('#paid-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#paid-container').slideDown(300);
      $('#paid-tab').addClass("active-paid-tab");
      $('#paid-tab').removeClass("inactive-paid-tab");
    } else {
      $('#paid-container').slideUp(300);
      $('#paid-tab').removeClass("active-paid-tab");
      $('#paid-tab').addClass("inactive-paid-tab");
    }
  });

  if ($('#paid-inactive').prop('checked')) {
    $('#paid-tab').addClass("active-paid-tab");
    $('#paid-tab').removeClass("inactive-paid-tab");
    $('#paid-container').show();
  };

  $('#use-card-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#use-card-container').slideDown(300);
      $('#use-card-button').show();
      $('#checkout-button').hide();
      $('#checkout-container').hide(300);
      $('#purchase-button').hide();
      $('#use-card-tab').addClass("active-paid-tab");
      $('#use-card-tab').removeClass("inactive-paid-tab");
    } else {
      $('#use-card-container').slideUp(300);
      $('#use-card-button').hide();
      $('#checkout-button').show();
      $('#use-card-tab').removeClass("active-paid-tab");
      $('#use-card-tab').addClass("inactive-paid-tab");
    }
  });

  $('#use-card-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#use-card-id').click(function() {
        $('#checkout-container').remove();
        var form = document.getElementById('payment-form');
        form.submit();
      });
    }
  });

  $('#checkout-button').click(function() {
    $('#checkout-container').fadeIn(300);
    $('#checkout-button').hide();
    $('#purchase-button').show();
  });

};

$(document).ready(purchaseForms);
$(document).on('turbolinks:load', purchaseForms);


var sidebarTabs = function() {

  $('#first-tab-click').click(function() {
    $('#first-tab').fadeIn(300);
    $('#first-tab-click').addClass('active-sidebar-tab');
    $('#first-tab-click').removeClass('inactive-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#second-tab-click').click(function() {
    $('#second-tab').fadeIn(300);
    $('#second-tab-click').addClass('active-sidebar-tab');
    $('#second-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#third-tab-click').click(function() {
    $('#third-tab').fadeIn(300);
    $('#third-tab-click').addClass('active-sidebar-tab');
    $('#third-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#fourth-tab-click').click(function() {
    $('#fourth-tab').fadeIn(300);
    $('#fourth-tab-click').addClass('active-sidebar-tab');
    $('#fourth-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#fifth-tab-click').click(function() {
    $('#fifth-tab').fadeIn(300);
    $('#fifth-tab-click').addClass('active-sidebar-tab');
    $('#fifth-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#sixth-tab-click').click(function() {
    $('#sixth-tab').fadeIn(300);
    $('#sixth-tab-click').addClass('active-sidebar-tab');
    $('#sixth-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#seventh-tab').hide();
    $('#seventh-tab-click').addClass('inactive-sidebar-tab');
    $('#seventh-tab-click').removeClass('active-sidebar-tab');
  });

  $('#seventh-tab-click').click(function() {
    $('#seventh-tab').fadeIn(300);
    $('#seventh-tab-click').addClass('active-sidebar-tab');
    $('#seventh-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
    $('#second-tab').hide();
    $('#second-tab-click').addClass('inactive-sidebar-tab');
    $('#second-tab-click').removeClass('active-sidebar-tab');
    $('#third-tab').hide();
    $('#third-tab-click').addClass('inactive-sidebar-tab');
    $('#third-tab-click').removeClass('active-sidebar-tab');
    $('#fourth-tab').hide();
    $('#fourth-tab-click').addClass('inactive-sidebar-tab');
    $('#fourth-tab-click').removeClass('active-sidebar-tab');
    $('#fifth-tab').hide();
    $('#fifth-tab-click').addClass('inactive-sidebar-tab');
    $('#fifth-tab-click').removeClass('active-sidebar-tab');
    $('#sixth-tab').hide();
    $('#sixth-tab-click').addClass('inactive-sidebar-tab');
    $('#sixth-tab-click').removeClass('active-sidebar-tab');
  });

  $('#more-tracks').click(function() {
    $('#second-tab').fadeIn(300);
    $('#second-tab-click').addClass('active-sidebar-tab');
    $('#second-tab-click').removeClass('inactive-sidebar-tab');
    $('#first-tab').hide();
    $('#first-tab-click').addClass('inactive-sidebar-tab');
    $('#first-tab-click').removeClass('active-sidebar-tab');
  });

  $('.track-card').click(function() {
    $('.track-card').removeClass('active-tab');
    $('.track-card').addClass('inactive-tab');
    $(this).addClass('active-tab');
    $(this).removeClass('inactive-tab');
    $('.video-list').hide();
    $(this).next('.video-list').slideDown(300).delay(100);
  });

  $(".notifications_container").on("click", ".notification-card", function() {
    $('.notification-card').removeClass('active-notification-tab');
    $('.notification-card').addClass('inactive-notification-tab');
    $(this).addClass('active-notification-tab');
    $(this).removeClass('inactive-notification-tab');
    $('.notification-container').hide();
    $(this).next('.notification-container').slideDown(300).delay(100);
  });

  $(".messages_container").on("click", ".message-card", function() {
    $('.message-card').removeClass('active-notification-tab');
    $('.message-card').addClass('inactive-notification-tab');
    $(this).addClass('active-notification-tab');
    $(this).removeClass('inactive-notification-tab');
    $('.message-container').hide();
    $(this).next('.message-container').slideDown(300).delay(100);
  });

  $('.reply-button').click(function() {
    $('.reply-container').hide();
    $(this).parent().parent().next('.reply-container').slideDown(300).delay(100);
  });


};

$(document).ready(sidebarTabs);
$(document).on('turbolinks:load', sidebarTabs);


var emailTabs = function() {

  $('#first-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#first-email-tab').addClass("active-paid-tab");
      $('#first-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#first-email-tab').removeClass("active-paid-tab");
      $('#first-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#second-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#second-email-tab').addClass("active-paid-tab");
      $('#second-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#second-email-tab').removeClass("active-paid-tab");
      $('#second-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#third-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#third-email-tab').addClass("active-paid-tab");
      $('#third-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#third-email-tab').removeClass("active-paid-tab");
      $('#third-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#fourth-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#fourth-email-tab').addClass("active-paid-tab");
      $('#fourth-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#fourth-email-tab').removeClass("active-paid-tab");
      $('#fourth-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#fifth-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#fifth-email-tab').addClass("active-paid-tab");
      $('#fifth-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#fifth-email-tab').removeClass("active-paid-tab");
      $('#fifth-email-tab').addClass("inactive-paid-tab");
    }
  });

  $('#sixth-email-inactive').change(function(){
    if($(this).is(":checked")) {
      $('#sixth-email-tab').addClass("active-paid-tab");
      $('#sixth-email-tab').removeClass("inactive-paid-tab");
    } else {
      $('#sixth-email-tab').removeClass("active-paid-tab");
      $('#sixth-email-tab').addClass("inactive-paid-tab");
    }
  });

  if ($('#first-email-inactive').prop('checked')) {
    $('#first-email-tab').addClass("active-paid-tab");
    $('#first-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#second-email-inactive').prop('checked')) {
    $('#second-email-tab').addClass("active-paid-tab");
    $('#second-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#third-email-inactive').prop('checked')) {
    $('#third-email-tab').addClass("active-paid-tab");
    $('#third-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#fourth-email-inactive').prop('checked')) {
    $('#fourth-email-tab').addClass("active-paid-tab");
    $('#fourth-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#fifth-email-inactive').prop('checked')) {
    $('#fifth-email-tab').addClass("active-paid-tab");
    $('#fifth-email-tab').removeClass("inactive-paid-tab");
  };

  if ($('#sixth-email-inactive').prop('checked')) {
    $('#sixth-email-tab').addClass("active-paid-tab");
    $('#sixth-email-tab').removeClass("inactive-paid-tab");
  };

};

$(document).ready(emailTabs);
$(document).on('turbolinks:load', emailTabs);

var directUpload = function() {

  function fileUpload(fileInput) {
    var imagePreview = document.querySelector('.upload-preview');

    fileInput.style.display = 'none' // uppy will add its own file input

    var uppy = Uppy.Core({
        id: fileInput.id,
      })
      .use(Uppy.FileInput, {
        target: fileInput.parentNode,
      })
      .use(Uppy.Informer, {
        target: fileInput.parentNode,
      })
      .use(Uppy.ProgressBar, {
        target: imagePreview.parentNode,
      });

    uppy.use(Uppy.AwsS3, {
      getUploadParameters: function (file) {
        return fetch('/presign?filename=' + file.name, { // Shrine's presign endpoint
          credentials: 'same-origin', // send cookies
        }).then(function (response) { return response.json() })
      }
    });

    uppy.on('upload-success', function (file, data, uploadURL) {
      // show image preview
      imagePreview.src = URL.createObjectURL(file.data)

      // construct uploaded file data in the format that Shrine expects
      var uploadedFileData = JSON.stringify({
        id: uploadURL.match(/\/cache\/([^\?]+)/)[1], // extract key without prefix
        storage: 'cache',
        metadata: {
          size:      file.size,
          filename:  file.name,
          mime_type: file.type,
        }
      });

      // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
      var hiddenInput = fileInput.parentNode.querySelector('.upload-hidden')
      hiddenInput.value = uploadedFileData
    })

    return uppy
  };

  document.querySelectorAll('.upload-file').forEach(function (fileInput) {
    fileUpload(fileInput)
  });

};

$(document).ready(directUpload);
$(document).on('turbolinks:load', directUpload);


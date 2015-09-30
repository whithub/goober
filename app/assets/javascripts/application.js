// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function() {
  if ($('body.admin.rides.index').length > 0) {

    (function poll() {
      // http://techoctave.com/c7/posts/60-simple-long-polling-example-with-javascript-and-jquery/
      setTimeout(function() {
        $.ajax({
          url: "/admins/rides",
          success: function(data) {
            //Update your dashboard
            $('#page').html(data);
            console.log('updated rides');
          },
          dataType: "html",
          complete: poll,
          timeout: 3000
        });
      }, 3000);
    })();
  }


  if ($('body.rides.index').length > 0) {

    (function poll() {
      // http://techoctave.com/c7/posts/60-simple-long-polling-example-with-javascript-and-jquery/
      setTimeout(function() {
        $.ajax({
          url: "/users/rides",
          success: function(data) {
            //Update your dashboard
            $('#page').html(data);
            console.log('updated rides');
          },
          dataType: "html",
          complete: poll,
          timeout: 3000
        });
      }, 3000);
    })();
  }

});

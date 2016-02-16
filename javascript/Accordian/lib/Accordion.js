$(document).ready(function() {
      $('.accordion-wrapper').find('.accordion-header').click(function() {

          $(this).next().slideDown();

          $(".accordion-content").not($(this).next()).slideUp();

        });
      });
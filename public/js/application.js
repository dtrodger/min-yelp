$(document).ready(function() {
  deleteRestaurant();
  // getRestaurantForm();
  $('.show_restaurant').hover(
    function() {
      $(this).closest('.restaurant-detail').addClass('restaurant_hover');
    }, function() {
      $(this).closest('.restaurant-detail').removeClass('restaurant_hover');
    });
});

function deleteRestaurant() {
  $('.delete_restaurant_form').on('submit', function() {
    event.preventDefault();

    var $form = $(this)

    var $ajax = $.ajax({
      url: $form.attr('action'),
      method: $form.find('.hidden').attr('value')
    });

    $ajax.done(function(){
      $form.closest('.restaurant-detail').remove();
    });
  });
};

// BEGINING OF NEW RESTAURANT FORM USING AJAX

// function getRestaurantForm() {
//   $('#get-restaurant-form').on('click', function() {
//     event.preventDefault();

//     var $aTag = $(this)

//     var $ajax = $.ajax({
//       url: $aTag.attr('href')
//     })

//     $ajax.done(function(response) {
//       $aTag.hide();
//       $('#restaurant-form-row').append(response);
//     });
//   });
// };

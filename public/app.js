$(document).ready(function() {

  var saveFriends = function() {
    // get jqmobile list
    // check for data-checked
    var foodies = JSON.stringify(list);
    $.cookie("foodies", foodies, { path: '/' });
  };

  var updateLocation = function() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(updateList);
    } else {
      error('not supported');
    }
  };

  var updateList = function() {

  };

  var init = function() {
    //attach handlers
    $('#refresh').on('click', function(e) {
      e.preventDefault();
      updateLocation();
    });
  };

  init();
});

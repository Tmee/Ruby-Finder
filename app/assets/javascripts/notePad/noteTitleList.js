$(document).ready(function() {
  var url = "/notes";
  $.ajax({
    url: url,
    method: "GET"
  }).done(function(data) {
    $.each( data, function(key, value){
      $('ul#title-list').append(
        "<li class='note-title' style='color:white;margin-left: 10px;' data-note-id=" + data[key].id + ">" + data[key].title + "</li>");
    })
  });
});
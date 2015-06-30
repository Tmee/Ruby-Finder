$(document).ready(function() {
  var url = "/notes";
  $.ajax({
    url: url,
    method: "GET"
  }).done(function(data) {
    $('input#selected_note_title').val(data[0].title);
    $('textarea#selected_note').val(data[0].body);
  });
});
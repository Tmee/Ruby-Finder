$(document).ready(function() {
  clickDelete();
});

var clickDelete = function() {
  $('a#delete-note').click(function(e) {
    e.preventDefault();
    deleteNote();
  });
};

var deleteNote = function() {
  var id = parseInt($('textarea#selected_note').attr('data-note-id'));
  var url = "/notes/" + id;
  $.ajax({
    url: url,
    method: "DELETE"
  }).done(function() {
    $('li.note-title[data-note-id=' + id + ']').remove();
    $('input#selected_note_title').val('Deleted Note');
    $('textarea#selected_note').val('');
  });
};
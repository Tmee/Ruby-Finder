$(document).ready(function() {
  $('a#delete-note').click(function(e) {
    e.preventDefault();
    deleteNote();
  });

  var deleteNote = function() {
    var id = $('textarea#selected_note').data('noteId');
    var url = "/notes/" + id;
    $.ajax({
      url: url,
      method: "DELETE"
    }).done(function(data) {
      $('li.note-title[data-note-id=' + id + ']').remove();
      $('textarea#selected_note').removeAttr('data-note-id')
      $('input#selected_note_title').val('Note Deleted');
      $('textarea#selected_note').val('');
    });
  };
});
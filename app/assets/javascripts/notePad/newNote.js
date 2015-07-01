$(document).ready(function() {
  $('a#new-note').click(function(e) {
    e.preventDefault();
    createNewNote();
  });
});

var createNewNote = function() {
  $('textarea#selected_note').empty();
  var url = "/notes";
  var newNoteText = {note:
                      {
                        title: 'New Note Title',
                        body: 'Write Notes Here',
                        user_id: currentUserID
                      }
                    }
  $.ajax({
    url: url,
    method: "POST",
    data: newNoteText
  }).done(function(data) {
    $('textarea#selected_note').attr('data-note-id', data.id)
    $('input#selected_note_title').val(data.title);
    $('textarea#selected_note').val(data.body);
    $('ul#title-list').append(
      "<li class='note-title' style='color:white;margin-left: 10px;' data-note-id=" + data.id + ">" + data.title + "</li>");
  });
};

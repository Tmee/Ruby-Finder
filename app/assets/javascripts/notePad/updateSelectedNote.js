$(document).ready(function() {
  $('button#update-selected-note').click(function(e) {
    e.preventDefault();
    checkSelectedNote();
  });

  var checkSelectedNote = function () {
    var id = parseInt($('textarea#selected_note').attr('data-note-id'));
    if (id > 0 ) {
      updateNote(id);
      $('textarea#selected_note').empty
    } else {
      alert("Looks like you don't have any notes,  Click the dropdown button to create your first note!")
    }
  };
});

var updateNote = function(id) {
  var url = "/notes/" + id;
  var updatedText = {note:
                      {
                        title: $('input#selected_note_title').val(),
                        body: $('textarea#selected_note').val()
                      }
                    }
  $.ajax({
    url: url,
    method: "PUT",
    data: updatedText
  }).done(function(data) {
    $('li.note-title[data-note-id=' + id +']').replaceWith("<li class='note-title' style='color:white;margin-left: 10px;' data-note-id=" + id + ">" + data.title + "</li>");
  });
};
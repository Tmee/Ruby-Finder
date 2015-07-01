$(document).ready( function() {
  var oldText;

  $('textarea#selected_note').on('focusout', function() {
    var id = parseInt($('textarea#selected_note').attr('data-note-id'));
    getOldNote(id).done( function() {
      checkForUpdate(id);
    });
  });

  function getOldNote(id) {
    var url = "/notes/" + id;
    return $.ajax({ url: url,
                    method: "GET"
                  }).done(function(data) { oldText = data.body;});
  };

  function checkForUpdate(id) {
    var newText = $('textarea#selected_note').val();
    if (newText !== oldText) {
      updateNote(id);
    }
  };

  function updateNote(id) {
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
});

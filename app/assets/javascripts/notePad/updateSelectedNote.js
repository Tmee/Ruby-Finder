$(document).ready(function() {
  $('button#update-selected-note').click(function(e) {
    e.preventDefault();
    var noteBody = $('')
    updateSelectedNote();
  });

  var updateSelectedNote = function (data) {
    var id = parseInt($('textarea#selected_note').attr('data-note-id'));
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
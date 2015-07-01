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
      ShowDialog();
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

function ShowDialog() {
  ShowDialogBox('WHOOPS!',"You don't have any notes yet. Click the dropdown button to add your first note");
}

function ShowDialogBox(title, content) {
  $("#lblMessage").html(content);
  $("#dialog").dialog({
    resizable: false,
    title: title,
    modal: true,
    width: '400px',
    height: 'auto',
    bgiframe: false,
    hide: { effect: 'scale', duration: 400 }
  });
};

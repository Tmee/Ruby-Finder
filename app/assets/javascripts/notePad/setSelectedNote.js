$(document).ready(function() {
  setInterval(function(){
    $("li.note-title").click(function() {
      console.log("hit ::::::::::::::::::::::");
      $('textarea#selected_note').attr('data-note-id', $(this).data('note-id'))
      setSelectedNote($(this).data());
    });
  }, 1000);

  var setSelectedNote = function(data) {
    var id = data.noteId;
    var url = "/notes/" + id;
    $.get(url, function(data){
      $('input#selected_note_title').val(data.title);
      $('textarea#selected_note').val(data.body);
    });
  };
});
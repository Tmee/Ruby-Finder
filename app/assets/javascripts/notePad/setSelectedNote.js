// var clickedTitle = function() {
//   $(".note-titles").on("click", ".note-title", function() {
//     $(".note-titles").off("click");
//     $('textarea#selected_note').attr('data-note-id', $(this).data('note-id'));
//     setSelectedNote($(this).data());
//   });
// };

// var setSelectedNote = function(data) {
//   var id = data.noteId;
//   var url = "/notes/" + id;
//   $.get(url, function(data){
//     $('input#selected_note_title').val(data.title);
//     $('textarea#selected_note').val(data.body);
//     clickedTitle();
//   });
// };

// window.onload = clickedTitle;
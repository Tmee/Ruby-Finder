var t;
var clickedTitle = function() {
  console.log("loaded ::::::::::::")
  $("li.note-title").click(function() {
    console.log("clicked ::::::::::::")
    $('textarea#selected_note').attr('data-note-id', $(this).data('note-id'))
    setSelectedNote($(this).data());
    ///t = setTimeout(function(){ clickedTitle() }, 1000);
  });

};

var setSelectedNote = function(data) {
  ///clearTimeout(t);
  var id = data.noteId;
  var url = "/notes/" + id;
  $.get(url, function(data){
    $('input#selected_note_title').val(data.title);
    $('textarea#selected_note').val(data.body);
    clickedTitle();
  });
};

window.onload = clickedTitle;








// var interval = window.onload = setInterval(function() {
//   console.log("loaded ::::::::::::::::::::");
//   $("li.note-title").click(function() {
//     window.clearInterval(interval);
//     console.log("hit ::::::::::::::::::::::");
//     $('textarea#selected_note').attr('data-note-id', $(this).data('note-id'))
//     setSelectedNote($(this).data());
//     interval;
//   });
// }, 1000);
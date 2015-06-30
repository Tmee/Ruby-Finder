$(document).ready(function() {
  var note = $("#notePad");

  $(document).scroll(function() {
    if ($(document).scrollTop() >= 260) {
      note.addClass("note-fixed");
    } else {
      note.removeClass("note-fixed");
    }
  });

  note.keydown(function(e) {
    if (e.which === 9) {
      e.preventDefault();
    }
  });
});

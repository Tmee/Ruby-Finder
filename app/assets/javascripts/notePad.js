$(document).ready(function() {
  var note = $("#note");

  $(document).scroll(function() {
    if ($(document).scrollTop() >= 260) {
      note.addClass("note-fixed");
    } else {
      note.removeClass("note-fixed");
    }
  });

  note.keypress(function(e) {
    if (e.keyCode == 9) {
      e.preventDefault();
    }
  });
});

$(document).ready(function() {
  $("form").on( 'keydown', function(e) {
    var keyCode = e.keyCode || e.which;

    if (keyCode === 9) {
      if ( $('button#update-selected-note').is(':focus') ) {
        $('input#selected_note_title').focus();
      } else  {
        $(':focus').next().focus();
      }
    };
  });
});

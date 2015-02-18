$( document ).ready(function() {
  $('a').click( function(e) {
    $(this).text(' Link')
    $(this).prepend("<i class='fi-check'></i>");
  });
});
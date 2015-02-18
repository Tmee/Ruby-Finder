$( document ).ready(function() {
  $('a').click( function() {
    $(this).text(' Link')
    $(this).prepend("<i class='fi-check'></i>");
  });
});
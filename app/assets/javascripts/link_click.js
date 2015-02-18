$( document ).ready(function() {
  $('a.job-link').click( function() {
    $(this).text(' Link')
    $(this).prepend("<i class='fi-check'></i>");
  });
});
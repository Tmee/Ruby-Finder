$(document).ready(function() {
  $('button#job-search-button').click(function(e) {
    e.preventDefault();
    runJobsSearch();
  });
  var city = $('input#city').val();
  var state = $('input#state').val();

  var runJobsSearch = function() {
    runMonsterSearch();
    // runIndeedSearch();
    // runDiceSearch();
    // runSimplyHiredSearch();
  };

  var runMonsterSearch = function() {
    var url  = '/search/monster';
    $.ajax({
      url: url,
      method: "GET",
      data:{city: city, state: state}
    }).done(function(data) {
    });
  };
});
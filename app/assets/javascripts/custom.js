document.addEventListener("turbolinks:load", function() {
  $('.scrollspy').scrollSpy();

  $('select').material_select();

  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 1, // Creates a dropdown of 15 years to control year,
    today: 'Today',
    clear: 'Clear',
    close: 'Ok',
    closeOnSelect: false // Close upon selecting a date,
  });

  $('ul.tabs').tabs();

  $(".dropdown-button").dropdown();

});

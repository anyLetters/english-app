$(document).ready(function(){
  $('.phrase-rus').hide();
  hideRusPhrase = $(".hide-rus-phrase");
  hideRusPhrase.on('click', function () {
    $('.phrase-rus').show();
    $(hideRusPhrase).hide();
  })
});
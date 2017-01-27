$(document).ready(function(){
  $('.phrase_rus').hide();
  hideRusPhrase = $(".hide_rus_phrase");
  hideRusPhrase.on('click', function () {
    $('.phrase_rus').show();
    $(hideRusPhrase).hide();
  })
});
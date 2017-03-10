$(document).ready(function(){
  hideRus = $(".hide-rus");
  hideRus.on('click', function () {
    $(hideRus).fadeOut(350);
  });
  sidebar = $('.sidebar-content');
  toggle_button = $('.options-search-button');
  toggle_button.click(function() {
    sidebar.fadeToggle('default','swing');
  });
});

var voiceText = function (element) {

  if (typeof element !== 'undefined')
    var text = document.getElementsByClassName(element.className)[0].innerHTML;
  else
    var text = document.getElementsByClassName("word-eng")[0].innerHTML;

  if (typeof text !== 'undefined' && text !== '')
    responsiveVoice.speak(text, "US English Male");
  else
    console.log('error');

};

var countViewsReset = function () {

  if (!localStorage.day) {
    var date = new Date();
    var today = date.getDate;
    today = today.call(date);
    localStorage.day = today;
  }

  var date = new Date();
  var currentDay = date.getDate;
  currentDay = currentDay.call(date);

  if (parseInt(localStorage.day) !== currentDay)  
    localStorage.clear();

};

var countWatchedWords = function () {
  
  countViewsReset();

  if (localStorage.views)
    localStorage.views = Number(localStorage.views) + 1;
  else
    localStorage.views = 1;

  setTimeout(function () { 
    document.getElementsByClassName("info-views")[0].innerHTML = "You have watched " +
    localStorage.views + " words today";
  }, 250);

};

document.addEventListener("DOMContentLoaded", function() {
  
  if (location.href.split('?')[0].split('/').slice(-1) == 'words') {
    countWatchedWords();
  }

});
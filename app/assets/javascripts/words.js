$(document).ready(function(){
  hideRus = $(".hide-rus");
  hideRus.on('click', function () {
    $(hideRus).fadeOut(350);
  });
  sidebar = $('.sidebar-search');
  toggle_button = $('.options-search-button');
  toggle_button.click(function() {
    sidebar.toggle(function(){
    // sidebar.animate({width:auto});
    });
  });
});

var countWatchedWords = function () {
  
  countViewsReset();

  if (localStorage.views) {
    localStorage.views = Number(localStorage.views) + 1;
  } else {
    localStorage.views = 1;
  }

  setTimeout(function () { 
    document.getElementsByClassName("info-views")[0].innerHTML = "You have watched " +
    localStorage.views + " words today";
  }, 250);

};

var voiceText = function () {

  if (document.getElementsByClassName("word-eng").length > 0) {
    var valueElem = document.getElementsByClassName("word-eng")[0].innerHTML;
  }

  if (document.getElementsByClassName("show-word").length > 0) {
    var valueElem = document.getElementsByClassName("show-word")[0].innerHTML;
  }

  if (valueElem !== 'undefined' && valueElem !== '') {
    responsiveVoice.speak(valueElem, "US English Male");

  } else {
    console.log('error');
  }

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

  if (parseInt(localStorage.day) !== currentDay) {
    localStorage.clear();
  }

};

document.addEventListener("DOMContentLoaded", function() {
  
  if (location.href.split('?')[0].split('/').slice(-1) == 'words') {
    countWatchedWords();
  }

});
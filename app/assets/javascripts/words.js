$(document).ready(function(){
  hideRus = $(".hide_rus");
  hideRus.on('click', function () {
    $(hideRus).fadeOut(350);
  })
  sidebar = $('.sidebar_search');
  toggle_button = $('.options_search_button');
  toggle_button.click(function() {
    sidebar.toggle(function(){
    sidebar.animate({width:300});
  })
});
});

var voiceText = function() {

  if (document.getElementsByClassName("word_eng").length > 0) {
    var valueElem = document.getElementsByClassName("word_eng")[0].innerHTML;
  }

  if (document.getElementsByClassName("show_word").length > 0) {
    var valueElem = document.getElementsByClassName("show_word")[0].innerHTML;
  }

  if (valueElem != 'undefined' && valueElem != '') {
    responsiveVoice.speak(valueElem, "US English Male");

  } else {
    console.log('error');
    
  }

};

// function getRandomIntInclusive() {
//   min = Math.ceil(1);
//   max = Math.floor(100);
//   return Math.floor(Math.random() * (max - min + 1)) + min;
// }

// window.onload = function () {
//   var a = getRandomIntInclusive(),
//       b = getRandomIntInclusive(),
//       result = a + b,
//       i = false;

//   var getResponse = function() {
//     alert('Выражение: ' + a + ' + ' + b + ' = ?');
//     response = prompt('Введите ответ');

//   }
//   getResponse();

//   while (i == false) {
//     if (result == response) {
//       alert('Правильный ответ, вы молодец!');
//       i = true;
//     } else {
//       alert('Неправильный ответ, фи.');
//       getResponse();

//     }
//   }
// }
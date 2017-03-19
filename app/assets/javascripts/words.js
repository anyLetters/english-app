$(document).ready(function() {

  hideRus = $(".hide-rus"),
  rusField = $('.rus-field'),
  getWordButton = $('.get-word');
  // hideRus.height(rusField.outerHeight());

  hideRus.on('click', function() {
    $(hideRus).fadeOut(350);
  });

  getWordButton.on('click', function() {
    $('.hide-rus').show();
  });
  
  sidebar = $('.sidebar-content');
  toggle_button = $('.options-search-button');
  toggle_button.click(function() {
    sidebar.fadeToggle('default','swing');
  });

  $(window).resize(function() {
    hideRus.height(rusField.outerHeight());
  });

  // Resizing the table, if its size larger than div
  if ($.isNumeric(location.href.split('?')[0].split('/').slice(-1)[0])) {

    let fontSize1 = 4.7,
        fontSize2 = 3,
        fontSize3 = 2.4,
        rowHeight = 10;

    if ($('.show-word-table').height() > $('.show-content').height()) {
      while ($('.show-word-table').height() > $('.show-content').height()) {
        fontSize1 -= (fontSize1 / 100);
        fontSize2 -= (fontSize2 / 100);
        fontSize3 -= (fontSize3 / 250);
        rowHeight -= (rowHeight / 100);

        $('.show-part-of-speach-td').css({'font-size': fontSize1.toFixed(2) + 'vmin'});
        $('.show-translation-td').css({'font-size': fontSize2.toFixed(2) + 'vmin'});
        $('.examples-td').css({'font-size': fontSize3.toFixed(2) + 'vmin'});
        $('.show-tr').css({'height': rowHeight.toFixed(2) + 'vmin'});
      }
    }
  }

});

const scrollTableEvent = {
  smoothToBottom: function() {
    $('.index-scroll-word').animate({
      scrollTop: $('.index-word-table')[0].scrollHeight
    }, 500);
  },

  smoothToTop: function() {
    $('.index-scroll-word').animate({
      scrollTop: 0
    }, 500);
  },

  smoothToId: function(id) {
    if (id !== '') {
      let element = document.getElementById(id);
      element.scrollIntoView(true);
    }
  }
}

var voiceText = function (element) {

  if (typeof element !== 'undefined')
    var text = document.getElementsByClassName(element.className)[0].innerHTML;
  else
    var text = document.getElementsByClassName("word-eng")[0].innerHTML;

  if (typeof text !== 'undefined' || text !== '')
    responsiveVoice.speak(text, "US English Male");
  else
    console.log('error');

};

//delete it if I will want to return back lol
const getWord = {

  offset: 0,
  
  urlsUpdate: function(word) {
    for (let i = 0; i < document.getElementsByClassName('REST-links').length; i++) {
      switch (document.getElementsByClassName('REST-links')[i].id) {
        case 'REST-edit':
          document.getElementsByClassName('REST-links')[i].setAttribute('href', '/words/' + word.id + '/edit');
          break;
        case 'REST-show':
          document.getElementsByClassName('REST-links')[i].setAttribute('href', '/words/' + word.id);
          break;
        case 'REST-delete':
          document.getElementsByClassName('REST-links')[i].setAttribute('href', '/words/' + word.id);
      }
    }
  },

  displayWord: function(word) {
    document.getElementsByClassName('word-eng')[0].innerHTML = word.eng;
    document.getElementsByClassName('word-rus')[0].innerHTML = word.rus;
    let timestamp = new Date(word.created_at).getTime(),
        toDate = new Date(timestamp).getDate(),
        toMonth = new Date(timestamp).getMonth() + 1,
        toYear = new Date(timestamp).getFullYear(),
        date = toMonth+'/'+toDate+'/'+toYear;
    document.getElementsByClassName('created-at')[0].innerHTML = 'This word was added at ' + date;
  },

  randomMethod: function() {
    let word = gon.selectedWords[Math.floor(Math.random()*gon.selectedWords.length)];
    this.urlsUpdate(word);
    this.displayWord(word);
  },

  consistentMethod: function() {
    if (this.offset >= gon.selectedWords.length) this.offset = 0;
    let word = gon.selectedWords[this.offset];
    this.urlsUpdate(word);
    this.displayWord(word);
    this.offset++;
  },

  search: function(text) {
    for (let i = 0; i < gon.allWords.length; i++) {
      if (gon.allWords[i].eng == text) {
        let word = gon.allWords[i];
        this.urlsUpdate(word);
        this.displayWord(word);
        break;
      }
    }
  }
}

var checkParams = function(params) {
  if ((params.idFrom == null && params.idTo == null && params.lastIds == null && params.firstLetter == null) ||
      (params.idFrom == null && params.idTo !== null) || (params.idFrom !== null && params.idTo == null)) 
    return 0; 
  else 
    return 1;
}

var setMethod = function () {
  let params = location.href.split('&');
  params.shift()

  if (params.length > 0) {

    for (let i = 0; i < params.length - 1; i++) {
      if (params[i].split('=')[1].length > 0) {
        params[i] = params[i].split('=')[1];
      } else {
        params[i] = null;
      }
    }

    let paramsObj = {
      idFrom: params[0],
      idTo: params[1],
      lastIds: params[2],
      firstLetter: params[3]
    }

    if (checkParams(paramsObj) == 1) {
      getWord.consistentMethod();
    } else {
      console.log('Error: invalid params');
      getWord.randomMethod();
    }
  } else {
    getWord.randomMethod();
  }
}

var searchWord = function () {
  let text = document.getElementById('search').value;
  if (text !== '') {
    getWord.search(text);
    hideRus.show();
  } else {
    console.log('Error: invalid search value');
  }
}
//end

var countViewsReset = function () {

  if (!localStorage.day) {
    var date = new Date();
    var today = date.getDate;
    today = today.call(date);
    localStorage.day = today;
  }

  date = new Date();
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
    document.getElementsByClassName("info-views")[0].innerHTML = "You watched " +
    localStorage.views + " words today";
  }, 0);

};

document.addEventListener("DOMContentLoaded", function() {

  setMethod();
  hideRus.height(rusField.outerHeight());

  if (location.href.split('?')[0].split('/').slice(-1) == 'words') {
    countWatchedWords();
  }

});
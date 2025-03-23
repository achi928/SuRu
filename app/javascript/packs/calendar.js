
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

import tippy from 'tippy.js';

// ブラウザがHTMLを読み込んだら、ジャバスクリプトを動かす
//document.addEventListener('DOMContentLoaded', function() { 
// turbolinkがHTMLを読み込んだら、ジャバスクリプトを動かす
document.addEventListener('turbolinks:load', function () {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    var calendar = new Calendar(calendarEl, {
      plugins: [ dayGridPlugin ],
      initialView: 'dayGridMonth',
      events: 'mypage.json',
      eventDidMount: (e) => {
        tippy(e.el, {
          content: e.event.extendedProps.description,
          allowHTML: true
        });
      }
    });

    calendar.render();

  } else {
    console.log('カレンダーの要素が見つかりません');
  }
});

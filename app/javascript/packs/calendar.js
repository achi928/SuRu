
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

// ブラウザがHTMLを読み込んだら、ジャバスクリプトを動かす
//document.addEventListener('DOMContentLoaded', function() { 
// turbolinkがHTMLを読み込んだら、ジャバスクリプトを動かす
document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');
  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    initialView: 'dayGridMonth',
    events: 'mypage.json'
  });

  calendar.render();
});
import tippy from 'tippy.js';

document.addEventListener('turbolinks:load', function () {
  tippy('.tooltip_comment', {
    content: '投稿したcommentは、確認することができません。',
    placement: 'top',
    arrow: true,
  });
});
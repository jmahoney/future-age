$( document ).ready(function() {
  document.body.addEventListener('ajax:success', function(event) {
    if (event.target.id.startsWith("star-toggle-")){
      var emoji = data.starred ? "🤩" : "😶";
      event.target.text = emoji;
    }
  })
})
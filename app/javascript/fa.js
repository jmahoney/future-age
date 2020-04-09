$( document ).on("turbolinks:load",function() {
  document.body.addEventListener('ajax:success', function(event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];

    if (event.target.id.startsWith("star-toggle-")){
      var emoji = data.starred ? "🤩" : "😶";
      event.target.text = emoji;
    }
  })

  document.body.addEventListener("keyup", function(event) {
    if (event.isComposing || event.keyCode === 229) {
      return;
    }

    var selectedArticle = $("article.selected").first();
    var articleToMoveTo;

    if (selectedArticle && (event.keyCode === 74 || event.keyCode === 75)) {
      if (event.keyCode === 74) {
        articleToMoveTo = selectedArticle.next();
      } else {
        articleToMoveTo = selectedArticle.prev();
      }

      if (articleToMoveTo.is('article')) {
        selectedArticle.removeClass("selected");
        articleToMoveTo.addClass("selected");
        articleToMoveTo[0].scrollIntoView();
      }
    }

  })
})
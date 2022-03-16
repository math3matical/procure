// if any of these are enabled, javascript doesn't work
//import "@hotwired/turbo-rails"
//import "rails/ujs"
//import "controllers"
//
//If I enable "rails/ujs" in the app/javascript/application.js file, this works on first load.
//However, doing so makes the Turbo "Remove" not work when trying to delete objects elsewhere,
//e.g. cases, bugs, articles, etc.
//Otherwise, need to refresh the page before this works.

//window.addEventListener("load", () => {
  const links = document.querySelectorAll(
    "button[id='greet-user-button']"
  );
  links.forEach((element) => {
    element.addEventListener("click", (event) => {
      event.preventDefault();
      var x = document.getElementsByClassName("box80")
      var y = document.getElementById("greet-user-button")
      y.innerText = y.innerText === 'Expand' ? 'Shrink' : 'Expand';
      for (var i = 0; i < x.length; i++){
        var s = x[i].style;
        s.display = s.display === 'none' ? 'block' : 'none';
      }
    });
  });
//});

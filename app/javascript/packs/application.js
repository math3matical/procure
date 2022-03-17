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

// if any of these are enabled, javascript doesn't work
//import "@hotwired/turbo-rails"
//import "rails/ujs"
//import "controllers"
//
//If I enable "rails/ujs" in the app/javascript/application.js file, this works on first load.
//However, doing so makes the Turbo "Remove" not work when trying to delete objects elsewhere,
//e.g. cases, bugs, articles, etc.
//Otherwise, need to refresh the page before this works.


document.getElementById("tag_group").addEventListener("change", () => {
  var  test = document.getElementById("tag_item_id");
  var test2 = document.getElementById("tag_group");
  fetch(`/tag_groups/${test2.value}/tag_items`, {
    method: "GET",
    headers: {
      Accept: "application/json",
    },
  },
  ).then(response => {
    if (response.ok) {
      console.log(`Test length: ${test.length}`)
      for (var i = test.length-1; i >= 0; i--) {
        console.log(i);
        test.remove(i);
      }
      response.json().then(json => {
        console.log(`Json length: ${json.length}`)
        var selectList = document.createElement("select");
        var option = document.createElement('option');
//        option.value = 0;
//        option.text = "Select tag item";
//        test.appendChild(option);
        for (var i = 0; i < json.length; i++) {
          var option = document.createElement('option');
          console.log(i);
          option.value = json[i]["id"];
          option.text = json[i]["name"];
          test.appendChild(option);
        }
      });
    }
  });
});

function do_something(){
  window.location.reload();
}
const forms = document.querySelectorAll("form");
const form = document.getElementById("submit-tag");
forms.forEach((form) => {
  form.addEventListener("submit", (event) => {
//    if (form.id == "filter-form") {
//      var  test = document.getElementById("tag_item_id");
//      var test2 = document.getElementById("tag_group");
      flip(event)
//      event.preventDefault()
//      fetch('/test/addfilter', {
//        method: "POST",
//        headers: { 
//          Accept: "text/html",
//        },
//        body: JSON.stringify({ tag_group_id: "${test.value}" }),
//        parameters: { filter: test.value }
//      });
//    }
    
  })
});

document.getElementById("submit-tag").addEventListener("click", () => {
  var test = document.getElementById("tag_items_id");
  var test2 = document.getElementById("tag_group");
  var test3 = document.getElementById("tag_tag_taggable_id");
  var test4 = document.getElementById("tag_tag_taggable_type");
  var select = document.getElementById("tag_submit").value;
  if (select == ""){
    console.log("blank");
  } else {
    console.log("something");
    fetch(`/tags`, {
      method: "POST",
      headers: {
        Accept: "application/json",
      }
    });
  }
});


//window.addEventListener("load", () => {

function flip(event) {
//  event.preventDefault()
  var x = document.getElementsByClassName("form_tag")
  var y = document.getElementById("button-filter")
  y.innerText = y.innerText === 'Filter' ? 'Shrink' : 'Filter';

  for (var i = 0; i < x.length; i++){
    var s = x[i].style;
    s.display = s.display === 'none' ? 'block' : 'none';
  }
}

  const links = document.querySelectorAll(
    "button[id='button-filter']"
  );
  links.forEach((element) => {
    element.addEventListener("click", (event) => {
      event.preventDefault();
      var x = document.getElementsByClassName("form_tag")
      var y = document.getElementById("button-filter")
      var z = document.getElementsByClassName("filter-clear")
      y.innerText = y.innerText === 'Filter' ? 'Shrink' : 'Filter';
      for (var i = 0; i < z.length; i++){
        z.display = z.display === 'none' ? 'inline' : 'none';
      }
      for (var i = 0; i < x.length; i++){
        var s = x[i].style;
        s.display = s.display === 'none' ? 'block' : 'none';
      }
    });
  });
//});

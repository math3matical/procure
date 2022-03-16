//$(document).on("change", "click", function(){
//  var country = $(this).val();
//  $.ajax({
//    url: "/tag_items",
//    method: "GET",  
//    dataType: "json",
//    data: {tag_group: tag_group},
//    error: function (xhr, status, error) {
//      console.error('AJAX Error: ' + status + error);
//    },
//    success: function (response) {
//      console.log(response);
//    }
//  });
//});

document.getElementById("tag_tag_group_id").addEventListener("change", () => {
  var  test = document.getElementById("tag_tag_item_id");
  var test2 = document.getElementById("tag_tag_group_id");
//  fetchText();
//  async function fetchText() {
//    let response = await fetch(`/tag_groups/1/tag_items`);
//    let data = await response.text();
//  }
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
        option.value = 0;
        option.text = "Select tag item";
        test.appendChild(option);
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

// https://stackoverflow.com/questions/8664486/javascript-code-to-stop-form-submission
function validateMyForm() {
  var select = document.getElementById("tag_submit").value;
  if (select == ""){
    returnToPreviousPage();
    return false;
  }
  return true;
}

document.getElementById("tag_submit").addEventListener("click", () => {
  var test = document.getElementById("tag_tag_items_id");
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

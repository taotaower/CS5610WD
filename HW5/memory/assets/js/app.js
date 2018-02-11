// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

//import run_demo from "./demo";
//require('assets/css/app.scss');
import run_demo from "./memo"

import socket from "./socket";


//     $('#game-button').click(() => {
//         let xx = $('#game-input').val();
//     channel.push("double", { xx: xx }).receive("doubled", msg => {
//         $('#game-output').text(msg.yy);
// });
// });




function init() {

  let root = document.getElementById('game');

  if (root){
      console.log("try to join channel");

      let channel = socket.channel("games:" + window.gameName, {});

      run_demo(root,channel);
  //run_demo(root,channel);
  }

}

// Use jQuery to delay until page loaded.
$(init);

$('#submit-name').on('click',function(){

    var name = $("#game-name").val();
    var url      = window.location.href;

    if (name){
        document.location = url + 'game/' + name
    }
    else {
        alert("You have to input a game name")
    }


});
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
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$("#change-time").on("click", "#add-time", function() {
    var timeInput = $("#task_time_spent");
    var time = timeInput.val();

    time = parseInt(time) + 1;

    timeInput.attr("value",time);

    time = time * 15;

    var line =  convertMinsToHrsMins(time);
    $('#time-display').text(line)

});

$("#change-time").on("click", "#reduce-time", function() {
    var timeInput = $("#task_time_spent");
    var time = timeInput.val();

    time = parseInt(time) - 1;
    if (time <0){
        return
    }
    timeInput.attr("value",time);

    time = time * 15;


    var line =  convertMinsToHrsMins(time);
    $('#time-display').text(line)

});

//var time = $(".task_time_spent").val();
//var line = convertMinsToHrsMins(parseInt(time) * 15);

//$('.time-td').text('sss');

$('.time-display').each(function() {
    var time = $(this).attr('data-time');
    var line = convertMinsToHrsMins(parseInt(time) * 15);

    $(this).text(line);

});

function convertMinsToHrsMins(mins) {
    let h = Math.floor(mins / 60);
    let m = mins % 60;
 //   h = h < 10 ? '0' + h : h;
 //   m = m < 10 ? '0' + m : m;
    return `${h} hour(s) ${m} min(s)`;

}
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

////////////////////////////////////////////////////////////////



function update_buttons() {
    $('.manager-button').each( (_, bb) => {
        let user_id = $(bb).data('user-id');
    let manager = $(bb).data('manager');
    if (manager != "") {
        $(bb).text("Cancel");
    }
    else {
        $(bb).text("Assign");
    }
});
}


function set_button(user_id, value) {
    $('.manager-button').each( (_, bb) => {
        if (user_id == $(bb).data('user-id')) {
        $(bb).data('manager', value);
    }
});
    update_buttons();
}



function selected(user_id) {
    let text = JSON.stringify({
        relation: {
            manager_id: user_id,
            underling_id: current_user_id

        },
    });
    console.log(text);
    console.log(relation_path);
    $.ajax(relation_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => { set_button(user_id, resp.data.id); },
});
}



function unselected(user_id, manager_id) {
    $.ajax(relation_path + "/" + manager_id, {
        method: "delete",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: "",
        success: () => { set_button(user_id, ""); },
});
}


function select_click(ev) {
    let btn = $(ev.target);
    let manager_id = btn.data('manager');
    let user_id = btn.data('user-id');

    if (manager_id != "") {
        unselected(user_id, manager_id);
    }
    else {
        selected(user_id);
    }
}

function init_manager() {
    if (!$('.manager-button')) {
        return;
    }

    $(".manager-button").click(select_click);

    update_buttons();
}

$(init_manager);
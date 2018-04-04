
import React from 'react';

import {Redirect} from 'react-router'
import Tasks from "./task-table";




function My_Tasks(props) {

    if (props.token) {

        return Tasks(_.filter(props.tasks, (task) =>
            props.token.user_id == task.user.id ), "Your Tasks")
    }

    else {
        return  <Redirect to='../'/>;
    }

}


export default My_Tasks
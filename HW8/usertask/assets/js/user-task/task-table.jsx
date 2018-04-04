import React from 'react';
import { NavLink } from 'react-router-dom';

import api from '../api';


class Task extends React.Component{
    constructor(props) {
        super(props);

        this.task = props.task;
        this.label = props.label;
    }

    time_convert(num){

        let mins = parseInt(num) * 15
        let h = Math.floor(mins / 60);
        let m = mins % 60;
        return `${h} hour(s) ${m} min(s)`
    }

    task_complete(complete){

        if (complete){
            return <td class="col-1">Yes</td>
        }else {
            return <td class="col-1">No</td>
        }

    }

    delete_task(id){

        api.delete_task(id);

    }

    edit_task(id){
        api.get_task(id);
        $("#go_edit")[0].click();

    }

    render(){

        if(this.label === "All Tasks"){
            window.path = "/"
        }else {
            window.path = "/my-tasks"
        }



        return <tr class="row">
            <td class="col-2 text-truncate">{this.task.title}</td>
            <td class="col-3 text-truncate">{this.task.desc}</td>
            <td class="col-2 time-display" data-time ={this.task.time_spent}>{this.time_convert(this.task.time_spent)}</td>
            {this.task_complete(this.task.complete)}
            <td class="col-2">{this.task.user.name} </td>

            <td class="text-right col-2">
                <NavLink id="go_edit" to="/edit-task" href="#"  className="nav-link" hidden>Edit</NavLink>
                <span><button className={"btn btn-success"}  onClick={() => this.edit_task(this.task.id)}>Edit</button></span>
                <span><button className={"btn btn-danger"}  onClick={() => this.delete_task(this.task.id)}>Delete</button></span>
            </td>
        </tr>
    }


}


function Tasks(tasks,label){


    let task_table = _.map(tasks, (task) =>

        <Task
            key = {task.id + task.title + task.desc + task.time_spent + task.complete + task.user.name}
            task = {task}
            label = {label}/>
    );

    return <div>
        <h2>{label}</h2>

        <table class="table">
            <thead>
            <tr class="row">
                <th class="col-2">Title</th>
                <th class="col-3">Description</th>
                <th class="col-2">Time spent</th>
                <th class="col-1">Complete</th>
                <th class="col-1">User</th>
                <th class="col-3"></th>
            </tr>
            </thead>
            <tbody>
            {task_table}
            </tbody>
        </table>
    </div>
}

export default Tasks;
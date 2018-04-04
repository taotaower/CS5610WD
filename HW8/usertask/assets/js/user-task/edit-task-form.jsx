import React from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import { Form, Button, FormGroup, Label, Input , NavItem, } from 'reactstrap';
import api from '../api';

import {Redirect} from 'react-router'

function EditTaskForm(props) {

    function update(ev) {
        let tgt = $(ev.target);

        let data = {};

        if (tgt.attr('name') === "complete") {

            data["complete"] = !(tgt.val().toString() === 'true');

        }
        else {
            data[tgt.attr('name')] = tgt.val();
        }

        console.log(data);



        let action = {
            type: 'UPDATE_EDIT_TASK_FORM',
            data: data,
        };
        props.dispatch(action);
    }

    function submit() {

        if (props.edit_taskform.title.length === 0){

            $("#title_helper").text("title cannot be blank");

            return
        }
        else{
            $("#title_helper").text("");
        }

        if (props.edit_taskform.desc.length === 0){

            $("#desc_helper").text("description cannot be blank");

            return
        }
        else{
            $("#desc_helper").text("");
        }

        if (props.edit_taskform.user_id.length === 0){

            $("#user_id_helper").text("you have to assign this task");

            return
        }
        else{
            $("#user_id_helper").text("");

        }

        api.edit_task(props.edit_taskform.id, props.edit_taskform);

        let go_back = $("#go_back")[0];

        go_back.click();


    }

    function clear() {
        $("#title_helper").text("");
        $("#desc_helper").text("");
        $("#user_id_helper").text("");


        props.dispatch({
            type: 'CLEAR_EDIT_TASK_FORM',
        });


        props.dispatch({
            type: 'SET_TOKEN',
            token: props.token,
        });
    }


    function update_time(num) {

        let data ={time_spent: num};

        let action = {
            type: 'UPDATE_EDIT_TASK_FORM',
            data: data,
        };
        props.dispatch(action);

    }

    function add_time(time) {

        time = parseInt(time) + 1;

        update_time(time)

    }

    function reduce_time(time) {

        time = parseInt(time) - 1;
        if (time <0){
            time = 0
        }

        update_time(time)

    }

    function time_convert(num){

        let mins = parseInt(num) * 15;
        let h = Math.floor(mins / 60);
        let m = mins % 60;
        return `${h} hour(s) ${m} min(s)`
    }
    let users = _.map(props.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name} -  {uu.email}</option>);



    if (props.token) {

        let path = window.path;
        return <div style={{padding: "4ex"}}>

            <h2>New Task</h2>


            <FormGroup>
                <Label for="title">Title</Label>
                <Input type="textarea" name="title" value={props.edit_taskform.title} onChange={update} placeholder="title">
                </Input>
                <span id={"title_helper"}></span>
            </FormGroup>
            <FormGroup>
                <Label for="user_id">User</Label>
                <Input type="select" name="user_id" value={props.edit_taskform.user_id} onChange={update}>
                    {/*<option key="" value="">Not Assigned</option>*/}
                    { users }
                </Input>
                <span id={"user_id_helper"}></span>
            </FormGroup>

            <FormGroup>
                <Label for="desc">Description</Label>
                <Input type="textarea" name="desc" value={props.edit_taskform.desc} onChange={update}>
                </Input>
                <span id={"desc_helper"}></span>
            </FormGroup>

            <FormGroup>
                <Label for="time_spent">Time Spent</Label>
                <div hidden>
                    <Input id={"task_time_spent"} type="number_input" name="time_spent" value={props.edit_taskform.time_spent} onChange={update} ></Input>
                </div>
                <div class="card">
                    <div class="input-group-prepend" id ="change-time" >
                        <NavLink id="go_back" to= {path} href="#"  className="nav-link" hidden>go back</NavLink>
                        <button id = "add-time" class="btn btn-outline-secondary" type="button" onClick={() => add_time(props.edit_taskform.time_spent)}>Add Time</button>
                        <button id = "reduce-time" class="btn btn-outline-secondary" type="button" onClick={() => reduce_time(props.edit_taskform.time_spent)}>Reduce Time</button>
                    </div>
                    <div class="card-body time-display" id="time-display" data-time = "0" >
                        {time_convert(props.edit_taskform.time_spent)}
                    </div>
                </div>
            </FormGroup>

            <FormGroup>
                <Label for="complete">Complete</Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                <Input type="checkbox" name="complete" value={props.edit_taskform.complete} onChange={update} checked={props.edit_taskform.complete} />
            </FormGroup>


            <Button onClick={submit} color="primary">Submit</Button> &nbsp;
            <Button onClick={clear}>Clear</Button>

        </div>

    }
    else {
        return  <Redirect to='../'/>;
    }

}



function state2props(state) {

    return {
        edit_taskform: state.edit_taskform,
        users: state.users,
        token: state.token,
    };
}

export default connect(state2props)(EditTaskForm);
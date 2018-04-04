
import React from 'react';
import { connect } from 'react-redux';
import { NavLink } from 'react-router-dom';
import { Form, Button, FormGroup, Label, Input , NavItem} from 'reactstrap';
import api from '../api';




function UserForm(props) {


    function update(ev) {
        let tgt = $(ev.target);

        let data = {};
        data[tgt.attr('name')] = tgt.val();
        let action = {
            type: 'UPDATE_USER_FORM',
            data: data,
        };
        props.dispatch(action);
    }

    function submit(ev) {
      //  let re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (props.userform.name.length === 0){

            $("#name_helper").text("name cannot be blank");

            return
        }
        else{
            $("#name_helper").text("");
        }

        if (props.userform.email.length === 0){

            $("#email_helper").text("email cannot be blank");

            return
        }
        else{
            $("#email_helper").text("");
        }

        // if (re.test(props.userform.email)){
        //
        //     $("#email_helper").text("please input a valid email");
        //
        //     return ;
        //
        // }else
        // {
        //     $("#email_helper").text("");
        // }

        if (props.userform.password.length === 0){

            $("#pass_helper").text("password cannot be blank");

            return
        }
        else{
            $("#pass_helper").text("");

        }

        api.regiser(props.userform);
        document.location = window.url_location
    }

    function clear(ev) {
        $("#name_helper").text("");
        $("#email_helper").text("");
        $("#pass_helper").text("");
        props.dispatch({
            type: 'CLEAR_USER_FORM',
        });
    }

    let users = _.map(props.users, (uu) => <tr>
            <td> {uu.email}</td>
            <td> {uu.name}</td>

            <td class="text-right">
                <span></span>
                <span></span>
                <span></span>
            </td>
        </tr>
    );
    return <div style={{padding: "4ex"}}>
        <div className={"row"}>
            <div className={"col-10"}>
                <h2>New User</h2>
            </div>
            <div className={"col-2"}>
                <NavLink type="button" to="/" href="#" className="nav-link"> Back </NavLink>
            </div>
        </div>

        <FormGroup>
            <Label for="name">User Name</Label>
            <Input type="textarea" name="name" value={props.userform.name} onChange={update} placeholder="name">
            </Input>
            <span id={"name_helper"}></span>
        </FormGroup>
        <FormGroup>
            <Label for="email">Email</Label>
            <Input type="textarea" name="email" value={props.userform.email} onChange={update} placeholder="email">
            </Input>
            <span id={"email_helper"}></span>
        </FormGroup>

        <FormGroup>
            <Label for="pass">Password</Label>
            <Input type="password" name="password" value={props.userform.password} onChange={update} placeholder="password">

            </Input>
            <span id={"pass_helper"}></span>
        </FormGroup>
        <Button onClick={submit} color="primary">Submit</Button> &nbsp;
        <Button onClick={clear}>Clear</Button>

        <h2></h2>
        <h2></h2>
        <h2></h2>
        <h2></h2>

        <h2 >Listing Users</h2>

        <table class="table">
            <thead>
            <tr>
                <th>Email</th>
                <th>Name</th>

                <th></th>
            </tr>
            </thead>
            <tbody>

            {users}
            </tbody>
        </table>


    </div>;
}

function state2props(state) {
    console.log("rerender@UserForm", state);
    return {
        userform: state.userform,
        users: state.users,
    };
}

export default connect(state2props)(UserForm);
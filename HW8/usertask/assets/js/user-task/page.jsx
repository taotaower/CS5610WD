import React from 'react';
import { NavLink } from 'react-router-dom';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';



import Tasks from './task-table';


let LoginForm = connect(({login}) => {return {login};})((props) => {
    function update(ev) {
        let tgt = $(ev.target);
        let data = {};
        data[tgt.attr('name')] = tgt.val();
        props.dispatch({
            type: 'UPDATE_LOGIN_FORM',
            data: data,
        });
    }

    function create_token(ev) {
        if (props.login.email.length === 0){

            $("#email_helper").text("email cannot be blank");

            return
        }
        else{
            $("#email_helper").text("");
        }

        if (props.login.pass.length === 0){

            $("#pass_helper").text("password cannot be blank");

            return
        }
        else{
            $("#pass_helper").text("");

        }

        api.submit_login(props.login);

        let alert = $('.alert')

        //alert.delay(2000).show();

        alert.delay(2000).fadeIn(0);
        alert.delay(2000).fadeOut(0);


    }

    return <div className="navbar-text">
        <h1>Welcome to Task Management System</h1>
        <div class="alert alert-danger" role="alert" style={{display: 'none'}}>
            Login Information is Wrong Please re-enter
        </div>


        <Form>
            <FormGroup>
                <Input type="text" name="email" placeholder="email"
                       value={props.login.email} onChange={update} />
                <span id={"email_helper"}></span>
            </FormGroup>
            <FormGroup>
                <Input type="password" name="pass" placeholder="password"
                       value={props.login.pass} onChange={update} />
                <span id={"pass_helper"}></span>
            </FormGroup>
            <Button onClick={create_token}>Log In</Button>
        </Form>

    </div>;
});






function Page(props){


    if (props.token) {
        return <div>{Tasks(props.tasks, "All Tasks")}</div>
    }
    else {
        return <LoginForm />
    }


}






function state2props(state) {
    return {
        token: state.token,
        tasks: state.tasks,
    };
}

export default connect(state2props)(Page);
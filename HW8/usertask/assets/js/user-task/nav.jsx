import React from 'react';
import { NavLink } from 'react-router-dom';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';







function Nav(props) {

    function logout() {
        document.location = window.url_location
    }

    function delete_accounet() {

        api.delete_user(props.token.user_id);


        document.location = window.url_location
    }
    if (props.token) {
        return (
            <nav className="navbar navbar-dark bg-dark navbar-expand">
      <span className="navbar-brand">
        TaskHub
      </span>
                <ul className="navbar-nav mr-auto">


                    <NavItem>
                        <NavLink to="/" href="#" activeClassName="active" className="nav-link">All Tasks in System</NavLink>
                    </NavItem>

                    <NavItem>
                        <NavLink to="/my-tasks" href="#"  className="nav-link">My Tasks</NavLink>
                    </NavItem>

                    <NavItem>
                        <NavLink to="/new-task" href="#"  className="nav-link">Create Task</NavLink>
                    </NavItem>


                </ul>
                <UserInfo login={props.login} />
                &nbsp;&nbsp;&nbsp;
                <NavItem>
                    <Button onClick={logout}>Log Out</Button>
                    <Button onClick={delete_accounet}>Delete My Account</Button>
                </NavItem>
            </nav>
        );
    }
    else {
        return <nav className="navbar navbar-dark bg-dark navbar-expand">
      <span className="navbar-brand">
        TaskHub
      </span>

            <ul className="navbar-nav mr-auto">


                <NavItem>
                    <NavLink to="/register" href="#" className="nav-link"> Register </NavLink>
                </NavItem>

            </ul>
        </nav>
    }


}


let UserInfo = connect(({login}) => {return {login};})((props) => {
    return <div className="navbar-text">
        Logged in as { props.login.email }
    </div>;
});



function state2props(state) {
    return {
        token: state.token,
    };
}

export default connect(state2props)(Nav);
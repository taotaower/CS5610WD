import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';




import Nav from './nav';
import Page from './page';

import UserForm from './user-form';
import TaskForm from './task-form';
import My_Tasks from "./my-tasks";
import EditTaskForm from "./edit-task-form";

export default function taskuser_init(store) {
    ReactDOM.render(
        <Provider store={store}>
            <Usertask state={store.getState()} />
        </Provider>,
        document.getElementById('root'),
    );
}




let Usertask = connect((state) => state)((props) => {

    return (
        <Router>
            <div>

                <Route path="/" exact={true} render={() =>
                    <div>
                    <Nav />
                    <Page />
                    </div>
                } />

                <Route path="/register" exact={true} render={() =>
                    <div>
                        <UserForm />
                    </div>
                } />

                <Route path="/new-task" exact={true} render={() =>
                    <div>
                        <Nav />
                        <TaskForm />
                    </div>
                } />


                <Route path="/edit-task" exact={true} render={() =>
                    <div>
                        <Nav />
                        <EditTaskForm />
                    </div>
                } />

                <Route path="/my-tasks" exact={true} render={() =>
                    <div>
                        <Nav />
                        {My_Tasks(props)}
                    </div>
                } />
            </div>
        </Router>
    );
});



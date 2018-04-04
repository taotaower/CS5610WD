import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

/*
 *  state layout:
 *  {
 *   posts: [... Posts ...],
 *   users: [... Users ...],
 *   form: {
 *     user_id: null,
 *     body: "",
 *   }
 * }
 *
 * */

function tasks(state = [], action) {
  switch (action.type) {
  case 'TASKS_LIST':
    return [...action.tasks];

      case 'ADD_TASK':

    return [action.task,...state];

    case 'DELETE_TASK':
          return [...action.tasks];

      case 'EDIT_TASK':
          return [...action.tasks];
  default:
    return state;
  }
}

function users(state = [], action) {
  switch (action.type) {
  case 'USERS_LIST':
    return [...action.users];
    case 'ADD_USER':
        console.log(action.user);
          return [action.user, ...state];

      case 'DELETE_USER':
          return [...action.users];

      default:
    return state;
  }
}



let empty_task_form = {
    user_id: "",
    title: "",
    desc: "",
    time_spent: 0,
    complete: false,

};

function taskform(state = empty_task_form, action) {
  switch (action.type) {
    case 'UPDATE_TASK_FORM':
      return Object.assign({}, state, action.data);
    case 'CLEAR_TASK_FORM':
      return empty_task_form;
      case 'SET_TOKEN':
          return Object.assign({}, state, action.token);
    default:
      return state;
  }
}

function edit_taskform(state = empty_task_form, action) {
    switch (action.type) {
        case 'UPDATE_EDIT_TASK_FORM':
            return Object.assign({}, state, action.data);
        case 'CLEAR_EDIT_TASK_FORM':
            return empty_task_form;
        case 'SET_TOKEN':
      //      console.log("Set Tokennnnnnnnnnnnnnnnn");
            return Object.assign({}, state, action.token);
        default:
            return state;
    }
}

let empty_user_form = {
    name: "",
    email: "",
    password: "",


};


function userform(state = empty_user_form, action) {
    switch (action.type) {
        case 'UPDATE_USER_FORM':
            return Object.assign({}, state, action.data);
        case 'CLEAR_USER_FORM':
            return empty_user_form;

        default:
            return state;
    }
}

function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    default:
      return state;
  }
}

let empty_login = {
  email: "",
  pass: "",
};

function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

function root_reducer(state0, action) {


  //console.log("reducer", action);
  // {posts, users, form} is ES6 shorthand for
  // {posts: posts, users: users, form: form}
  let reducer = combineReducers({users, tasks,  taskform, userform,edit_taskform,token, login});
  let state1 = reducer(state0, action);
  console.log("state1", state1);
  return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;


import store from './store';

class TheServer {
  request_tasks() {
    $.ajax("/api/v1/tasks", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'TASKS_LIST',
          tasks: resp.data,
        });
      },
    });
  }


    delete_task(id) {
        $.ajax("/api/v1/tasks/" + id, {
            method: "delete",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({id:id}),
            success: (resp) => {
            store.dispatch({
            type: 'DELETE_TASK',
            tasks: resp.data,
        });
    },
    });
    }

    delete_user(id) {
        $.ajax("/api/v1/users/" + id, {
            method: "delete",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({id:id}),
            success: (resp) => {
            store.dispatch({
            type: 'DELETE_USER',
            users: resp.data,
        });
    },
    });
    }

    edit_task(id,task_params) {
        $.ajax("/api/v1/tasks/" + id, {
            method: "put",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({id:id,task: task_params}),
            success: (resp) => {
            store.dispatch({
            type: 'EDIT_TASK',
            tasks: resp.data,
        });
    },
    });
    }

    get_task(id) {
        $.ajax("/api/v1/tasks/" + id, {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({id:id}),
            success: (resp) => {
            store.dispatch({
            type: 'UPDATE_EDIT_TASK_FORM',
            data: resp.data,
        });
    },
    });
    }


  request_users() {
    $.ajax("/api/v1/users", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'USERS_LIST',
          users: resp.data,
        });
      },
    });
  }

  submit_task(data) {
    $.ajax("/api/v1/tasks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ token: data.token, task: data }),
      success: (resp) => {
        store.dispatch({
          type: 'ADD_TASK',
          task: resp.data,
        });
      },
    });
  }


    regiser(data) {
        $.ajax("/api/v1/users", {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({user:data}),
            success: (resp) => {
            store.dispatch({
            type: 'ADD_USER',
            user: resp.data,
        });
    },
    });
    }


  submit_login(data) {
    $.ajax("/api/v1/token", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: (resp) => {
        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
      },
    });
  }
  //
}

export default new TheServer();

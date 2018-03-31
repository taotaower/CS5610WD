defmodule UsertaskWeb.TaskView do
  use UsertaskWeb, :view
  alias UsertaskWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      complete: task.complete,
      desc: task.desc,
      title: task.title,
      time_spent: task.time_spent}
  end
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Usertask.Repo.insert!(%Usertask.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.




defmodule Seeds do
  alias Usertask.Repo
  alias Usertask.Tasks.Task
  alias Usertask.Accounts.User

  def run do
    p = Comeonin.Argon2.hashpwsalt("password1")

    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "alice", email: "alice@a.com", password_hash: p })
    b = Repo.insert!(%User{ name: "bob", email: "bob@b.com", password_hash: p })
    c = Repo.insert!(%User{ name: "carol", email: "carol@c.com", password_hash: p })
    d = Repo.insert!(%User{ name: "dave", email: "dave@d.com", password_hash: p })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, desc: "Hi, I'm Alice" , title: "Hi, I'm Alice",time_spent: 1, complete: true })
    Repo.insert!(%Task{ user_id: b.id, desc: "Hi, I'm Bob" , title: "Hi, I'm Alice",time_spent: 1, complete: false})
    Repo.insert!(%Task{ user_id: b.id, desc: "Hi, I'm Bob Again" , title: "Hi, I'm Alice",time_spent: 1, complete: true})
    Repo.insert!(%Task{ user_id: c.id, desc: "Hi, I'm Carol" , title: "Hi, I'm Alice",time_spent: 1, complete: false})
    Repo.insert!(%Task{ user_id: d.id, desc: "Hi, I'm Dave" , title: "Hi, I'm Alice",time_spent: 1, complete: true})
  end
end

Seeds.run
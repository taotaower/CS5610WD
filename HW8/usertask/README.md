# Design
User_Table: Email field is unique, cannot be duplicate

Task_Table: One Task related to One user, thus a user can have mutiple tasks

time field is integer, it means how many 15 mins user spent on one task, e.g. if user spent 45 mins , the field will be 3

# Back-end Design:

Use regex expression to check email format valid or not.

One user can check himself/herself tasks, or all tasks in the system.

# front-end Design:

Use redux to share data in whole SPA app

Use js to calculate time to display.

Use bootstrap to make display more beautiful.

Add data validation in front-end.




# Usertask

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

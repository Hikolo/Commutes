# Commutes
To start the service open an elixir shell in the root of the project with
iex -S mix
This compiles and starts the shell.
To add a stop first start create a worker
Worker.start_link
This will create a worker process with a predefined name.
Then run
Worker.add_stop("Stop_name")
With the stop_name you want to add, this will search and add the first result.
To add and update the departures run
Worker.update_departures

To start the periodically running service run
Periodically.start_link
This will create a periodically process that will create a worker and 
update the departures every 10 minutes.

Run Worker.reset_datebase to empty the database.

#!/bin/bash

# Attribution: refer to Prof's deploying script
export PORT=5103
export MIX_ENV=prod
export GIT_PATH=/home/usertask/src/usertask

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "usertask" ]; then
	echo "Error: must run as user 'usertask'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix ecto.migrate # migrate database
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/usertask ]; then
	echo mv ~/www/usertask ~/old/$NOW
	mv ~/www/usertask ~/old/$NOW
fi

mkdir -p ~/www/usertask
REL_TAR=~/src/usertask/_build/prod/rel/usertask/releases/0.0.1/usertask.tar.gz
(cd ~/www/usertask && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/usertask/src/usertask/start.sh
CRONTAB

#. start.sh
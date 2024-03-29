#!/bin/sh

# Start the first process
sh -c nginx -g 'daemon off;'
status=$?
if [ $status -ne 0 ]
then
  echo "Failed to start nginx_process: $status"
  exit $status
fi

# Start the second process
sh -c php-fpm7 --nodaemonize
status=$?
if [ $status -ne 0 ]
then
  echo "Failed to start php-fpm7_process: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 10
do
  ps aux |grep nginx |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep php-fpm |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]
  then
    echo "One of the processes has already exited."
    exit 1
  fi
done

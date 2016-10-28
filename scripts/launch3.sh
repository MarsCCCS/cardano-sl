#!/bin/bash

tmux new-window -n "pos-demo-"`date +%F_%H%M%S`

tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v

startTime=`date +%s`$((`date +%N`/1000))

envs="MAIN_LOG=$MAIN_LOG DHT_LOG=$DHT_LOG COMM_LOG=$COMM_LOG "

# to prevent all stacks from updating git at the same time and messing up
# each other
stack exec echo

tmux select-pane -t 0
tmux send-keys "$envs ./scripts/runSupporter.sh" C-m

tmux select-pane -t 1
tmux send-keys "$envs ./scripts/runNode.sh 0 $startTime" C-m

tmux select-pane -t 2
tmux send-keys "$envs ./scripts/runNode.sh 1 $startTime" C-m

tmux select-pane -t 3
tmux send-keys "$envs ./scripts/runNode.sh 2 $startTime" C-m

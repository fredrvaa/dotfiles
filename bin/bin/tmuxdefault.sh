#!/bin/bash

s="scout-portal-dev"

echo "Stopping running azure storage containers"
docker stop portal-azure-storage
docker stop huginn-test-storage

echo "Checking if tmux session '$s' exists..."
tmux has-session -t $s 2>/dev/null

if [ $? != 0 ]; then
  echo "Creating new tmux session: $s"
  tmux new-session -d -s $s -n web-portal -c ~/workspace/web-portal
  if [ $? != 0 ]; then
    echo "Failed to create tmux session."
    exit 1
  fi

  echo "Creating web-portal window..."
  tmux split-window -h -c ~/workspace/web-portal/src/frontend

  echo "Starting web-portal..."
  tmux send-keys -t $s:web-portal.1 'docker compose up django nginx' C-m
#  tmux send-keys -t $s:web-portal.2 'npm start' C-m

  echo "Creating huginn window..."
  tmux new-window -t $s -n huginn -c ~/workspace/web-portal-huginn/huginn-server
  tmux split-window -h -c ~/workspace/web-portal-huginn/huginn-media-worker
  tmux select-pane -t 1
  tmux split-window -v -c ~/workspace/web-portal-huginn/huginn-models

  echo "Starting huginn..."
  tmux send-keys -t $s:huginn.1 'npm run server:dev' C-m

  echo "Creating scout-portal window..."
  tmux new-window -t $s -n scout-portal -c ~/workspace/scout-portal/src/server
  tmux split-window -h -c ~/workspace/scout-portal/src/client

  tmux send-keys -t $s:scout-portal.1 'npm run dev' C-m
  tmux send-keys -t $s:scout-portal.2 'npm run dev' C-m

  echo "Creating other window..."
  tmux new-window -t $s -n other -c ~/workspace
else
  echo "Session '$s' already exists."
fi

echo "Attaching to session..."
tmux attach-session -t $s

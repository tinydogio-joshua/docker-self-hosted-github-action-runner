#!/bin/bash

ORGANIZATION=$ORGANIZATION
REPO=$REPO
ACCESS_TOKEN=$ACCESS_TOKEN

cd /home/docker/actions-runner

if [ -z "$REPO" ]; then
  REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/orgs/${ORGANIZATION}/actions/runners/registration-token | jq .token --raw-output)
  ./config.sh --url https://github.com/${ORGANIZATION} --token ${REG_TOKEN}
else
  REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}"   https://api.github.com/repos/${ORGANIZATION}/${REPO}/actions/runners/registration-token | jq .token --raw-output)
  ./config.sh --url https://github.com/${ORGANIZATION}/${REPO} --token ${REG_TOKEN}
fi

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!

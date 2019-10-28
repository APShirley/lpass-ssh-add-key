#!/bin/bash

set -euo pipefail

fetch-ssh-private-key() {
  echo "Fetching ssh-key"

  set +e
  lpass_ssh_key=$(lpass show --field="Private Key" "github-ssh-key")
  if [[ $? -gt 0 ]]; then
    echo "Failed to get github ssh-key!"
    exit 1
  fi
  set -e
  echo "${lpass_ssh_key}" > /tmp/ssh-key
  chmod 0600 /tmp/ssh-key
}

seconds-until-eod() {
  local now=$(date +%s)
  local eod=$(date -v 17H -v 30M +%s)
  seconds_until_eod=$(($eod-$now))
}

main() {
  lpass status
  fetch-ssh-private-key

  echo "Deleting all existing ssh-keys from agent."
  ssh-add -D

  set +u
  echo "How many hours? (leave empty to add key until: $(date -v 17H -v 30M))"
  read hours
  if [ -z "${hours}" ]; then
    echo "Adding key until $(date -v 17H -v 30M)"
    seconds-until-eod
    ssh-add -t ${seconds_until_eod} /tmp/ssh-key
  else
    echo "Adding key for ${hours} hours"
    ssh-add -t "${hours}"h /tmp/ssh-key
  fi
  set -u
  rm /tmp/ssh-key
}

main

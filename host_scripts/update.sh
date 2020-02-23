#!/bin/bash

set -ex

lucky set-status maintenance "Configuring application"

private_address=$(lucky private-address)
external_port="$(lucky random --available-port)"

lucky kv set "external_port=$external_port"
lucky set-status -n port active "Listening port: $external_port"

lucky container image set nginx:latest
lucky container port remove --all
lucky container port add "$external_port:80"

lucky set-status active

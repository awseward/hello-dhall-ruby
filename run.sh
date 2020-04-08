#!/usr/bin/env bash

set -euo pipefail

tempfile="$(mktemp -t config.dhall)"

( dhall resolve | dhall normalize > "${tempfile}" ) <<< ./config.dhall

bundle exec ruby run.rb "${tempfile}"

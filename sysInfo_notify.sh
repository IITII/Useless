#!/usr/bin/env bash
# simple system notify shell srcipt.
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
message=$(bash "${script_dir}/quickInfo.sh")
hook=$(cat "${script_dir}/slack-hook")
curl -X POST --data-urlencode "payload={\"text\": \"${message}\"}" "${hook}"


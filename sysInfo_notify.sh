#!/usr/bin/env bash
# simple system notify shell srcipt.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $script_dir && wget https://raw.githubusercontent.com/IITII/Useless/master/info.sh
message=$(bash "${script_dir}/info.sh" -s)
hook=$(cat "${script_dir}/slack-hook")
curl -X POST --data-urlencode "payload={\"text\": \"${message}\"}" "${hook}"
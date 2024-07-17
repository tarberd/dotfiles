function path() {
  echo -e ${PATH//:/\\n}
}

function loc() {
  cd /loc/${USER}
}

function jira() {
  cd /loc/${USER}/jira
}

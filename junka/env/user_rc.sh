function path() {
  echo -e ${PATH//:/\\n}
}

function loc() {
  cd /loc/${USER}
}

function jira() {
  cd /loc/${USER}/jira
}

alias Dgit="/usr/local/bin/Dgit"
alias Cgit="/usr/local/bin/Cgit"

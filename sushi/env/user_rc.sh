function path() {
  echo -e ${PATH//:/\\n}
}

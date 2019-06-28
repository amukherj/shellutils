#!/bin/sh

red=1
green=2
amber=3
blue=4
pink=5
sky=6
white=7
orange=9
grey=10
ash=11
lavender=13
indigo=16
navy=17

text() {
  color=${1:-${white}}
  echo "setaf ${color}"
}

bg() {
  color=${1:-${white}}
  echo "setab ${color}"
}

ul() {
  echo smul
}

em() {
  echo smso
}

blink() {
  echo blink
}

bold() {
  echo bold
}

style() {
  txt=${1}
  if [ -z "$txt" ]; then
    return
  fi

  shift
  if [ $# -le 0 ]; then
    return
  fi

  tput_cmd=""
  for style in "$@"; do
     # tput ${style}
     tput $(eval "${style}")
  done
  echo -n ${txt}; tput sgr0
}

# Examples
style "Hello, there!" "text $green" ul blink
echo ""
style "Hello, there!" "text $blue" ul bold
echo ""
style "Hello, there!" "text $pink" ul
echo ""
style "Hello, there!" "text $sky" blink
echo ""
style "Hello, there!" "text $amber" ul em
echo ""
style "Hello, there!" "bg $lavender" 
echo ""
style "Hello, there!" "bg $white" "text $red" bold
echo ""
style "Hello, there!" "text $white" "bg $blue" blink
echo ""


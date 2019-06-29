#!/bin/sh

black=0
red=1
green=2
yellow=3
blue=4
magenta=5
cyan=6
lightgray=7
darkgray=9
lightred=10
lightgreen=11
amber=12
lightblue=13
pink=14
lightcyan=15
navy=17

iblack=30
ired=31
igreen=32
iyellow=33
iblue=34
imagenta=35
icyan=36
ilightgray=37
idarkgray=90
ilightred=91
ilightgreen=92
iamber=93
ilightblue=94
ipink=95
ilightcyan=96
iwhite=97

ibold=1
idim=2
iul=4
iblink=5

text() {
  color=${1:-${lightgray}}
  echo "setaf ${color}"
}

bg() {
  color=${1:-${lightgray}}
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

## echo_style: echo a stylized version of the passed text
## echo the first argument after applying styles
## passed in the additional arguments.
## Examples:
##   echo_style "Hello, world!" "text $green" ul blink bold
##
echo_style() {
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

## istyle: inline style.
## generate stylized version of first argument after applying styles
## passed in the additional arguments. The result can be printed by
## echo, printf, read -p "..." , etc.
## On many terminals, only red, lightred, pink, magenta are properly rendered.
## Examples:
##   str=$(istyle "Hello, world!" lightyellow bold ul)
##
istyle() {
  txt=${1}
  if [ -z "$txt" ]; then
    return
  fi

  shift
  if [ $# -le 0 ]; then
    return
  fi

  prefix=
  for style in $@; do
    newstyle="i${style}"
    prefix="${prefix}\\\\e[\${${newstyle}}m"
  done
  suffix="\e[0m"
  prefix=$(eval echo ${prefix})
  echo "${prefix}${txt}${suffix}"
}

### Examples
shellutil_textstyle_run_example() {
  echo_style "Hello, there!" "text $green" ul blink
  echo ""
  echo_style "Hello, there!" "text $blue" ul bold
  echo ""
  echo_style "Hello, there!" "text $magenta" ul
  echo ""
  echo_style "Hello, there!" "text $cyan" blink
  echo ""
  echo_style "Hello, there!" "text $amber" ul em
  echo ""
  echo_style "Hello, there!" "bg $lavender" 
  echo ""
  echo_style "Hello, there!" "bg $lightgray" "text $red" bold
  echo ""
  echo_style "Hello, there!" "text $lightgray" "bg $blue" blink
  echo ""

  echo "#### Starts here"
  for i in {0..17}; do
    echo_style "INFO: " "text $i"
    echo "Data written"
  done

  echo_style "WARN: " "text $amber"
  echo "Low disk space"

  echo_style "ERROR: " "text $red"
  echo "Permission denied"

  echo "#### istyle"
  str=$(istyle Hello red bold ul)
  read -p "$str world!" n
  echo $n
  printf "$str world!\n"
}


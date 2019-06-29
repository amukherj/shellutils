#!/bin/bash

black=0
red=1
green=2
yellow=3
blue=4
magenta=5
cyan=6
white=7
grey=8
lightred=9
lightgreen=10
lightyellow=11
lightblue=12
pink=13
lightcyan=14
offwhite=15
slate=16
prussian=17

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
  txt=$1
  shift

  prefix=
  for arg in "$@" ; do
    pref1=${arg:0:3}
    pref2=${arg:0:2}
    color=
    if [ "$pref1" == "col" ]; then
      color=${arg:3:${#arg}}
      color=$(eval echo "\$$color")
    elif [ "$pref2" == "bg" ]; then
      color=${arg:2:${#arg}}
      color=$(eval echo "\$$color")
    fi

    tpcmd=
    if [ -n "$color" -a "$color" != '$' ]; then
      if [ $color -ge 0 -a $color -le 17 ]; then
        if [ "$pref1" == 'col' ]; then
          tpcmd=$(eval echo "setaf $color")
        else
          tpcmd=$(eval echo "setab $color")
        fi
      fi
    else
      tpcmd=$($arg)
    fi

    prefix="${prefix}\$(tput ${tpcmd})"
  done

  cmd2="echo \"$txt\""
  suffix="tput sgr0"
  cmd="$prefix\$($cmd2)\$($suffix)"

  echo -n $(eval echo $cmd)
}

## Examples of how to use the functions
## in this library.
shellutil_textstyle_run_example() {
  echo "$(style 'Hello, world!' ul) What's up?"
  printf "%s Hola!\n" "$(style 'Hello, world!' ul bold collightgreen)"
  read -p "$(style 'Enter your name: ' ul bold collightred)" name
  echo $name

  style "Hello, there!" "colgreen" ul blink
  echo ""
  style "Hello, there!" "colblue" ul bold
  echo ""
  style "Hello, there!" "colmagenta" ul
  echo ""
  style "Hello, there!" "colcyan" blink
  echo ""
  style "Hello, there!" "colyellow" ul em
  echo ""
  style "Hello, there!" "bgpink"
  echo ""
  style "Hello, there!" "bglightgreen" "colred" bold
  echo ""
  style "Hello, there!" "coloffwhite" "bgblue" blink
  echo ""

  echo "#### Starts here"
  style "INFO: " colcyan
  echo "Data written"

  style "WARN: " "colyellow"
  echo "Low disk space"

  style "ERROR: " "colred"
  echo "Permission denied"
}

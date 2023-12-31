#!/bin/bash

c0="\033[0m"
c1="\033[1;35m"
c2="\033[1;32m"
c3="\033[1;37m"
c4="\033[1;34m"
c5="\033[1;31m"
c6="\033[1;33m"
c7="\033[1;36m"
c8="\033[1;40;30m"
c9="\033[1;43;33m"
c10="\033[1;47;37m"

uptime() {
  IFS=. read -r s _ </proc/uptime

  # Convert uptime into readable value.
  d="$((s / 60 / 60 / 24))"
  h="$((s / 60 / 60 % 24))"
  m="$((s / 60 % 60))"

  # Hide empty fields and make the output of uptime smaller.
  [ "$d" -eq 0 ] || UPTIME="${d}d "
  [ "$h" -eq 0 ] || UPTIME="${UPTIME}${h}h "
  [ "$m" -eq 0 ] || UPTIME="${UPTIME}${m}m "
  [  -n  "$m"  ] || UPTIME="${UPTIME}${s}s ${sp}"

  # Show system-uptime information.
  printf "${rs}%s" "${UPTIME%,\ }"

}

distro() {
    . /etc/os-release
    echo "$ID $VERSION_ID"

}

shell() {
    basename ${SHELL}

}

wm(){
    xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') -notype -f _NET_WM_NAME 8t | grep "WM_NAME" | cut -f2 -d \"
}

init (){
    cut -d ' ' -f 1 /proc/1/comm
}

kernel(){
    uname -r
}

printf '%b' "             ${c1}os${c3}    $(distro)
             ${c2}ker${c3}   $(kernel)
     ${c3}•${c8}_${c3}•${c0}     ${c7}wm${c3}    $(wm)
     ${c8}${c0}${c9}oo${c0}${c8}|${c0}     ${c4}sh${c3}    $(shell)
    ${c8}/${c0}${c10} ${c0}${c8}'\'${c0}    ${c6}up${c3}    $(uptime)
    ${c9}(${c0}${c8}\_;/${c0}${c9})${c0}   ${c4}init${c3}  $(init)  

      ${c6}󰮯  ${c6}${c2}󰊠  ${c2}${c4}󰊠  ${c4}${c5}󰊠  ${c5}${c7}󰊠  ${c7}

${c0}"

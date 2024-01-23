# ohmykali
The terminal plugin to ease your offensive security workflow.

ohmykali + pimpmykali = superior Kali Linux :D

## Installation
### Dependencies
- rlwrap: `apt install rlwrap`

### Manual
```zsh
git clone https://github.com/RedefiningReality/ohmykali ~/.ohmykali && echo 'source ~/.ohmykali/kali.plugin.zsh' >>~/.zshrc
```

This is the simplest kind of installation and it works even if you are using a plugin manager.

### Oh My Zsh
1. Clone the repository:
```zsh
git clone https://github.com/RedefiningReality/ohmykali ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/kali
```
2. In `~/.zshrc`, add this plugin to your plugins list: `plugins=(... kali)`

## Usage
Don't forget to edit the following lines at the beginning of `kali.plugin.zsh` to your liking:
```zsh
work_dir="/home/$USER/shared/workspace" # default working directory
scripts_windows="/home/$USER/shared/scripts/windows" # default Windows scripts directory
scripts_linux="/home/$USER/shared/scripts/linux" # default Linux scripts directory
```

### Commands
`box`, `rev`, `serve`, and `smb` have help screens you can access with the `-h` flag

- `work` ⇒ cd to your default working directory
- `win` ⇒ cd to your Windows scripts directory
- `lin` ⇒ cd to your Linux scripts directory
- `down` ⇒ move everything from your downloads folder to your current working directory
- `vpn` ⇒ add VPN connection from OpenVPN (.ovpn) file to NetworkManager's list of VPN connections
  - allows you to connect through the UI rather than running the `openvpn` command
- `scan` ⇒ that one actually useful nmap service scan you run every time
  - check out the ohmyzsh bulit-in nmap plugin for more
- `box` ⇒ add host (box) to /etc/hosts file and create environment variable so you can reference its IP by name
- `rev` ⇒ rlwrapped netcat reverse listener with copy and pastables to get a full shell

Be sure you're connected to a VPN (automatically detects IP) when using the following:
- `serve` ⇒ HTTP server for common directories with copy and pastables for the target
- `smb` ⇒ SMB server for common directories with copy and pastables for the target

### Examples
- `vpn TryHackMe.ovpn` ⇒ add TryHackMe to your list of VPN connections
- `scan -oN file 192.168.1.5` ⇒ scan 192.168.1.5, save output to file
- `box academy 192.168.1.5` ⇒ add academy to /etc/hosts and create academy environment variable
  - in the current terminal session, you can use `$academy` to directly reference academy's IP (192.168.1.5)
---
- `serve lin 8000` ⇒ serve your Linux scripts directory via HTTP on port 8000
- `serve lin` ⇒ serve your Linux scripts directory via HTTP on default port 80
- `serve 443` ⇒ serve your current working directory via HTTP on port 443
- `serve` ⇒ serve your current working directory via HTTP on default port 80
---
- `smb win name` ⇒ serve your Windows scripts directory via SMB with share name "name"
- `smb win` ⇒ serve your Windows scripts directory via SMB with default share name "share"
- `smb john` ⇒ serve your current working directory via SMB with share name "john"
- `smb` ⇒ serve your current working directory via SMB with default share name "share"

### Note on Root Privileges
The `serve`, `smb`, and `rev` commands do *not* listen as root (no sudo) for the following reasons:
- It's generally not a good idea to expose services running as root
- Having to type in your sudo password is annoying

However, you can't bind to privileged ports (usually <1024) without root privileges, which means on many distros you wouldn't be able to start the SMB server on port 443 or the HTTP server on a port like 80.
In Kali Linux, all ports are set as unprivileged by default so it's probably not something you need to worry about.
If this is not the case, my recommended solution is to make all ports unprivileged:

```zsh
sudo sysctl -w net.ipv4.ip_unprivileged_port_start=0
```

Perhaps that's not something you feel comfortable doing.
I could have chosen to integrate checking for unprivileged ports and applying sudo as necessary directly into my commands.
I chose not to do this to avoid script overhead and also because it's more work for me for a feature I don't see anyone using.
If it's a feature you'd like to see, feel free to submit an issue and complain about it, and I'll potentially add it.

## Other Plugins I Use
*unrelated to this, but might be helpful*
- colorize
- cd-ls
- debian
- extract
- fasd
- git
- history
- nmap
- pip
- safe-paste
- systemadmin
- systemd
- zsh-autocomplete
- zsh-autosuggestions
- zsh-syntax-highlighting

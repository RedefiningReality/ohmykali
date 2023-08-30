# ohmykali
The terminal plugin to ease your offensive security workflow.

ohmykali + pimpmykali = superior Kali Linux :)

## Installation
### Dependencies
- rlwrap: `apt install rlwrap`

### Manual
```zsh
git clone https://github.com/RedefiningReality/ohmykali.git ~/.ohmykali
echo 'source ~/.ohmykali/kali.plugin.zsh' >>~/.zshrc
```

This is the simplest kind of installation and it works even if you are using a plugin manager.

### Oh My Zsh
1. Clone the repository:
```zsh
git clone https://github.com/RedefiningReality/ohmykali.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/kali
```
2. In `~/.zshrc`, add this plugin to your plugins list: `plugins=(... kali)`

## Usage
Don't forget to edit the following lines at the beginning of `kali.plugin.zsh` to your liking:
```zsh
work_dir="/root/shared/workspace" # default working directory
scripts_dir="/root/shared/scripts" # default scripts directory
scripts_windows="/root/shared/scripts/windows" # default Windows scripts directory
scripts_linux="/root/shared/scripts/linux" # default Linux scripts directory
```

### Commands
`box`, `rev`, `serve`, and `smb` have help screens you can access with the `-h` flag

- `work` ⇒ cd to your default working directory
- `scripts` ⇒ cd to your scripts directory
- `down` ⇒ move everything from your downloads folder to your current working directory
- `vpn` ⇒ add VPN from OpenVPN file to your list of VPNs
- `scan` ⇒ that one actually useful nmap service scan you run every time
- `box` ⇒ add host (box) to /etc/hosts file and create environment variable so you can reference its IP by name
- `rev` ⇒ rlwrapped netcat reverse listener with copy and pastables to get a full shell
- `serve` ⇒ HTTP server for common directories with copy and pastables for the target
- `smb` ⇒ SMB server for common directories with copy and pastables for the target

### Examples
- `vpn TryHackMe.ovpn` ⇒ add TryHackMe to your list of VPNs
- `scan -oN file 192.168.1.5` ⇒ scan 192.168.1.5, save output to file
- `box academy 192.168.1.5` ⇒ add academy to /etc/hosts and create academy environment variable
  - in the current terminal session, you can use `$academy` to directly reference academy's IP (192.168.1.5)
---
- `serve linux 8000` ⇒ serve your Linux scripts directory via HTTP on port 8000
- `serve linux` ⇒ serve your Linux scripts directory via HTTP on port 80
- `serve 443` ⇒ serve your current working directory via HTTP on port 443
- `serve` ⇒ serve your current working directory via HTTP on port 80
---
- `smb windows name` ⇒ serve your Windows scripts directory via SMB with share name "name"
- `smb windows` ⇒ serve your Windows scripts directory via SMB with share name "share"
- `smb name` ⇒ serve your current working directory via SMB with share name "name"
- `smb` ⇒ serve your current working directory via SMB with share name "share"

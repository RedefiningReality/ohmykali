# ohmykali
The terminal plugin to ease your offensive security workflow.

ohmykali + pimpmykali = superior Kali Linux :)

## Installation
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
2. In `~/.zshrc`, add this plugin to your plugins list:
```zsh
plugins=(... kali)
```

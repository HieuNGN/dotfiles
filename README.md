# ThinkPad // dotfiles

<p align="center">
  <img alt="IBM in red, green and blue beside a grey ThinkPad wordmark with a red dot over the i" src="assets/brand.svg">
</p>

<p align="center">
  <img alt="Zsh" src="https://img.shields.io/badge/SHELL-Zsh-161616?style=flat-square">
</p>

A dependable shell setup with a little ThinkPad DNA: practical, configurable,
and ready for the next session. Zsh and quality-of-life tools are managed as
symlinks, keeping the setup easy to inspect and repeat.

## System Layout

| File                      | Purpose                                              |
| ------------------------- | ---------------------------------------------------- |
| `.zshenv`                 | `$HOME` entry point — sets XDG dirs and `ZDOTDIR`    |
| `.zshrc`                  | Main interactive config, sources the modules below   |
| `options.zsh`             | `setopt` shell options (history + behaviour)         |
| `aliases.zsh`             | Portable aliases (bat/batcat, lf, dnf/apt/pacman)    |
| `bindings.zsh`            | Keybindings                                          |
| `fzf.zsh`                 | fzf / fd configuration                               |
| `plugins.zsh`             | Plugin manager (autosuggestions, history, syntax)    |
| `prompt.zsh`              | Starship prompt                                      |
| `starship.toml`           | Starship configuration                               |
| `zshenv.zsh`              | ZDOTDIR environment (XDG, MANPAGER, STARSHIP_CONFIG) |
| `hosts.local.zsh.example` | Template for machine-specific host aliases           |

## Provisioning

The installer links the repo files into `$ZDOTDIR` (`~/.config/zsh`) and
`~/.zshenv` into `$HOME`. It is idempotent: safe to run again whenever the
configuration changes.

```sh
cd ~/projs/dotfiles
git pull --ff-only
./install.sh
exec zsh
```

> `install.sh` skips the `chsh` prompt when run non-interactively.

## Local Hardware Notes

Hosts and lab aliases (ssh targets, Wake-on-LAN, tailscale toggles) are
machine-specific and **not committed**. They contain per-machine IPs and
hostnames.

Copy the template and edit it:

```sh
cp ~/.config/zsh/hosts.local.zsh.example ~/.config/zsh/hosts.local.zsh
```

`~/.config/zsh/hosts.local.zsh` is sourced automatically by `.zshrc` when it
exists, and is gitignored. Keep real IPs and hostnames out of version control.

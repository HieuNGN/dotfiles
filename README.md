# ThinkPad // dotfiles

$$
\Large
\begin{array}{c@{\qquad}c}
\begin{array}{c@{\quad}c@{\quad}c}
\color{red}{\mathtt{IIIIIII}} & \color{green}{\mathtt{BBBBBBBB}} & \color{blue}{\mathtt{MM\phantom{MMMMM}MM}}\\
\color{red}{\phantom{II}\mathtt{III}\phantom{II}} & \color{green}{\mathtt{BB\phantom{BBBB}BB}} & \color{blue}{\mathtt{MMM\phantom{MMM}MMM}}\\
\color{red}{\phantom{II}\mathtt{III}\phantom{II}} & \color{green}{\mathtt{BB\phantom{BBBB}BB}} & \color{blue}{\mathtt{MMMM\phantom{M}MMMM}}\\
\color{red}{\phantom{II}\mathtt{III}\phantom{II}} & \color{green}{\mathtt{BBBBBBBB}} & \color{blue}{\mathtt{MM\phantom{M}MMM\phantom{M}MM}}\\
\color{red}{\phantom{II}\mathtt{III}\phantom{II}} & \color{green}{\mathtt{BB\phantom{BBBB}BB}} & \color{blue}{\mathtt{MM\phantom{MM}M\phantom{MM}MM}}\\
\color{red}{\phantom{II}\mathtt{III}\phantom{II}} & \color{green}{\mathtt{BB\phantom{BBBB}BB}} & \color{blue}{\mathtt{MM\phantom{MMMMM}MM}}\\
\color{red}{\mathtt{IIIIIII}} & \color{green}{\mathtt{BBBBBBBB}} & \color{blue}{\mathtt{MM\phantom{MMMMM}MM}}
\end{array}
&
{\color{gray}{\mathtt{Th}}\overset{\color{red}{\bullet}}{\color{gray}{\imath}}\color{gray}{\mathtt{nkPad}}}
\end{array}
$$

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

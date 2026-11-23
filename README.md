# dotfiles

Zsh and other quality-of-life shell configs, managed as symlinks.

## Layout

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

## Install / sync flow

The installer symlinks the repo files into `$ZDOTDIR` (`~/.config/zsh`) and
`~/.zshenv` into `$HOME`. It is idempotent — safe to re-run.

```sh
cd ~/projs/dotfiles
git pull --ff-only
./install.sh
exec zsh
```

> `install.sh` skips the `chsh` prompt when run non-interactively.

## Machine-specific host aliases (`hosts.local.zsh`)

Hosts and lab aliases (ssh targets, Wake-on-LAN, tailscale toggles) are **not**
committed — they contain per-machine IPs and hostnames.

- Copy the template and edit it:

  ```sh
  cp ~/.config/zsh/hosts.local.zsh.example ~/.config/zsh/hosts.local.zsh
  ```

- `~/.config/zsh/hosts.local.zsh` is sourced automatically by `.zshrc` when it
  exists, and is gitignored. Never commit real IPs or hostnames.

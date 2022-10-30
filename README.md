# dotfiles - [Lucas F. Costa](https://lucasfcosta.com)

The best dotfiles in the entire universe.

![my terminal using the dotfiles in this repo](./terminal-demo.png)

These dotfiles should work straight out-of-the box on MacOS. For other operating systems you will need to update a few files, mainly `programs.sh`.


## Quickstart

1. Install `brew` following the instructions at [Homebrew's official website](https://brew.sh).
2. Install `git` using `brew install git` and clone this repository suing `git clone https://github.com/lucasfcosta/dotfiles`.
3. Execute `./install.sh` to transfer configuration files to your home directory.
4. Execute `programs.sh` to install all programs.


## Usage Guidelines

### Terminal applications

Programs like `docker`, `neovim`, and the alike are installed through `programs.sh` using `brew` itself, which you must have installed _before_ executing `programs.sh`.


### Casks

Casks are GUI applications packaged to be installed through [Homebrew Cask](https://github.com/Homebrew/homebrew-cask).

These are installed from the list of programs in the `Casks` file.

To install these programs separately from the other ones in `programs.sh`, use `brew bundle --file=Cask`.


### Utilities

Utilities like [the `zsh-spaceship` prompt](https://github.com/denysdovhan/spaceship-prompt) and `rustup` are also installed through `programs.sh`.


### MacOS Defaults

These are my favourite configurations for MacOS and I highly recommend you to at least take a look at this file and figure out what are yours.

Having all these set up in a single script is a huge life-quality improvement. Being able to setup simple things like showing file extensions, menu extras, dock settings, update checks and etc at the speed of a command has definitely changed my life for the better.

To run the script which sets those up just run `.macos`:

```console
$ ./dotfiles/.macos
```


### Dotfiles

Well, this repository could not be called `dotfiles` if it didn't actually have any dotfiles, right?

These contain configs for `nvim`, `zsh`, `tmux` and `git`.

To copy them to their correct places just run `install.sh`:

```console
$ . ./dotfiles/install.sh
```


## Things you will have to do manually

Unfortunately, life has not yet given me the opportunity to make everything in this repo automatic, so here's a few things you will have to do by yourself:


### Install tmux plugins

Once you have ran `install.sh` to copy dotfiles to their right places (including `.tmux.conf`), open `tmux` and press `prefix` (<kbd>ctrl</kbd> + <kbd>a</kbd>) + <kbd>I</kbd> (capital I, as in **I**nstall) to fetch the plugin.


### Set Iterm's color preset (if you use iTerm)

Open Iterm configs by pressing <kbd>command</kbd> + <kbd>,</kbd>, go to `Profiles` and then `Colors`.

Choose the `Nord.itermcolors` color preset.

⚠️ **I am now using [Alacritty](https://github.com/alacritty/alacritty) instead of iTerm**, but I've kept the color presets here in case you still want to use iTerm.


### Install NERD fonts

For the icons in `vim` and `tmux` to appear, you'll have to install [NERD fonts](https://www.nerdfonts.com/).

Given how big the NERD fonts repo is, you'll have to install fonts manually so that you can pick only the ones you want. That's why I didn't automate the installation process in this repository.

Once you've installed your preferred font, update Alacritty's configuration file with the name of the chosen font.


## Related Content

* [How I'm still not using GUIs in 2019: A guide to the terminal](https://lucasfcosta.com/2019/02/10/terminal-guide-2019.html)
* [In Praise of Plain Text](https://lucasfcosta.com/2018/08/05/In-Praise-of-Plaintext.html)
* [Vim Tips (outdated)](https://lucasfcosta.com/2017/01/23/Quick-vIM-Tips-That-Will-Save-Your-Life.html)
* [My first blog post about vim (outdated)](https://lucasfcosta.com/2016/09/25/How-I-Learned-to-Stop-Worrying-and-Love-vIM.html)

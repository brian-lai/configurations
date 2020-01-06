#!/bin/sh
set -eou pipefail

# Welcome to the recombine laptop script - adapated from thoughtbot
# Be prepared to turn your laptop (or desktop, no haters here)
# into an awesome development machine.

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

append_to_bash_profile() {
  local text="$1" bash_profile
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.bash_profile" ]; then
    bash_profile="$HOME/.bash_profile"
  else
    bash_profile="$HOME/.bash_profile"
  fi

  if ! grep -Fqs "$text" "$bash_profile"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$bash_profile"
    else
      printf "\n%s\n" "$text" >> "$bash_profile"
    fi
  fi
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.bash_profile" ]; then
  touch "$HOME/.bash_profile"
fi

# shellcheck disable=SC2016
append_to_bash_profile 'export PATH="$HOME/.bin:$PATH"'

pip_install_or_upgrade() {
  if pip2 list | grep "$1" > /dev/null; then
    fancy_echo "Upgrading pip package $1"
    pip2 install --upgrade "$1" > /dev/null
  else
    pip2 install "$1"
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    append_to_bash_profile '# recommended by brew doctor'

    # shellcheck disable=SC2016
    append_to_bash_profile 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
else
  fancy_echo "Homebrew already installed. Skipping ..."
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulas ..."
brew update
brew tap Homebrew/bundle

brew bundle --file=- <<EOF
tap 'caskroom/cask'
tap 'homebrew/services'
tap 'heroku/brew'
brew 'git'
brew 'git-lfs'
brew 'bash-completion'
brew 'tmux'
brew 'openssl'
brew 'libyaml'                              # should come after openssl
cask 'java'
brew 'postgres', restart_service: :changed
brew 'the_silver_searcher'
brew 'reattach-to-user-namespace'
brew 'imagemagick'
brew 'node'
brew 'readline'
brew 'ruby-build'
brew 'sbt'
brew 'mysql', restart_service: :changed
brew 'jq'
brew 'python2'
brew 'python'                               # for pip to install awscli
brew 'parallel'
brew 'gpg2'
brew 'nvm'
brew 'fzf'
brew 'heroku/brew/heroku'
# Useful apps
cask 'google-chrome'
cask 'slack'
cask 'disk-inventory-x'
cask 'atom'
cask 'gpg-suite'
EOF

git lfs install

pip_install_or_upgrade 'pip'
pip_install_or_upgrade 'awscli'
pip_install_or_upgrade 'awsebcli'

#################
# iterm2 stuff
mkdir ~/.iterm2
cp ./iterm2/com.googlecode.iterm2.plist ~/.iterm2/

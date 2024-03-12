# Builtins
set -gx PAGER bat

set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# General
set -gx DO_NOT_TRACK 1

# Android

## Files
set -gx DROID "$HOME/Documents/Android_Shit"

## SDK
set -gx ANDROID_HOME '/opt/android-sdk'
set -gx ANDROID_SDK_HOME "$XDG_CONFIG_HOME/android"
set -gx PATH $PATH $ANDROID_HOME/{build-tools, platform-tools, tools, tools/bin}

# Arch
set -gx ARCHFLAGS '-arch x86_64'

# ~/bin/ import
set -gx PATH $PATH $HOME/{bin, .local/bin}

# Dart
set -gx PATH $PATH $HOME/.pub-cache/bin

# Delta
set -gx DELTA_PAGER 'less -R'

# Diff
set -gx DIFFPROG "$EDITOR"

# Dotnet
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx PATH $PATH $HOME/.dotnet/tools

# FZF
set -gx FZF_DEFAULT_COMMAND 'fd --type f'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# GPG
# - set -gx GPG_TTY $(tty)
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"

# Go
set -gx GOPATH $HOME/Programming/GoProjects
set -gx PATH $PATH $GOPATH/bin

# Gradle
set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle

# GTK
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc

# Java
set -gx JAVA_HOME /usr/lib/jvm/java-18-openjdk
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java

# Less
set -gx LESSHISTFILE -

# Ls
set -gx LS_COLORS (vivid generate $XDG_CONFIG_HOME/vivid/highlite.yml)

# Lua
set -gx PATH "$PATH":"$HOME/.luarocks/bin"
set -gx LUAROCKS_CONFIG '$XDG_CONFIG_HOME/luarocks'

# Man
set -gx MANPAGER 'nvim --cmd "let g:man = v:true" +Man!'

# .NET Core
set -gx NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages

# NNN
set -gx EDITOR nvim
set -gx NNN_ARCHIVE '\\.(7z|bz2|gz|tar|tgz|xz|zip)$'
set -gx NNN_BMS 'a:~/Documents/Android_Shit;g:~/Programming/GoProjects;n:~/Notes;p:~/Programming;t:~/Documents/Tabletop;w:~/Documents/Work;'
set -gx NNN_COLORS '2356'
set -gx NNN_OPTS 'dEo'
# – set -gx NNN_PLUG 'e:foo;'

# NPM
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx PATH $PATH $XDG_DATA_HOME/npm/bin

# History file
set -gx HISTSIZE 50000
set -gx SAVEHIST 10000

# Oracle
set -gx ORACLE_HOME $HOME/Oracle
set -gx TNS_ADMIN $ORACLE_HOME/network/admin/tnsnames.ora

# Python
set -gx IPYTHONDIR $XDG_CONFIG_HOME/jupyter
set -gx JUPYTER_CONFIG_DIR $XDG_CONFIG_HOME/jupyter
set -gx MPLBACKEND module://matplotlib-backend-wezterm
set -gx PYLINTHOME $XDG_CACHE_HOME/pylint

# Ruby
set -gx GEM_HOME $XDG_DATA_HOME/gem
set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
set -gx PATH $PATH $GEM_HOME/ruby/2.7.0/bin

# Rust
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx PATH $PATH $XDG_DATA_HOME/rustup/toolchains/stable-*/bin
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"

# OpenSSL
set -gx RANDFILE "$XDG_DATA_HOME/openssl/rnd"

# Pager
set -gx PAGER 'bat'

# Wget
set -gx WGETRC $XDG_CONFIG_HOME/wgetrc

# Yarn
set -gx PATH $PATH $HOME/.yarn/bin $XDG_CONFIG_HOME/yarn/global/node_modules/.bin

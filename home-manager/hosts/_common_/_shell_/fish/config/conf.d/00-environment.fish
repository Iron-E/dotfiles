# Android

## SDK
set -gx ANDROID_HOME '/opt/android-sdk'
set -gx ANDROID_SDK_HOME $XDG_CONFIG_HOME/android
set -gx PATH $PATH $ANDROID_HOME/{build-tools, platform-tools, tools, tools/bin}

# Arch
set -gx ARCHFLAGS '-arch x86_64'

# Diff
set -gx DIFFPROG "$EDITOR"

# Java
set -gx JAVA_HOME /usr/lib/jvm/java-18-openjdk

# NNN
set -gx NNN_ARCHIVE '\\.(7z|bz2|gz|tar|tgz|xz|zip)$'
set -gx NNN_BMS 'a:~/Documents/Android_Shit;g:~/Programming/GoProjects;n:~/Notes;p:~/Programming;t:~/Documents/Tabletop;w:~/Documents/Work;'
set -gx NNN_COLORS '2356'
set -gx NNN_OPTS 'dEo'
# – set -gx NNN_PLUG 'e:foo;'

# Oracle
set -gx ORACLE_HOME $HOME/Oracle
set -gx TNS_ADMIN $ORACLE_HOME/network/admin/tnsnames.ora

# Python
set -gx MPLBACKEND module://matplotlib-backend-wezterm

# Rust
set -gx PATH $PATH $XDG_DATA_HOME/rustup/toolchains/stable-*/bin

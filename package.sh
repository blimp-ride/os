#
# Operating System differences in bash.
# Linux vs. macOS
# SystemV vs. BSD
# brew.sh
#

# If CB use /workspace, else /tmp
[ -d /workspace ] && WORKSPACE_DIR="${PROJECT_ID:+/workspace}"
WORKSPACE_DIR="${WORKSPACE_DIR:-/tmp}"

OS="$(uname)"
OS="${OS,,}"

is-macos() {
  [ "${OS}" = 'darwin' ]
}

is-linux() {
  [ "${OS}" = 'linux' ]
}

is-windows() {
  [ "${OS}" = 'windows' ]
}

is-cygwin() {
  [ "${OS}" = 'cygwin' ]
}

if is-macos; then

  # awk
  if [ -z "${CMD_AWK}" ]; then
    type gawk >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      CMD_AWK="$(which gawk)"
    else
      log-error "Must install GNU grep with 'brew install gawk'"
      exit 1
    fi
  fi

  # find
  if [ -z "${CMD_FIND}" ]; then
    type gfind >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      CMD_FIND="$(which gfind)"
    else
      log-error "Must install GNU grep with 'brew install findutils'"
      exit 1
    fi
  fi

  # grep
  if [ -z "${CMD_GREP}" ]; then
    type ggrep >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      CMD_GREP="$(which ggrep)"
    else
      log-error "Must install GNU grep with 'brew install grep'"
      exit 1
    fi
  fi
else
  CMD_AWK="${CMD_AWK:-/usr/bin/awk}"
  CMD_FIND="${CMD_FIND:-/usr/bin/find}"
  CMD_GREP="${CMD_GREP:-/bin/grep}" 
fi

export CMD_FIND CMD_GREP OS WORKSPACE_DIR

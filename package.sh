#
# Operating System differences in bash.
# Linux vs. macOS
# SystemV vs. BSD
# brew.sh
#

#=import log

# If CB use /workspace, else /tmp
_WORKSPACE_DIR="${PROJECT_ID:+/workspace}"
_WORKSPACE_DIR="${_WORKSPACE_DIR:-/tmp}"

_OS="$(uname)"
_OS="${_OS,,}"

is-macos() {
  [ "${_OS}" = 'darwin' ]
}

is-linux() {
  [ "${_OS}" = 'linux' ]
}

is-windows() {
  [ "${_OS}" = 'windows' ]
}

is-cygwin() {
  [ "${_OS}" = 'cygwin' ]
}

if is-macos; then

  # awk
  if [ -z "${_CMD_AWK}" ]; then
    type gawk >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      _CMD_AWK="$(which gawk)"
    else
      log-error "Must install GNU grep with 'brew install gawk'"
      exit 1
    fi
  fi

  # find
  if [ -z "${_CMD_FIND}" ]; then
    type gfind >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      _CMD_FIND="$(which gfind)"
    else
      log-error "Must install GNU grep with 'brew install findutils'"
      exit 1
    fi
  fi

  # grep
  if [ -z "${_CMD_GREP}" ]; then
    type ggrep >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      _CMD_GREP="$(which ggrep)"
    else
      log-error "Must install GNU grep with 'brew install grep'"
      exit 1
    fi
  fi
else
  _CMD_AWK="${_CMD_AWK:/usr/bin/awk}"
  _CMD_FIND="${_CMD_FIND:/usr/bin/find}"
  _CMD_GREP="${_CMD_GREP:/bin/grep}" 
fi

export _CMD_FIND _CMD_GREP _OS _WORKSPACE_DIR

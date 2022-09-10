# Load ~/.zshrc or ~/.bashrc file depending on operating system.
# Executable on macOS and Linux.

####
# Check OS
####

IS_MAC = false
IS_LINUX = false

case "$(uname -s)" in
  Darwin*)
    IS_MAC = true
    ;;
  Linux*)
    IS_LINUX = true
    ;;
esac


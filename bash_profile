[ -f "$HOME/.profile" ] && source "$HOME/.profile"
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# Silence the warning in macOS Catalina
# Read: https://support.apple.com/en-hk/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

set -ex

# For more, read https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Disable automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Prevent Photos from opening automatically when devices are plugged in
# defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Automatically quit printer app once the print jobs complete
# defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

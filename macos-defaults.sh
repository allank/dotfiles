#!/bin/bash
# macOS System Preferences
# Optimized for macOS Sonoma/Sequoia

set -e

# Logging helpers
info() { echo -e "\033[0;34mℹ️  $1\033[0m"; }
success() { echo -e "\033[0;32m✅ $1\033[0m"; }
error() { echo -e "\033[0;31m❌ $1\033[0m"; exit 1; }

# Trap errors
trap 'error "Failed to apply macOS preferences."' ERR

info "Applying macOS preferences..."

# Close any open System Settings panes to prevent overrides
osascript -e 'tell application "System Settings" to quit'

###############################################################################
# Keyboard & Input                                                            #
###############################################################################
info "Configuring Keyboard..."

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable automatic capitalization, smart dashes, smart quotes, and auto-period
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

###############################################################################
# Dock & Dashboard                                                            #
###############################################################################
info "Configuring Dock..."

# Set Dock to right and adjust size
defaults write com.apple.dock orientation -string "right"
defaults write com.apple.dock tilesize -int 32

# Enable autohide and remove the delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.2

# Minimize windows into their application icon
defaults write com.apple.dock minimize-to-application -bool true

# Disable hot corner bottom-right (wvous-br-corner = 1 means disabled)
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Finder                                                                      #
###############################################################################
info "Configuring Finder..."

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Trackpad                                                                    #
###############################################################################
info "Configuring Trackpad..."

# Enable right-click
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

###############################################################################
# Cleanup                                                                     #
###############################################################################
info "Restarting affected services..."

# Apply changes by restarting affected services
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" &> /dev/null || true
done

success "macOS defaults applied. Some changes may require logout/restart."

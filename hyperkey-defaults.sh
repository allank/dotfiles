#!/bin/bash
# Hyperkey configuration
# Remaps Caps Lock to Hyper key (Cmd+Ctrl+Option)

set -e

# Logging helpers
info() { echo -e "\033[0;34mℹ️  $1\033[0m"; }
success() { echo -e "\033[0;32m✅ $1\033[0m"; }
error() { echo -e "\033[0;31m❌ $1\033[0m"; exit 1; }

# Trap errors
trap 'error "Failed to configure Hyperkey."' ERR

info "Configuring Hyperkey preferences..."

defaults write com.knollsoft.Hyperkey SUEnableAutomaticChecks -int 1
defaults write com.knollsoft.Hyperkey applyToClick -int 2
defaults write com.knollsoft.Hyperkey capsLockRemapped -int 2
defaults write com.knollsoft.Hyperkey executeQuickHyperKey -int 2
defaults write com.knollsoft.Hyperkey hyperFlags -int 1835008
defaults write com.knollsoft.Hyperkey keyRemap -int 1
defaults write com.knollsoft.Hyperkey launchOnLogin -int 1
defaults write com.knollsoft.Hyperkey quickHyperKeycode -int 53

success "Hyperkey preferences configured."
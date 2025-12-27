#!/bin/bash
# Hyperkey configuration
# Remaps Caps Lock to Hyper key (Cmd+Ctrl+Option)

defaults write com.knollsoft.Hyperkey SUEnableAutomaticChecks -int 1
defaults write com.knollsoft.Hyperkey applyToClick -int 2
defaults write com.knollsoft.Hyperkey capsLockRemapped -int 2
defaults write com.knollsoft.Hyperkey executeQuickHyperKey -int 2
defaults write com.knollsoft.Hyperkey hyperFlags -int 1835008
defaults write com.knollsoft.Hyperkey keyRemap -int 1
defaults write com.knollsoft.Hyperkey launchOnLogin -int 1
defaults write com.knollsoft.Hyperkey quickHyperKeycode -int 53

echo "Hyperkey preferences configured."

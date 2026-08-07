#!/bin/bash
# Enable TouchID as a sudo auth method via /etc/pam.d/sudo_local
# Falls through to password auth automatically on hardware without TouchID.

set -e

# Logging helpers
info() { echo -e "\033[0;34mℹ️  $1\033[0m"; }
success() { echo -e "\033[0;32m✅ $1\033[0m"; }
error() { echo -e "\033[0;31m❌ $1\033[0m"; exit 1; }

# Trap errors
trap 'error "Failed to configure TouchID for sudo."' ERR

SUDO_LOCAL="/etc/pam.d/sudo_local"
SUDO_LOCAL_TEMPLATE="/etc/pam.d/sudo_local.template"
TID_LINE='auth       sufficient     pam_tid.so'
TID_PATTERN='^[[:space:]]*auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so'

# Uncomment the pam_tid.so line in $SUDO_LOCAL in place
enable_touchid_line() {
  sudo sed -i '' -E "s/^#[[:space:]]*(auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so)/\1/" "$SUDO_LOCAL"
}

info "Configuring TouchID for sudo..."

if [ -f "$SUDO_LOCAL" ] && grep -qE "$TID_PATTERN" "$SUDO_LOCAL"; then
  success "TouchID for sudo already configured"
  exit 0
fi

if [ -f "$SUDO_LOCAL" ]; then
  # sudo_local exists but pam_tid.so isn't active — uncomment it if present, else prepend it
  if grep -qE "^#[[:space:]]*auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so" "$SUDO_LOCAL"; then
    enable_touchid_line
  else
    # Read fully before writing — reading and writing $SUDO_LOCAL in the same
    # pipeline races tee's truncate-on-open against cat's read
    existing_content="$(sudo cat "$SUDO_LOCAL")"
    printf '%s\n%s\n' "$TID_LINE" "$existing_content" | sudo tee "$SUDO_LOCAL" >/dev/null
  fi
elif [ -f "$SUDO_LOCAL_TEMPLATE" ]; then
  sudo cp "$SUDO_LOCAL_TEMPLATE" "$SUDO_LOCAL"
  enable_touchid_line
else
  echo "$TID_LINE" | sudo tee "$SUDO_LOCAL" >/dev/null
fi

if grep -qE "$TID_PATTERN" "$SUDO_LOCAL"; then
  success "TouchID for sudo configured"
else
  error "pam_tid.so line not found in $SUDO_LOCAL after configuration"
fi

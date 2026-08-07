# Automated accessibility permission grants

**Decision:** Won't automate. Bootstrap will not attempt to grant macOS Accessibility (TCC) permissions for cmux, Ghostty, Hyperkey, and Alfred.

**Reason:** Modern macOS protects the TCC (Transparency, Consent & Control) database with SIP. On a personal, non-MDM-enrolled Mac there is no supported way to script-grant Accessibility permission — it requires either disabling SIP (not something bootstrap should do) or MDM-profile enrollment (out of scope for a personal dotfiles setup). The maintainer confirmed manual per-app clicks in System Settings are an acceptable ongoing cost and chose not to pursue even the partial mitigation (a bootstrap step that deep-links to the Accessibility pane).

**Prior requests:**
- allank/dotfiles#7

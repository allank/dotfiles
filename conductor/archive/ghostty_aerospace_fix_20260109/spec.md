# Track Spec: Ghostty & Aerospace Window Interaction Fix

## Overview
The user reports that for every Ghostty terminal window, Aerospace detects a corresponding "hidden" Finder window. This disrupts window navigation. This is likely caused by Ghostty's document proxy icon feature (which associates the window with a directory) being misinterpreted by Aerospace or macOS.

## Objectives
- Prevent Aerospace from detecting/navigating to these phantom Finder windows.
- Maintain the utility of seeing the current directory in Ghostty if possible.

## Root Cause Hypotheses
1. **Ghostty Proxy Icon:** Ghostty sets the window's "represented filename" (proxy icon), which macOS might expose as a related Finder entity.
2. **Aerospace Filtering:** Aerospace might be listing windows that have no size/title but are associated with the Finder app-id due to the proxy link.

## Success Criteria
- Opening a Ghostty window does not increase the count of "Finder" windows visible to Aerospace.
- Aerospace navigation (focus next/prev) skips these phantom windows.

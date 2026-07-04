---
trigger: manual
---

# Output Format: Confluence Wiki Markup

All output MUST be written in Confluence Wiki Markup syntax, not Markdown.

## Key Syntax Rules

### Text Formatting
| Element | Confluence Syntax | NOT |
|---------|-------------------|-----|
| Headers | `h1.`, `h2.`, `h3.` | `#`, `##`, `###` |
| Bold | `*bold text*` | `**bold**` |
| Italic | `_italic text_` | `*italic*` |
| Strikethrough | `-strikethrough-` | `~~text~~` |
| Monospace | `{{code}}` | `` `code` `` |

### Lists
- **Bullets:** `*` for level 1, `**` for level 2, etc.
- **Numbered:** `#` for level 1, `##` for level 2, etc.
- **Mixed:** Combine `*` and `#` (e.g., `*#` for numbered inside bullet)

### Links
- **External:** `[link text|https://example.com]`
- **Page link:** `[Page Title]`
- **Anchor:** `[link text|Page Title#anchor]`

### Tables
- **Header row:** `||Header 1||Header 2||Header 3||`
- **Data rows:** `|Cell 1|Cell 2|Cell 3|`
- **Line breaks in cells:** `\\`

### Callout Macros
Use strict macro tags (no spaces inside braces):
- `{info}Informational text{info}` — Blue box
- `{tip}Helpful tip{tip}` — Green box
- `{note}Important note{note}` — Yellow box
- `{warning}Warning text{warning}` — Red box

### Code Blocks
```
{code:java}
public class Example {}
{code}
```
Replace `java` with appropriate language.

### Other
- **Horizontal rule:** `----` (preceded by `\\` if inline)
- **Panel:** `{panel:title=My Title}content{panel}`

## Example Output

```
h2. Summary

This feature *reduces latency* by _optimising_ the cache layer.

||Metric||Before||After||
|p50 latency|120ms|45ms|
|Error rate|2.1%|0.3%|

{tip}See the [design doc|https://example.com/doc] for details.{tip}

h3. Next Steps

# Complete implementation
# Run load tests
# Deploy to staging
```
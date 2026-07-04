---
trigger: manual
---

# Output Format: Google Docs (Rendered)

All output MUST be rendered visually in the chat. Do **NOT** wrap the final response in code blocks.

## Why This Works
When you copy rendered markdown from the chat preview and paste into Google Docs:
- Headers become native GDocs headings
- Tables paste as formatted GDocs tables
- Links remain clickable
- Lists maintain structure

## Key Formatting Rules

### Structure
- Use standard Markdown headers (`#`, `##`, `###`) — they render as rich text
- Use `-` for bullet lists, `1.` for numbered lists
- Both paste correctly into GDocs

### Tables
Render as **Markdown Tables** (not ASCII art, not code blocks):
```
| Column A | Column B |
|----------|----------|
| Value 1  | Value 2  |
```
These paste into GDocs as fully formatted tables.

### Emphasis
- **Bold** and *Italics* work normally
- Links: `[text](url)` — paste as clickable links

### Callouts
Use "Emoji + Bold Label" syntax (GDocs doesn't support blockquotes/admonitions):

ℹ️ **INFO:** This is informational content.

💡 **TIP:** This is a helpful tip.

⚠️ **WARNING:** This requires attention.

🚨 **CRITICAL:** This is urgent.

### What NOT to Do
- ❌ Do NOT wrap the response in triple backticks (` ``` `)
- ❌ Do NOT use `> blockquotes` (they don't paste well)
- ❌ Do NOT use HTML tags

## Example Output

The following would be rendered directly (not in a code block):

---

## Project Summary

This initiative **reduces churn** by improving the onboarding flow.

| Metric | Current | Target |
|--------|---------|--------|
| Day-7 retention | 42% | 55% |
| Time to value | 4.2 days | 2 days |

💡 **TIP:** See the [full analysis](https://example.com) for methodology.

### Next Steps

1. Finalise design specs
2. Run user testing
3. Ship to 10% rollout
#!/bin/bash
# SessionStart hook: print the always-on core rules; stdout is added to context.
cat "${CLAUDE_PLUGIN_ROOT}/context/session-rules.md"

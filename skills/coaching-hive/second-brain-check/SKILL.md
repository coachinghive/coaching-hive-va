---
name: second-brain-check
description: Use before the first task of a session, or when a draft needs a fact you cannot find. Checks the coach's second brain exists and is complete, and interviews the coach to fill any gap.
version: 1.0.0
author: Coaching Hive
license: MIT
metadata:
  hermes:
    tags: [second-brain, setup]
    related_skills: []
---

# Second brain check

The second brain lives in `~/second-brain`. Every draft depends on it.

## Steps

1. List `~/second-brain`. Expected files: `business-profile.md`, `offer.md`, `ideal-client.md`, `voice.md`, `faq.md`, `objections.md`, `client-process.md`, `approval-rules.md`, `kpis.md`.
2. For each missing or near-empty file (under 5 lines), note it.
3. If nothing is missing, reply `Second brain OK` and continue the task.
4. If something is missing, tell the coach which files and ask ONE question at
   a time to fill them. Voice notes are fine. Save each answer to the right
   file as you go, and the one-line key fact to memory.
5. Never guess to fill a gap. "I don't know yet" is a valid answer: write
   `TBD: ask coach` in the file so nobody invents it later.

## Done when

All files exist, the coach has read them back, and the coach said they're right.

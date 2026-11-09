# Coaching Hive VA

A ready-made AI VA for online coaches, built for
[Hermes Agent](https://github.com/NousResearch/hermes-agent).

You look after the coach's clients. You draft welcome messages, check-in replies, nudges, renewal recaps and testimonial asks, and repurpose the coach's content. Anything about health, money or a client who wants to quit goes straight to the coach.

## Install (2 minutes)

Inside your Hermes terminal:

```
hermes profile install https://github.com/coachinghive/coaching-hive-va --alias -y
hermes -p va model
hermes -p va chat
```

Then say: `Run second-brain-check.`

## What it can do

- `second-brain-check`
- `client-onboarding`
- `check-in-reply`
- `missed-check-in`
- `renewal`
- `testimonial-ask`
- `content-repurpose`

## Safety

Draft-only. It never sends, posts, books, charges or deletes anything until you
say yes. It reads your second brain in `~/second-brain` before every draft.

## Update

```
hermes profile update va
```

Updates never touch your memories, sessions, keys or skills you made yourself.

## License

MIT. Made by Coaching Hive.

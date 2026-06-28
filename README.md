# 📓 claude-daily-log

**Turn every day of [Claude Code](https://claude.com/claude-code) work into a beginner-friendly study guide — auto-rendered as a dark-mode PDF and synced to your phone via Google Drive.**

You worked with an AI all day. This skill reads *all* of your Claude Code sessions
(across every project, even ones still open), figures out what you actually built,
and writes it up as a **teaching guide** — the kind you could read on the bus home,
re-implement by hand, and confidently explain in an interview as your own work.

It's the difference between *"the AI did it"* and *"I understand exactly what was
built, why, and how to do it again."*

---

## What you get, every day

- 🧠 **A teaching guide, not a changelog.** Each piece of work is explained from
  scratch — the problem, the fix, real code with plain-English commentary, how to
  re-implement it yourself, interview talking points, and lessons.
- 🔭 **Captures every session at once.** It reads session transcripts from disk, so
  it stitches together all your parallel/closed Claude windows — not just the one
  you ran it in.
- 🪶 **Honest.** Cleanly separates shipped code from setup/exploration. No invented
  accomplishments.
- 🌿 **A "Git skills" section.** Explains the day's actual git commands — what each
  did, why, and how to run it yourself.
- 💬 **A copy-paste Slack standup** printed in your terminal (no hyphens, minimal
  punctuation — ready to paste).
- 📱 **A dark-mode PDF** rendered for comfortable phone reading, auto-uploaded to
  Google Drive.
- 🎚️ **Effort levels** (`light` / `medium` / `heavy`) to control token usage.
- ♻️ **Additive.** Run it again the same day and it only appends new work — never
  overwrites or duplicates.

Output lands in `~/Daily Log/` as `YYYY-MM - DD - <one line of the day>.md`.

---

## Install

> Requires [Claude Code](https://claude.com/claude-code). The skill lives in your
> personal skills folder, so it works in every repo.

**Clone straight into your Claude skills folder:**

```bash
git clone https://github.com/ShockRock2004/claude-daily-log.git ~/.claude/skills/daily-log
```

…then restart Claude Code (or start a new session). That's it — type `/daily-log`.

Prefer not to clone there? Download the ZIP, then run the installer from the
unzipped folder:

```bash
bash install.sh
```

---

## Prerequisites

The core (reading sessions + writing the markdown guide) needs only **Python 3**,
which you already have. The extras degrade gracefully — if a tool is missing, that
step quietly skips and the skill still works.

| Feature | Needs | Install (macOS) |
|---|---|---|
| Core daily guide | Python 3 | already installed |
| Phone-readable PDF | Node.js + Google Chrome | `brew install node` + Chrome |
| Google Drive upload | [`rclone`](https://rclone.org) | `brew install rclone` |

### One-time Google Drive setup (optional)

```bash
brew install rclone
rclone config        # create a Google Drive remote named "gdrive" (browser login)
```

Then uploads go to a `Daily Log` folder in your Drive automatically. By default
Drive holds the **PDFs** and your laptop keeps the **markdown** sources — change
the toggles at the top of `upload_to_drive.sh` if you want it the other way.

---

## Usage

```bash
/daily-log                  # today, full detail (heavy)
/daily-log medium           # today, fewer tokens
/daily-log light            # today, cheapest pass
/daily-log light 2026-06-25 # a past day, cheap
```

**Effort levels** trade detail for token cost:

| Level | What it documents | Pulls real code? |
|---|---|---|
| `light` | top 2–3 pieces, brief | no (commit messages only) |
| `medium` | top ~5 pieces | the 2–3 most important |
| `heavy` *(default)* | every distinct piece, full depth | yes, for each |

---

## How it works

```
your Claude sessions ──▶ collect_day.py ──▶ compact digest
                                                  │
                              the skill reads it, pulls real code,
                              and writes a teaching-guide .md
                                                  │
                       render_pdf.sh: markdown ─(marked)▶ HTML ─(headless Chrome)▶ dark PDF
                                                  │
                       upload_to_drive.sh: PDF ─(rclone)▶ Google Drive
```

- **`collect_day.py`** — reads every transcript under `~/.claude/projects/`, slices
  by local date, and distills each session (your prompts, the reasoning, files
  edited, git commands, and the day's commit map) into one digest.
- **`SKILL.md`** — instructs Claude how to turn that digest into the teaching guide,
  the Slack summary, and trigger the PDF + upload.
- **`render_pdf.sh`** — markdown → styled HTML (`marked`) → PDF (headless Chrome),
  dark Tailwind-slate theme, phone-sized.
- **`upload_to_drive.sh`** — copies the PDF to Google Drive via `rclone`.

## Customize

Tunables live at the top of `collect_day.py` (which projects to exclude, digest
size, subagents) and `upload_to_drive.sh` (Drive remote/folder, PDF-only vs md
too). The PDF look is the CSS block in `render_pdf.sh`.

## License

MIT — see [LICENSE](LICENSE).

---

*Built with Claude Code. Nothing here is tied to any employer — it's a personal
learning tool, free for anyone to use.*

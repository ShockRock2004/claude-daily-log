# Claude Daily Log

Tired of prompting Claude all day and letting it debug and build everything, but
never really understanding what happened under the hood? This tool is your saviour.

At the end of the day it reads every one of your Claude Code sessions, works out
what got built, and writes it up as a friendly study guide. The kind of thing you
can read on the bus home and use to genuinely learn the code, so you could rebuild
it by hand and explain how it works because you actually understand it.

Think of it as turning "I watched the AI build it" into "I understand what got
built, why, and how to do it again."

## What you get every day

* **A study guide, not a boring changelog.** Every piece of work is explained from
  scratch. The problem, the fix, the real code with plain English commentary, how
  to rebuild it yourself, the key ideas to take away, and the lessons.
* **It sees everything at once.** It reads your session history straight off the
  disk, so it pulls together all your Claude windows, even the ones still open, not
  just the one you ran it in.
* **It stays honest.** It keeps real shipped code separate from setup and poking
  around. No made up wins.
* **It teaches you git.** There is a whole section explaining the git commands you
  used that day. What each one did, why, and how to run it yourself.
* **A standup you can paste.** It prints a short summary in your terminal that you
  can drop straight into Slack.
* **A PDF for your phone.** It renders the day into a clean dark themed PDF and
  pops it into Google Drive, so it actually looks good on your phone instead of
  raw text.
* **Effort levels.** Tell it how hard to work with light, medium, or heavy,
  depending on how many tokens you want to spend.
* **Run it as often as you like.** Running it again the same day just adds the new
  stuff. It never overwrites or repeats what is already there.

Everything lands in `~/Daily Log` as a dated file.

## Install

You need Claude Code. The skill lives in your personal skills folder, so it works
in every project.

Drop it straight into your Claude skills folder:

```bash
git clone https://github.com/ShockRock2004/claude-daily-log.git ~/.claude/skills/daily-log
```

Then restart Claude Code (or start a new session) and type `/daily-log`. That is
it.

Would rather not clone there? Grab the ZIP, unzip it, and run:

```bash
bash install.sh
```

## What you need

The main part, reading your sessions and writing the guide, only needs Python 3,
which you already have. The extra bits are optional and quietly skip themselves if
a tool is missing, so nothing ever breaks.

* For the phone friendly PDF you want Node.js and Google Chrome.
* For the Google Drive upload you want rclone (`brew install rclone`).

### Setting up Google Drive (optional)

```bash
brew install rclone
rclone config
```

When it asks, make a Google Drive remote and name it `gdrive` (it opens a browser
so you can log in). After that, your daily files upload to a Daily Log folder in
your Drive on their own. By default Drive keeps the PDFs and your laptop keeps the
markdown. Flip the toggles at the top of `upload_to_drive.sh` if you want it the
other way.

## How to use it

```bash
/daily-log                  run today at full detail
/daily-log medium           today, but spend fewer tokens
/daily-log light            today, the cheapest pass
/daily-log light 2026-06-25 a day in the past, cheaply
```

Here is what each effort level does:

* **Light** keeps it cheap. It writes up your top two or three things, briefly,
  using just the commit messages, with at most one code snippet.
* **Medium** is the balance. It covers around five things and pulls real code for
  the two or three most important.
* **Heavy** is the full treatment and the default. Every distinct thing, with real
  code for each.

## How it works

Under the hood it is four small pieces:

* **`collect_day.py`** reads every transcript in `~/.claude/projects`, picks out
  the day you asked for, and boils each session down (your prompts, the reasoning,
  the files touched, the git commands, and the day's commits) into one compact
  digest.
* **`SKILL.md`** tells Claude how to turn that digest into the study guide, the
  Slack summary, and the PDF.
* **`render_pdf.sh`** turns the markdown into a styled web page with marked, then
  prints it to a PDF using Chrome running invisibly. Dark Tailwind slate theme,
  sized for a phone.
* **`upload_to_drive.sh`** copies the PDF up to Google Drive with rclone.

## Make it yours

All the knobs live at the top of the files. `collect_day.py` lets you skip certain
projects, change how big the digest gets, and toggle subagents. `upload_to_drive.sh`
sets your Drive folder and whether to upload only the PDF or the markdown too. The
look of the PDF is just the CSS block inside `render_pdf.sh`, so restyle away.

## License

MIT. Do whatever you like with it. See the LICENSE file.

Built with Claude Code. It is not tied to any employer. It is just a personal
learning tool that anyone is welcome to use.

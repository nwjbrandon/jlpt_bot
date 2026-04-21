# Telegram JLPT Vocabulary Quiz Bot

Telegram bot for JLPT vocabulary practice with 4-option quizzes.

## Features

- 4-option multiple choice quiz
- Loads vocabulary from one CSV file or all CSV files in a directory
- Can test any single column:
	- Kangi
	- Hiragana
	- Meaning
- When testing 1 column, the other 3 columns are shown in the question
- Wrong answers are retried after a short delay (spaced review)
- Keeps simple per-user score stats in memory
- Uses Telegram inline keyboards

## Requirements

- Python 3.13+
- A Telegram bot token from @BotFather
- (Optional) Ollama for generating meanings and example sentences

## Setup

1. Create a Telegram bot with @BotFather and copy the token.
2. Install dependencies:

```bash
uv sync --dev
```

3. Create a `.env` file in the project directory:

```dotenv
TELEGRAM_BOT_TOKEN="..."
VOCAB_CSV_PATH="./data/csv"
QUIZ_MODE="MODE_AUTO"
```

4. Start the bot:

```bash
python main.py
```

## Configuration

### Environment variables

- `TELEGRAM_BOT_TOKEN`
	- Required
	- Token from @BotFather
- `VOCAB_CSV_PATH`
	- Optional
	- Default: `./data/csv`
	- Can be a single CSV file path or a directory containing CSV files
- `QUIZ_MODE`
	- Optional
	- Default: `MODE_AUTO`

### Available QUIZ_MODE values

- `MODE_AUTO`
- `MODE_TEST_KANGI`
- `MODE_TEST_HIRAGANA`
- `MODE_TEST_MEANING`

`MODE_AUTO` picks the first playable mode in priority order. A mode is playable when it has at least 4 distinct non-empty answer values.

## Expected CSV Format

Required columns:

- `Kangi`
- `Hiragana`

Optional columns:

- `Meaning`
- `Sentence`

Example:

```csv
Kangi,Hiragana,Meaning,Sentence
経験,けいけん,experience,この仕事で多くの経験を積んだ。
```

Notes:

- Empty rows are ignored.
- If testing Meaning mode, make sure you have enough distinct non-empty `Meaning` values.

## Bot Commands

- `/start` show welcome and current mode
- `/quiz` send a new quiz question
- `/mode` select quiz mode
- `/reset` reset score and progress
- `/stats` show current score
- `/help` show help text

## Data Generation (Optional)

This repository includes a script that can generate `Meaning` and `Sentence` fields using Ollama:

Run flow:

```bash
ollama pull qwen3:8b
ollama serve
python generate.py
```

Input and output paths are defined at the top of each script.

## Lint and Format

```bash
ruff check
ruff check --select I --fix
ruff format
```

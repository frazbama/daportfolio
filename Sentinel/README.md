[README.md](https://github.com/user-attachments/files/31244893/README.md)
# Review Sentiment Ledger

An AI-powered voice-of-customer dashboard. It classifies Amazon product reviews
by sentiment (positive / neutral / negative), extracts recurring themes and
complaints, and writes a plain-English executive summary — then validates the
AI's calls against the dataset's own human labels to report an agreement rate.

**Live demo:** open `index.html` in any browser (or host it on GitHub Pages).

## What it demonstrates

- Applying an LLM (Google Gemini) to a real dataset at scale
- Validating model output against ground-truth labels (agreement metric)
- Turning raw analysis into an executive summary and a downloadable report
- A clean, responsive analytics dashboard built from scratch

## How to run

1. Get a free Gemini API key: https://aistudio.google.com/apikey
2. Open `index.html` in your browser.
3. Paste your key into the box, choose a sample size, and click **Run AI analysis**.

Your API key stays in your browser for the session and is only ever sent to
Google. It is never stored in this repository.

## Files

- `index.html` — standalone live demo (Gemini-powered, no build tools needed)
- `review-sentiment-dashboard.jsx` — React source version of the same app
- `cleaned_reviews.csv` — the review dataset (optional to include)

## Data

Amazon Reviews Dataset by Daniel Ihenacho (Kaggle, MIT License) — sentiment,
cleaned review text, review length, and 1–5 score.

## Author

Built by **frazbama**.

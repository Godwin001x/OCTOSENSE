# OctoSense (Prototype)

This repository contains a prototype for OctoSense — an AI-powered flood detection and relief coordination PWA.

## Quick local setup

1) Backend (Flask):
- cd server
- python3 -m venv venv
- source venv/bin/activate  # Windows: venv\Scripts\activate
- pip install -r requirements.txt
- python app.py

2) Frontend (Next.js):
- cd client
- npm install
- npm run dev

Open http://localhost:3000

## Notes
- All data in `client/public/mockdata` is mock sample data. Replace with free APIs when available.
- The AI logic is a simple deterministic function (`server/model/ai_model.py`) to simulate predictions.

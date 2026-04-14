# BearsPortal 🐾

A simple student course registration web app built with HTML, CSS, and vanilla JavaScript.

## Files

- `login.html` — Login page. Enter any Student ID and password to access the portal.
- `schedule.html` — Main portal. Shows your enrolled courses and the full course catalog.
- `styles.css` — Shared styles used by both pages.

## Features

- Login with Student ID and password
- Browse course catalog with search and department filter
- Add courses to your schedule (up to 18 credits)
- Drop courses from your schedule
- Time conflict detection — alerts you if two courses overlap and blocks the add
- Confirm registration page to review courses before finalizing
- Brown and yellow Bears theme with 🐾 paw logo

## How to Run

No server or installation needed. Just open `login.html` in any web browser.

All three files must be in the same folder for the CSS and page navigation to work.

## Validation Rules

- Cannot exceed 18 total credits
- Cannot add a course with no available seats
- Cannot add a course that overlaps in time with an already enrolled course

## Tech Stack

- HTML
- CSS
- JavaScript (no frameworks or libraries)
- `sessionStorage` used to pass login state between pages

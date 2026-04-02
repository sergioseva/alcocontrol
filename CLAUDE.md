# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**AlcoControl.ar** — A single-page static website (in Spanish) that critiques the effectiveness of fixed sobriety checkpoints in Argentina. It presents data, economic impact analysis, and collects user testimonials via a moderation system.

## Architecture

The entire application lives in `alcoholemia-protest.html` — a self-contained HTML file with inline CSS and JavaScript. No build tools, dependencies, or server required.

### Key Sections

- **Hero** — Landing with headline stats
- **Datos (Section 01)** — Statistical evidence comparing fixed checkpoints vs. mobile patrols, includes a 24-hour accident-vs-control heatmap grid
- **Economía (Section 02)** — Economic impact on local businesses and tourism
- **Experiencias (Section 03)** — User testimony form with moderation workflow
- **Admin Panel** — Hidden moderation panel accessed via footer gear icon (⚙), password: `control123`

### Data & State

- All testimonials are stored in `localStorage` under key `alcocontrol_comentarios`
- Comments have three states: `pendiente`, `aprobado`, `rechazado`
- On first load with empty storage, three example testimonials are seeded
- HTML escaping is done via the `esc()` function to prevent XSS

### Design System

CSS custom properties defined in `:root`: `--rojo` (accent red), `--amarillo` (highlight yellow), `--crema` (text), `--oscuro`/`--gris`/`--gris2` (backgrounds), `--texto-muted`.
Fonts: Anton (headings), Barlow Condensed (labels/UI), Lora (body text) — loaded from Google Fonts.

## Development

Open `alcoholemia-protest.html` directly in a browser. No build step needed.

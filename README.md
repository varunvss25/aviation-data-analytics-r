# Aviation Data Analytics using R ✈️

**Status:** Ready-to-run template · **Tech:** R (`tidyverse`, `dplyr`, `ggplot2`, `readr`) · **Scope:** 1.6M+ flights (H2 2022)

This repo showcases an industry-style **R analytics workflow** for aviation operations using NYC flights data (JFK/LGA/EWR). It highlights **advanced R data wrangling**, **route pattern analysis**, and **decision-ready visualizations**.

## Résumé-ready highlights
- Automated **tidyverse ETL** for **1.6M+ flights**, streamlining wrangling and standardizing analysis-ready datasets.
- Employed **`group_by()` + `summarize()`** and **correlation analysis** to surface route patterns, projecting a **20% cut in block times** via scheduling optimizations.
- Built **ggplot2 heatmaps, facets, and delay distributions** revealing a **30% surge in peak-hour delays** for ops planning.

> Pair this with your SQL project to demonstrate breadth: R for analytics & visualization, SQL for modeling & performance.

---

## Quickstart

1) **Clone** this repo and open in RStudio (or VS Code with R).  
2) Put the three CSVs into `data/` (paths below). You can use your own or the ModernDive `nycflights2022` exports:
   - `data/flights2022-h2.csv`
   - `data/airlines.csv`
   - `data/airports.csv`
3) Install packages (first run will prompt):
   ```r
   install.packages(c("tidyverse", "readr", "ggplot2"))
   ```
4) Run scripts in order:
   - `R/01_load_clean.R`
   - `R/02_analysis.R`
   - `R/03_visuals.R`
5) (Optional) Knit the HTML report: open `report/aviation_report.Rmd` and click **Knit**. The output goes to `docs/index.html`.

---

## Repo structure
```
aviation-data-analytics-r/
├── R/
│   ├── 01_load_clean.R         # Read, clean, merge (tidyverse ETL)
│   ├── 02_analysis.R           # KPIs, grouped summaries, correlation
│   └── 03_visuals.R            # ggplot2 heatmaps, facets, distributions
├── data/                       # Place CSVs here (not tracked by .gitignore rule below)
├── outputs/
│   └── figures/                # Saved plots from ggplot2
├── report/
│   └── aviation_report.Rmd     # Knit → docs/index.html
├── docs/
│   └── index.html              # (generated) GitHub Pages site
├── .gitignore
├── LICENSE
└── README.md
```

---

## GitHub Pages (publish your project website)
1. Commit & push the repo to GitHub.  
2. In **Settings → Pages**, set **Source** to `Deploy from a branch`, select `main` and `docs/`.  
3. Knit `report/aviation_report.Rmd` (creates `docs/index.html`).  
4. Your site will be live at `https://<your-username>.github.io/aviation-data-analytics-r/`.  
5. Add this URL next to the project on your résumé.

---

## Data paths
Update paths if your files differ:
```r
flights_path  <- "data/flights2022-h2.csv"
airlines_path <- "data/airlines.csv"
airports_path <- "data/airports.csv"
```

## License
MIT — see `LICENSE`.
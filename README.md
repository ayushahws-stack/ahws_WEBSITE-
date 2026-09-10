# 🚀 Academic Heights World School (AHWS) - Production Deployment

[![Live Website](https://img.shields.io/badge/Live-GitHub%20Pages-success.svg)](https://ayushahws-stack.github.io/ahws_WEBSITE-/)
[![Target Domain](https://img.shields.io/badge/Domain-ahws.edu.in-blue.svg)](https://ahws.edu.in/)
[![Build Status](https://img.shields.io/badge/Vite-5.4-646CFF.svg)](https://vitejs.dev/)

This repository is the dedicated, high-performance static distribution and **GitHub Pages deployment repository** for **Academic Heights World School (AHWS)**.

- **Live URL:** [https://ayushahws-stack.github.io/ahws_WEBSITE-/](https://ayushahws-stack.github.io/ahws_WEBSITE-/)
- **Target Custom Domain:** [https://ahws.edu.in/](https://ahws.edu.in/)
- **Source Code Repository:** [ahws-WEBSITE-code-base-](https://github.com/ayushahws-stack/ahws-WEBSITE-code-base-)

---

## 📂 Repository Contents

```
AHWS_Website_Click_And_Play/
├── assets/                    # Compiled, minified Vite JS chunks and CSS bundles
├── images/                    # Local image assets, campus photos, and icons
│   └── new AHWS Website Photos/ # Authentic AHWS photo library
├── WEBSITE GALLERY/           # School events, sports day, and celebration galleries
├── documents website/         # Mandatory CBSE disclosure PDFs and statutory certificates
├── index.html                 # Production entrypoint with Schema.org JSON-LD & meta tags
├── robots.txt                 # Search engine & AI bot crawl directives
├── sitemap.xml                # Search engine route index with priority & lastmod tags
├── llms.txt                   # Standard AI search & LLM context file
└── .nojekyll                  # GitHub Pages flag to bypass Jekyll asset filtering
```

---

## 🛠️ Deployment & Maintenance Workflow

> [!NOTE]
> All source code development takes place in the `01_WEBSITE_SOURCE` repository. This repository only receives compiled production artifacts.

### To Deploy Updates from Source:
1. Navigate to the source directory:
   ```bash
   cd "D:\ayush bansal\WEBSITE\01_WEBSITE_SOURCE"
   ```
2. Run quality checks and build:
   ```bash
   npm run lint
   npm run build
   ```
3. Copy the compiled distribution and SEO files to this repository:
   ```powershell
   Copy-Item -Path "dist\index.html" -Destination "..\AHWS_Website_Click_And_Play\index.html" -Force
   Copy-Item -Path "dist\assets\*" -Destination "..\AHWS_Website_Click_And_Play\assets\" -Force
   Copy-Item -Path "public\robots.txt" -Destination "..\AHWS_Website_Click_And_Play\robots.txt" -Force
   Copy-Item -Path "public\sitemap.xml" -Destination "..\AHWS_Website_Click_And_Play\sitemap.xml" -Force
   Copy-Item -Path "public\llms.txt" -Destination "..\AHWS_Website_Click_And_Play\llms.txt" -Force
   ```
4. Commit and push:
   ```bash
   git add .
   git commit -m "build: deploy updated production assets"
   git push origin main
   ```
GitHub Pages will automatically build and publish the changes live within 60-90 seconds.

---

## 🔍 SEO & Search Verification

- **Google Search Console Verification:** Active via meta verification tag in `<head>`.
- **Structured Data:** Validated against Schema.org (`School`, `EducationalOrganization`, `LocalBusiness`).
- **AI Crawler Readiness:** Configured for ChatGPT (`GPTBot`), Perplexity (`PerplexityBot`), Claude (`ClaudeBot`), and Google AI Overviews (`Google-Extended`) via `llms.txt` and `robots.txt`.

---

**Maintained by:** Ayush Bansal & The AHWS Technical Team.  
Academic Heights World School, Pitampura, New Delhi.

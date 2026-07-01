# Academic Heights World School (AHWS) - SEO & AI-SEO (GEO) Implementation Report

## Executive Summary
This document provides a comprehensive overview of the **Traditional Search Engine Optimization (SEO)** and **AI-Related Generative Engine Optimization (GEO)** enhancements implemented for the **Academic Heights World School (AHWS)** website. 

The objective of these implementations is to ensure maximum visibility across traditional search engines (Google, Bing, Yahoo) as well as AI-powered answer engines (ChatGPT, Perplexity AI, Google Gemini, and Claude).

---

## 1. AI-SEO & Generative Engine Optimization (GEO)

AI search engines rely on structured microdata and clear factual entity graphs to retrieve and cite school information accurately. We implemented the following:

### A. Rich JSON-LD Microdata Schema (`index.html`)
Embedded an official JSON-LD schema adhering to Schema.org standards:
- **`@type`**: `["School", "EducationalOrganization"]`
- **`name`**: `Academic Heights World School (AHWS)`
- **`alternateName`**: `["AHWS", "AHWS Pitampura", "Academic Heights World School Delhi"]`
- **`url`**: `https://ahws.edu.in/`
- **`logo`**: `https://ahws.edu.in/images/logo.webp`
- **`image`**: `https://ahws.edu.in/images/AHWS.png`
- **`description`**: Comprehensive official summary highlighting CBSE senior secondary affiliation, SPROUT curriculum, AI & Robotics lab, 150 CCTV cameras, and 360° student support.

### B. Geo-Location & Entity Metadata
- **Postal Address**: SD - QD Block, Near TV Tower, Opposite Metro Pillar No: 319, Pitampura, Delhi - 110034, India.
- **GeoCoordinates**: Latitude `28.694542`, Longitude `77.146475`.
- **Contact Details**: Telephone `+91-8860455000`, Email `info@ahws.edu.in`.
- **CBSE Credentials**: Affiliation Number `2730105`, School Code `85200`.
- **Social Graph (`sameAs`)**: Linked official Facebook, Instagram, and YouTube channels.
- **Parent Organization**: Bachpan Play School & Academic Heights Network.

---

## 2. Dynamic Route-Specific SEO (`SEO.jsx` & `App.jsx`)

To eliminate duplicate title/description tags and ensure every page route targets relevant keywords, a dynamic React SEO component (`src/components/SEO.jsx`) was integrated into `App.jsx`.

### Route Metadata Breakdown:

| Route Path | Page Title | Focused Keywords / Target Intent |
| :--- | :--- | :--- |
| `/` (Home) | `Academic Heights World School (AHWS) – Best CBSE School in Pitampura, Delhi` | Primary school branding, CBSE Pitampura, NEP-2020 |
| `/about` | `About Us \| Academic Heights World School (AHWS) Delhi` | Leadership, Director Rosy Ahuja, Principal Rachna Anand |
| `/curriculum` | `SPROUT Curriculum & Academics \| AHWS Pitampura` | 7 Layers of SPROUT, NEP 5+3+3+4, Academic Stages |
| `/beyond-curriculum` | `Beyond Curriculum & Co-Scholastic Programs \| AHWS` | Decode Startup, Wordsworth Language Lab, Theater, Sports |
| `/admission` | `Admissions Open 2026-27 \| Academic Heights World School` | Online admission enquiry, Nursery to Class XII application |
| `/fee-structure` | `Fee Structure 2026-27 \| Academic Heights World School` | Tuition fees, annual charges, development fees breakdown |
| `/infrastructure` | `World-Class Infrastructure & Facilities \| AHWS` | 150 CCTV cameras, Library, Science & AI Labs, Basketball |
| `/gallery` | `Photo & Video Gallery \| Academic Heights World School` | Event photos, Sports Day, Science Exhibition, Achievers |
| `/events` | `School Events & Notice Board \| AHWS Delhi` | Circulars, Academic Planner, PTM schedule, notices |
| `/results` | `CBSE Board Results & Toppers \| AHWS Pitampura` | Class X & XII 100% pass rates, board toppers |
| `/committees` | `Safety & School Committees \| AHWS Pitampura` | POSH, POCSO, Anti-Bullying, Safety, Tobacco Control |
| `/mandatory-disclosure` | `CBSE Mandatory Disclosure \| Academic Heights World School` | Public transparency, Affiliation letter, DEO certificates |
| `/careers` | `Careers & Job Openings \| Academic Heights World School` | Teacher recruitment, PGT, TGT, PRT job applications |
| `/contact` | `Contact Us \| Academic Heights World School Pitampura` | Contact numbers, location map, reception email |
| `/alumni` | `Alumni Network \| Academic Heights World School` | Alumni registration, achievements, student network |

---

## 3. Semantic HTML & Accessibility Optimization

- **W3C Heading Hierarchy**: Enforced exactly one primary `<h1>` element per page route (using `PageBanner` component on subpages and a dedicated accessible `<h1>` on the Home page).
- **Image ALT Attributes**: Verified that all images across the gallery, sports, leadership, facilities, and curriculum sections include descriptive alt attributes for screen readers and image search engines.
- **OpenGraph & Twitter Cards**: Added `og:title`, `og:description`, `og:image`, `og:url`, and `twitter:card` tags to ensure rich visual card previews when sharing website links on WhatsApp, Facebook, LinkedIn, or Twitter.

---

## 4. Verification & Single-File Bundle Status

- **Source Location**: `D:\ayush bansal\WEBSITE\01_WEBSITE_SOURCE`
- **Single-File Output**: `D:\ayush bansal\WEBSITE\AHWS_Website_Click_And_Play\index.html`
- **Status**: **100% Up to Date & Deployed**.

# AHWS Website — Complete Technical Documentation
### Academic Heights World School | Official Website Codebase
**Version:** 1.0.0 | **Date:** August 2026 | **Author:** AHWS Development Team

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Technology Stack — Deep Dive](#2-technology-stack--deep-dive)
3. [Project File & Folder Structure](#3-project-file--folder-structure)
4. [Entry Point & Bootstrapping (How the App Starts)](#4-entry-point--bootstrapping-how-the-app-starts)
5. [Routing System — How Pages Are Loaded](#5-routing-system--how-pages-are-loaded)
6. [Data Architecture — How Content Is Stored & Pushed](#6-data-architecture--how-content-is-stored--pushed)
7. [Component Architecture — Reusable Building Blocks](#7-component-architecture--reusable-building-blocks)
8. [Pages — Individual Route Components](#8-pages--individual-route-components)
9. [State Management — How the App Tracks Changes](#9-state-management--how-the-app-tracks-changes)
10. [Styling System — CSS Architecture](#10-styling-system--css-architecture)
11. [SEO System — Search Engine Optimization](#11-seo-system--search-engine-optimization)
12. [Build System — Vite & Bundling](#12-build-system--vite--bundling)
13. [Performance Patterns Used in This Codebase](#13-performance-patterns-used-in-this-codebase)
14. [External Libraries — What They Do & Why Used](#14-external-libraries--what-they-do--why-used)
15. [Deployment Strategy](#15-deployment-strategy)
16. [Data Flow Diagram — End to End](#16-data-flow-diagram--end-to-end)

---

## 1. Project Overview

The AHWS website is the **official digital presence of Academic Heights World School (AHWS)**, a CBSE-affiliated Senior Secondary school located in Pitampura, Delhi. The website is a **fully frontend-rendered Single-Page Application (SPA)** built using **React 18** as its core framework.

### What the Website Does

The website serves multiple audiences:
- **Parents & Students**: They get information about the school, admission processes, curriculum, fee structure, gallery, events, and more.
- **Prospective Admissions**: A floating enquiry form allows parents to submit their contact details at any point while browsing.
- **Alumni**: A dedicated page allows alumni to reconnect and view news.
- **Search Engines & AI Bots**: Full SEO metadata, Open Graph tags, Twitter Card meta, JSON-LD structured data, and sitemap-ready routing.

### Key Website Pages

| Page | URL Route | Purpose |
|---|---|---|
| Home | `/` | Landing page with hero, highlights, infra cards, uniqueness grid |
| About | `/about` | School history, leadership, 360° app |
| Curriculum | `/curriculum` or `/academics` | SPROUT curriculum, NEP 2020 stages |
| Beyond Curriculum | `/beyond-curriculum` | Sports, arts, startup programs |
| Admission | `/admission` | Online enquiry, eligibility, process |
| Fee Structure | `/fee-structure` | Class-wise fee breakdown |
| Infrastructure | `/infrastructure` | Campus facilities |
| Gallery | `/gallery` | Photo & video gallery with categories |
| Events | `/events` | News & event highlights |
| Blog | `/blog` | School blog posts |
| Notice Board | `/notice-board` | Circulars and notices |
| Committees | `/committees` | POSH, POCSO, Anti-Bullying committees |
| Mandatory Disclosure | `/mandatory-disclosure` | CBSE compliance documents |
| Contact Us | `/contact` | Contact form, map, contact details |
| Careers | `/careers` | Job openings |
| Alumni | `/alumni` | Alumni network |
| Results | `/results` | CBSE board results |
| TC Database | `/tc-database` | Transfer Certificate lookup |

---

## 2. Technology Stack — Deep Dive

### 2.1 React 18 — The Core Framework

**What is React?**
React is a JavaScript library developed and maintained by Meta (Facebook). It allows developers to build user interfaces using a component-based architecture — meaning the UI is broken into small, independent, and reusable pieces called **components**.

**Why React 18 specifically?**
React 18 introduced the concept of **Concurrent Rendering** — meaning React can prepare multiple UI states at the same time, prioritize user interactions, and keep the UI responsive even under heavy computation. While this website does not use advanced concurrent features like Suspense boundaries extensively, using React 18 future-proofs the codebase.

**How React Works in This Project:**
1. The browser loads `index.html`.
2. `index.html` contains a single `<div id="root">` — an empty container.
3. React attaches itself to that div using `ReactDOM.createRoot()`.
4. React then **renders** the entire application inside that `<div id="root">` by processing JSX components.
5. Every page, button, animation, and dropdown you see is rendered entirely in JavaScript by React — not by the server.

**JSX (JavaScript XML):**
JSX is a special syntax that looks like HTML but is actually JavaScript. For example:
```jsx
function Button() {
  return <button className="btn">Click Me</button>
}
```
This `<button>` tag is not real HTML — it gets **compiled by Vite/Babel** into:
```js
React.createElement('button', { className: 'btn' }, 'Click Me')
```
Which React then converts into actual DOM nodes in the browser.

---

### 2.2 Vite — The Build Tool

**What is Vite?**
Vite (French for "fast") is a next-generation frontend build tool created by Evan You (the creator of Vue.js). It replaces older tools like Webpack or Create React App (CRA).

**Why Vite over CRA?**
- **Dev Server Speed**: Vite uses native ES Modules (ESM) in the browser during development. Instead of bundling the entire project on every save, Vite only processes the file that changed — making hot reload near-instant (under 50ms vs CRA's 2-5 seconds).
- **Production Build**: For production (`npm run build`), Vite uses **Rollup** under the hood to bundle, minify, and tree-shake the code into optimized static files.
- **Plugin Ecosystem**: Vite has a rich plugin ecosystem that is used in this project.

**Vite Configuration (`vite.config.js`):**
```js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { viteSingleFile } from 'vite-plugin-singlefile'

export default defineConfig({
  plugins: [
    react(),         // Enables JSX transformation & React Fast Refresh (HMR)
    viteSingleFile() // Bundles EVERYTHING into one single HTML file for deployment
  ],
  base: './',        // Uses relative paths so the site works from any folder
})
```

**`vite-plugin-singlefile` — The Most Important Plugin:**
This plugin is the secret behind how this website is deployed. Normally, a Vite build produces:
- `dist/index.html`
- `dist/assets/index-[hash].js` (hundreds of KB)
- `dist/assets/index-[hash].css`
- Various image and font files

But with `vite-plugin-singlefile`, the entire JavaScript, CSS, and even some assets are **inlined directly into `index.html`**. The final output is a **single `index.html` file** that contains everything — the entire app, all styles, all logic — in one self-contained file. This makes deployment trivially simple: just upload one HTML file.

**`@vitejs/plugin-react`:**
This plugin does two things:
1. **JSX Transform**: Converts JSX syntax into `React.createElement()` calls that browsers can understand.
2. **React Fast Refresh (HMR)**: During development, when you save a file, only that component is updated in the browser without a full page reload. State is preserved.

---

### 2.3 React Router DOM v6 — Navigation Without Page Reloads

**What is React Router?**
React Router is the standard routing library for React. In traditional multi-page websites, clicking a navigation link sends a request to a server, which responds with a new HTML page. This website does not do that — it is a **Single Page Application (SPA)**.

**How SPA Routing Works:**
1. The browser loads `index.html` once.
2. When the user clicks "About Us", React Router intercepts the click.
3. Instead of reloading the page, React Router tells React to **unmount** the current page component (e.g., `<Home />`) and **mount** the new one (e.g., `<About />`).
4. The URL in the address bar changes (e.g., `/#/about`), but no network request to a server is made.

**HashRouter vs BrowserRouter:**
This project uses `HashRouter`, which means URLs look like: `https://ahws.edu.in/#/about` instead of `https://ahws.edu.in/about`. The `#` (hash) is critical for this deployment strategy. Here is why:

When the site is deployed as a **static single file** (remember `vite-plugin-singlefile`), the web server only knows about one file: `index.html`. If someone types `https://ahws.edu.in/about` directly in the browser, the server looks for a file at `/about` and returns a 404 error. But with `HashRouter`, everything after `#` is handled purely by the browser/JavaScript — the server only ever sees a request for `index.html`, and React Router reads the hash to decide which page to show.

**Routes Defined in `App.jsx`:**
```jsx
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
  <Route path="/admission" element={<Admission />} />
  <Route path="/curriculum" element={<Curriculum />} />
  <Route path="/beyond-curriculum" element={<BeyondCurriculum />} />
  <Route path="/infrastructure" element={<Infrastructure />} />
  <Route path="/gallery" element={<Gallery />} />
  ...and more
</Routes>
```

Each `<Route>` maps a URL path to a React component. When the URL matches `/about`, the `<About />` component is rendered.

---

### 2.4 React Hooks — useState and useEffect

This project heavily relies on React Hooks, which allow functional components to have state and side effects.

**`useState` — Remembering Things:**
`useState` creates a reactive variable. When the variable changes, React automatically re-renders the component.

Example from `Header.jsx`:
```jsx
const [scrolled, setScrolled] = useState(false)
```
- `scrolled` — the current value (starts as `false`)
- `setScrolled` — the function to change the value
- When `setScrolled(true)` is called, React re-renders the header with `scrolled = true`, which applies the `.scrolled` CSS class, making the header appear more compact.

**`useEffect` — Running Code at the Right Time:**
`useEffect` lets you run code in response to component lifecycle events — mount, update, or unmount.

Example from `Header.jsx`:
```jsx
useEffect(() => {
  const handleScroll = () => setScrolled(window.scrollY > 60)
  window.addEventListener('scroll', handleScroll)
  return () => window.removeEventListener('scroll', handleScroll) // Cleanup
}, []) // Empty array = run only once when component mounts
```
This adds a scroll listener when the Header appears on screen, and **removes it** (cleanup) when the Header is removed, preventing memory leaks.

---

### 2.5 Swiper.js — Carousel & Slider Library

**What is Swiper?**
Swiper is the most modern free mobile touch slider library with hardware-accelerated transitions. It is used in this project for carousels and slideshow elements.

**Why Swiper?**
- Native touch/swipe support for mobile users
- Hardware-accelerated CSS transitions (uses `transform: translate3d`)
- Autoplay support
- Pagination and navigation arrows built-in
- Tiny performance footprint

**How it is used:**
Swiper is imported and configured with specific modules like `Navigation`, `Pagination`, `Autoplay`, and `EffectFade`. The component receives a list of data items (like testimonials or gallery images) and renders them as swipeable slides.

---

### 2.6 React CountUp — Animated Number Counters

**What is react-countup?**
It is a React component that animates numbers from 0 to a target value when they scroll into view. This creates the eye-catching "We have 150+ CCTV cameras" animated counter effect on the website.

**How it works in this project:**
`react-countup` is paired with `react-intersection-observer` (the `useInView` hook). The counter only starts counting when the statistics section scrolls into the user's viewport, creating an impactful visual moment.

```jsx
import CountUp from 'react-countup'
import { useInView } from 'react-intersection-observer'

const { ref, inView } = useInView({ triggerOnce: true })

<CountUp start={0} end={150} duration={2.5} suffix="+" />
```

---

### 2.7 React Icons — Icon Library

**What is react-icons?**
React Icons provides a massive collection of popular icon sets (Font Awesome, Material Icons, Bootstrap Icons, etc.) as individual React components. Instead of loading an entire icon font file (which can be 100-300 KB), you import only the specific icons you use.

```jsx
import { FaFacebook, FaInstagram } from 'react-icons/fa'
```

This **tree-shaking** approach means only the icons actually used are included in the final bundle.

---

### 2.8 React Intersection Observer

**What is it?**
The `react-intersection-observer` library is a React wrapper around the browser's native **Intersection Observer API**. It tells you when an HTML element scrolls into the user's viewport.

**Why is it used?**
This powers the **scroll-triggered animations** throughout the website. Cards, sections, and statistics only animate or count up when the user scrolls to them — not when the page first loads. This approach:
1. Makes the website feel dynamic and engaging
2. Saves CPU resources — no pointless animations running offscreen
3. Creates a better first impression as sections "come alive" as they appear

---

## 3. Project File & Folder Structure

```
01_WEBSITE_SOURCE/
│
├── index.html                    ← App entry point (single HTML shell)
├── vite.config.js                ← Vite build configuration
├── package.json                  ← Project metadata & npm dependencies
├── package-lock.json             ← Locked dependency versions
│
├── public/                       ← Static files (copied as-is to dist)
│
└── src/                          ← All source code lives here
    ├── main.jsx                  ← JavaScript entry point (mounts React)
    ├── App.jsx                   ← Root component (Router + Routes + Layout)
    ├── App.css                   ← Global app-level overrides
    ├── index.css                 ← Global CSS variables, resets, utilities
    │
    ├── components/               ← Shared/reusable UI components
    │   ├── Header.jsx            ← Navigation bar (desktop + mobile)
    │   ├── Header.css
    │   ├── Footer.jsx            ← Site footer
    │   ├── Footer.css
    │   ├── SEO.jsx               ← Dynamic title/meta tag manager
    │   ├── PageBanner.jsx        ← Reusable page hero banner
    │   ├── PageBanner.css
    │   ├── AnnouncementTicker.jsx ← Scrolling news ticker at top
    │   ├── AnnouncementTicker.css
    │   ├── FloatingEnquiry.jsx   ← Floating "Enquire Now" button + form
    │   ├── FloatingEnquiry.css
    │   ├── Popup.jsx             ← Generic modal popup component
    │   └── Popup.css
    │
    └── pages/                    ← One file per page/route
        ├── Home.jsx + Home.css
        ├── About.jsx + About.css
        ├── Curriculum.jsx + Curriculum.css
        ├── BeyondCurriculum.jsx + BeyondCurriculum.css
        ├── Admission.jsx + Admission.css
        ├── Infrastructure.jsx + Infrastructure.css
        ├── Gallery.jsx + Gallery.css
        ├── Events.jsx + Events.css
        ├── Blog.jsx + Blog.css
        ├── ContactUs.jsx + ContactUs.css
        ├── FeeStructure.jsx + FeeStructure.css
        ├── Results.jsx + Results.css
        ├── Careers.jsx + Careers.css
        ├── Alumni.jsx + Alumni.css
        ├── Committees.jsx + Committees.css
        ├── MandatoryDisclosure.jsx + MandatoryDisclosure.css
        ├── NoticeBoard.jsx + NoticeBoard.css
        └── TCDatabase.jsx + TCDatabase.css
```

---

## 4. Entry Point & Bootstrapping (How the App Starts)

When a user opens the AHWS website in their browser, here is exactly what happens step by step:

### Step 1: Browser Requests index.html
The browser makes an HTTP GET request to `https://ahws.edu.in/`. The web server responds with `index.html`.

### Step 2: index.html is Parsed
The browser reads `index.html`. Key things inside it:
- **`<meta>` tags** for SEO (description, robots, keywords, author)
- **Open Graph tags** (`og:title`, `og:description`, `og:image`) — used when the site is shared on Facebook, WhatsApp, LinkedIn
- **Twitter Card tags** — used when shared on Twitter/X
- **JSON-LD Structured Data** — a `<script type="application/ld+json">` block that describes the school to search engines using Schema.org vocabulary. This tells Google: "This is a School at this address, with this phone number, CBSE affiliation #2730105". This powers Google's Knowledge Panel and rich search results.
- **`<div id="root">`** — an empty div that will hold the entire React app
- **`<script type="module" src="/src/main.jsx">`** — tells the browser to load the JavaScript entry point

Since `vite-plugin-singlefile` is used in production, all JavaScript and CSS are **inline** inside this HTML file — no additional network requests needed.

### Step 3: main.jsx Executes
```jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
```

- `ReactDOM.createRoot(document.getElementById('root'))` — React takes control of the `<div id="root">` DOM element
- `.render(<App />)` — React renders the `<App />` component (and everything inside it) into that div
- `<React.StrictMode>` — A development wrapper that deliberately double-invokes certain lifecycle functions to help detect bugs. Has no effect in production builds.
- `import './index.css'` — Global CSS styles are loaded

### Step 4: App.jsx Renders
The `<App />` component is the root of the component tree. It sets up:
1. `<HashRouter>` — wraps everything in routing context
2. `<ScrollToTop />` — ensures the page scrolls to top on navigation
3. `<SEO />` — manages `<title>` and `<meta description>` tags
4. `<AnnouncementTicker />` — the scrolling news bar at the top
5. `<Header />` — the navigation bar
6. `<Routes>` — the router decides which page component to show
7. `<Footer />` — the site footer
8. `<FloatingEnquiry />` — the floating "Enquire Now" button

---

## 5. Routing System — How Pages Are Loaded

### How Navigation Works (Step by Step)

**Scenario:** User clicks "About Us" in the navigation menu.

1. The `<NavLink to="/about">` component in `Header.jsx` intercepts the click.
2. React Router updates the browser's URL from `/#/` to `/#/about` using `history.pushState()` — this does **not** reload the page.
3. The `<Routes>` component in `App.jsx` re-evaluates which `<Route>` matches the new path.
4. The `<Route path="/about" element={<About />} />` matches.
5. React **unmounts** the `<Home />` component and **mounts** the `<About />` component in its place.
6. The `<ScrollToTop />` component detects the location change via `useLocation()` and calls `window.scrollTo(0, 0)`.
7. The `<SEO />` component detects the location change and updates `document.title` and the meta description tag.
8. The user sees the About page — all within milliseconds, with no server request.

### Scroll-to-Hash Support
`ScrollToTop` also handles cases where the URL contains a hash anchor (e.g., `/admission#age-criteria`):
```jsx
function ScrollToTop() {
  const { pathname, hash } = useLocation()
  useEffect(() => {
    if (hash) {
      setTimeout(() => {
        const id = hash.replace('#', '')
        const elem = document.getElementById(id)
        if (elem) {
          elem.scrollIntoView({ behavior: 'smooth' })
        } else {
          window.scrollTo(0, 0)
        }
      }, 150) // 150ms delay allows the page to render before scrolling
    } else {
      window.scrollTo(0, 0)
    }
  }, [pathname, hash])
  return null
}
```
The 150ms delay is intentional — it gives React time to render the target page before attempting to scroll to the element.

---

## 6. Data Architecture — How Content Is Stored & Pushed

### 6.1 The Approach: Static Data in JavaScript

This website does **not** use a database or a backend API. All content — text, images, statistics, event descriptions, committee members — is stored as **JavaScript data structures (arrays and objects) directly inside the component files**.

This is an intentional architectural decision appropriate for this school website because:
- Content rarely changes (terms, leadership, curriculum do not change daily)
- No backend server maintenance required
- Ultra-fast load times (no API calls, no waiting)
- The entire site is deployable as a single static HTML file
- Zero hosting costs for dynamic backend

### 6.2 How Data is Defined — Data Arrays

Here is the exact pattern used throughout the codebase:

**Example from `Home.jsx` — Infrastructure Section:**
```jsx
const infraItems = [
  {
    title: 'Smart Classrooms',
    icon: '💻',
    desc: 'Interactive digital boards, ergonomic seating, and 3D digital learning tools.',
    image: './WEBSITE GALLERY/other images/smart class room...'
  },
  {
    title: 'Science Laboratories',
    icon: '🔬',
    desc: 'Fully equipped Physics, Chemistry, Composite, and Biology labs with advanced safety features.',
    image: './WEBSITE GALLERY/other images/lab.jpg'
  },
  // ...more items
]
```

**Example from `Header.jsx` — Navigation Menu:**
```jsx
const navItems = [
  { label: 'HOME', to: '/' },
  {
    label: 'ABOUT US',
    to: '/about',
    children: [
      { label: 'ABOUT AHWS', to: '/about' },
      { label: 'MANDATORY DISCLOSURE', to: '/mandatory-disclosure' },
      { label: 'ALUMNI', to: '/alumni' },
      { label: 'SAFETY & COMMITTEES', to: '/committees' },
    ]
  },
  // ...more items
]
```

**Example from `AnnouncementTicker` — Scrolling News:**
```jsx
const tickerItems = [
  { text: '🎓 Admissions Open for 2027-28! Apply Now', link: '/admission', isNew: true },
  { text: '🏆 AHWS ranked among Top Schools in Delhi NCR', link: '/about', isNew: true },
  { text: '☀️ Summer Vacation: June 1 - July 5, 2026', link: '/events', isNew: false },
  // ...more items
]
```

### 6.3 How Data Is "Pushed" Into the UI — .map()

The core technique is JavaScript's `.map()` array method, which transforms a data array into an array of JSX elements. React renders that array as a list of DOM nodes.

**How it works:**
```jsx
// DATA:
const items = [
  { icon: '🏫', title: 'Seamless Pathway', desc: 'Playgroup to Higher Education...' },
  { icon: '🤖', title: 'Future-Ready Tech', desc: 'Smart classrooms, AI Labs...' },
  { icon: '🎭', title: 'Performing Arts', desc: 'Theater, Dance, Music...' },
]

// RENDERING (in JSX):
{items.map((item, index) => (
  <div key={index} className="feature-card">
    <span className="icon">{item.icon}</span>
    <h3>{item.title}</h3>
    <p>{item.desc}</p>
  </div>
))}
```

This produces three `<div>` elements in the DOM — one for each item in the array. If you add a 4th item to the `items` array, a 4th card automatically appears — no additional HTML needed.

**The `key` prop:** Each mapped element needs a unique `key` prop. React uses this to efficiently identify which items changed, were added, or were removed, so it can update only those specific DOM nodes rather than re-rendering the entire list.

### 6.4 Content Update Workflow

To update website content (e.g., add a new event, change a teacher description):
1. Open the relevant `.jsx` file (e.g., `Events.jsx` to add an event)
2. Find the data array at the top of the file
3. Add, modify, or remove an object from the array
4. Save the file — Vite's HMR updates the browser instantly in dev mode
5. Run `npm run build` to generate a new production `index.html`
6. Upload the new `index.html` to the web server

---

## 7. Component Architecture — Reusable Building Blocks

### 7.1 Component Design Philosophy

Every UI element that appears on more than one page is extracted into a **shared component** in the `src/components/` folder. This follows the DRY (Don't Repeat Yourself) principle — change the component once, the change reflects everywhere it is used.

### 7.2 Header Component (`Header.jsx`)

The header is one of the most complex components. It manages:

1. **Scroll State** — tracks whether the user has scrolled more than 60px down:
   ```jsx
   const [scrolled, setScrolled] = useState(false)
   useEffect(() => {
     const handleScroll = () => setScrolled(window.scrollY > 60)
     window.addEventListener('scroll', handleScroll)
     return () => window.removeEventListener('scroll', handleScroll)
   }, [])
   ```
   When `scrolled` becomes `true`, the CSS class `.scrolled` is added to the header, which CSS uses to apply a compact, shadow style.

2. **Dropdown State** — tracks which dropdown menu is open:
   ```jsx
   const [openDropdown, setOpenDropdown] = useState(null)
   ```
   On desktop, `onMouseEnter` sets this to the hovered item's label; `onMouseLeave` resets it to `null`. The dropdown `<ul>` only renders when `openDropdown === item.label`.

3. **Mobile Menu State** — tracks whether the hamburger menu is open:
   ```jsx
   const [mobileOpen, setMobileOpen] = useState(false)
   ```
   The hamburger button (☰) toggles this. The mobile menu slides in/out via CSS transitions.

4. **Route-based Auto-close** — closes menus when user navigates:
   ```jsx
   const location = useLocation()
   useEffect(() => {
     setMobileOpen(false)
     setOpenDropdown(null)
   }, [location])
   ```

5. **Accessibility** — proper `aria-haspopup`, `aria-expanded`, and `aria-label` attributes for screen readers.

### 7.3 SEO Component (`SEO.jsx`)

This is a **headless component** — it renders nothing visible, but manages the document's `<head>` metadata dynamically.

```jsx
const routeMetadata = {
  '/': { title: 'Academic Heights World School...', description: '...' },
  '/about': { title: 'About Us | AHWS Delhi', description: '...' },
  // ...15+ routes
}

export default function SEO() {
  const location = useLocation()
  useEffect(() => {
    const meta = routeMetadata[location.pathname] || routeMetadata['/']
    document.title = meta.title

    let metaDesc = document.querySelector('meta[name="description"]')
    if (!metaDesc) {
      metaDesc = document.createElement('meta')
      metaDesc.setAttribute('name', 'description')
      document.head.appendChild(metaDesc)
    }
    metaDesc.setAttribute('content', meta.description)
  }, [location])

  return null
}
```

Every time the route changes, `useEffect` fires and:
1. Updates `document.title` with a page-specific title
2. Finds or creates the `<meta name="description">` tag and updates its `content`

This is critical for SEO — Google reads different titles and descriptions for each URL.

### 7.4 FloatingEnquiry Component

The floating enquiry button is a permanently visible widget in the bottom-right corner. It manages a 3-state interaction flow:

- **State 1 — Idle:** Shows a "🎓 Enquire Now" button.
- **State 2 — Form Open:** Shows a slide-up panel with a contact form.
- **State 3 — Submitted:** Shows a success screen with a thank-you message.

The form collects: Parent Name, Phone Number, Email, and Class of Interest. The submission is simulated (1 second delay), after which the success state shows for 2.5 seconds before the panel closes automatically.

### 7.5 AnnouncementTicker Component

A horizontally scrolling news ticker at the very top of every page. It uses a **CSS animation** (`@keyframes`) to continuously scroll a duplicated list of items from right to left, creating a seamless loop effect. The items array contains school news, events, and admission notices, each with a link and an `isNew` flag that shows a blinking "NEW" badge.

### 7.6 PageBanner Component

A simple reusable banner used at the top of every inner page (About, Admission, etc.):
```jsx
function PageBanner({ title, image }) {
  return (
    <div className="page-banner" style={{ backgroundImage: `url(${image})` }}>
      <h1>{title}</h1>
    </div>
  )
}
```
Takes a `title` (shown as text) and `image` (shown as background). This ensures consistent styling across all inner pages.

---

## 8. Pages — Individual Route Components

### 8.1 Home Page (`Home.jsx`)

The most complex page. It contains multiple independent sections:

1. **Hero Section** — Full-screen image carousel using Swiper.js with autoplay. Contains the main headline and two CTA buttons (Admissions + Virtual Tour).
2. **Announcement Ticker** — Pulls from the `tickerItems` array.
3. **Uniqueness Grid** — A masonry-style grid of school USPs, each defined in the `uniquenessData` array. Items with `hero: true` get a larger card with a full description; others get compact cards with just a tagline.
4. **Infrastructure Section** — Cards mapped from `infraItems`. Each card has a title, icon, description, and an image.
5. **Statistics Counter Section** — Animated numbers (1200+ Students, 150+ CCTVs, etc.) using `react-countup` + `react-intersection-observer`.
6. **Testimonials Section** — Parent testimonials in a Swiper carousel.
7. **Quick Links Section** — Shortcut buttons to important pages.

### 8.2 Curriculum Page (`Curriculum.jsx`)

This is the largest page in the codebase (~25 KB). It describes the SPROUT curriculum system with:
- 7-layer SPROUT methodology breakdown
- NEP-2020 5+3+3+4 stage framework
- Multiple Intelligences theory
- Subject grid by stage
- Examination schedule

All data for this is stored in arrays within the file.

### 8.3 Gallery Page (`Gallery.jsx`)

Features a **category filter system**:
1. A list of category buttons is rendered from a `categories` array.
2. `activeCategory` state tracks the selected category.
3. The images array is filtered based on `activeCategory` using `.filter()`:
   ```jsx
   const filteredImages = images.filter(img =>
     activeCategory === 'All' || img.category === activeCategory
   )
   ```
4. The filtered results are mapped into a responsive masonry grid.
5. Clicking an image opens a **lightbox** (full-screen overlay) showing the image.

### 8.4 Events Page (`Events.jsx`)

Shows news & event highlights. Events are stored in an array with fields like: `title`, `date`, `description`, `image`, `category`, `highlight`. A filter system similar to Gallery allows viewing by category (Sports, Academic, Cultural, etc.).

### 8.5 About Page (`About.jsx`)

Contains:
- **Leadership section** with flip-card components showing director, principal, and associate director quotes
- **School journey** narrative section with the AHWS history
- **Why AHWS** cards (6 cards) with 3D flip-on-click interaction
- **360° App** section describing the school's mobile application

### 8.6 Admission Page (`Admission.jsx`)

Contains:
- Age criteria table by class
- Step-by-step admission process
- Online enquiry form
- Links to PDF documents (draw list, registered applicants)

### 8.7 Infrastructure Page (`Infrastructure.jsx`)

Details campus facilities including:
- Library (6,000+ books)
- Science and AI Robotics labs
- Sports courts and grounds
- Smart classrooms
- Safety systems (150 CCTV cameras)

---

## 9. State Management — How the App Tracks Changes

### 9.1 No Global State Management

This project deliberately does **not** use Redux, Zustand, Context API, or any global state management library. Here is why this is the right decision for this project:

- The website is primarily **read-only content** — users read information, they do not modify it.
- The few interactive elements (dropdown open/close, gallery filter, form submission) are entirely self-contained within their component.
- Global state would add unnecessary complexity and bundle size.

### 9.2 Local Component State with useState

Every interactive element manages its own state using `useState`:

| Component | State Variables | Purpose |
|---|---|---|
| Header | `scrolled`, `mobileOpen`, `openDropdown` | Sticky header, hamburger, dropdowns |
| FloatingEnquiry | `isOpen`, `isSubmitting`, `submitted` | Form panel open/close/submit states |
| Gallery | `activeCategory`, `selectedImage` | Filter active state, lightbox image |
| About | `selectedLeader` | Leadership modal popup |
| FlippableWhyCard | `isFlipped` | Card flip state |
| AnnouncementTicker | `isVisible` | Show/hide ticker |

### 9.3 The React Rendering Cycle

When state changes:
1. `setState()` is called (e.g., `setScrolled(true)`)
2. React schedules a re-render of that component
3. React calls the component function again with the new state
4. React compares the new virtual DOM output with the previous one (**reconciliation**)
5. React updates only the changed DOM nodes (**minimal DOM operations**)

This is why React is efficient — it never re-renders the entire page, only the specific elements that changed.

---

## 10. Styling System — CSS Architecture

### 10.1 Component-Scoped CSS

Each component has its own CSS file (e.g., `Header.jsx` → `Header.css`). These files are imported directly into the component file:
```jsx
import './Header.css'
```

This co-location pattern makes it clear which CSS belongs to which component.

### 10.2 CSS Custom Properties (Variables)

`index.css` defines the global design tokens used throughout the project:
```css
:root {
  --primary: #1a237e;       /* Dark navy blue - brand primary */
  --accent: #FFC700;        /* Gold - brand accent */
  --text: #212121;          /* Near-black for body text */
  --bg: #f5f5f5;            /* Light grey background */
  --white: #ffffff;
  --shadow: 0 4px 20px rgba(0,0,0,0.1);
  --radius: 12px;           /* Default border radius */
  --transition: 0.3s ease;  /* Standard animation timing */
}
```

Any component can use these variables with `var(--primary)`. If the brand color ever needs to change, you update it in one place and it propagates everywhere.

### 10.3 Responsive Design

All components use **CSS Flexbox** and **CSS Grid** for layout, with **Media Queries** for responsiveness:
```css
/* Desktop: 3-column grid */
.why-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

/* Mobile: 1-column stack */
@media (max-width: 768px) {
  .why-grid {
    grid-template-columns: 1fr;
  }
}
```

### 10.4 CSS Animations

The website uses **CSS keyframe animations** for:
- The announcement ticker scroll (continuous left scroll)
- Scroll-triggered `fadeInUp` animations on cards
- Hover scale effects on cards and buttons
- The blinking "REGISTRATION OPEN" badge
- Floating enquiry button pulse effect
- 3D card flip animations (CSS `perspective` + `rotateY`)

**Example — 3D Card Flip:**
```css
.feature-flip-card {
  perspective: 1000px;
}
.feature-flip-inner {
  transition: transform 0.7s;
  transform-style: preserve-3d;
}
.feature-flip-card.is-flipped .feature-flip-inner {
  transform: rotateY(180deg);
}
.feature-flip-front { backface-visibility: hidden; }
.feature-flip-back {
  backface-visibility: hidden;
  transform: rotateY(180deg);
}
```

---

## 11. SEO System — Search Engine Optimization

This website implements a comprehensive, multi-layered SEO strategy:

### Layer 1: HTML `<head>` Meta Tags (index.html)
- `<title>` — Page title shown in browser tab and search results
- `<meta name="description">` — Page summary shown in Google search results
- `<meta name="keywords">` — Keyword hints
- `<meta name="robots" content="index, follow">` — Tells Google to index and follow links
- `<meta name="author">` — Content author

### Layer 2: Open Graph Tags (Social Media Preview)
When the AHWS website URL is shared on Facebook, WhatsApp, or LinkedIn, these tags control the preview:
```html
<meta property="og:type" content="website" />
<meta property="og:url" content="https://ahws.edu.in/" />
<meta property="og:title" content="Academic Heights World School..." />
<meta property="og:description" content="AHWS, Pitampura's premier..." />
<meta property="og:image" content="https://ahws.edu.in/images/logo.webp" />
```

### Layer 3: Twitter Card Tags
Similar to Open Graph, but specifically for Twitter/X sharing previews.

### Layer 4: JSON-LD Structured Data (Schema.org)
This is the most powerful SEO layer. A `<script type="application/ld+json">` block in `index.html` provides machine-readable structured data about the school:
```json
{
  "@context": "https://schema.org",
  "@type": ["School", "EducationalOrganization"],
  "name": "Academic Heights World School (AHWS)",
  "telephone": "+91-8860455000",
  "email": "info@ahws.edu.in",
  "address": { "streetAddress": "SD - QD Block, Near TV Tower..." },
  "geo": { "latitude": 28.694542, "longitude": 77.146475 },
  "hasCredential": [{ "credentialCategory": "CBSE Affiliation", "identifier": "2730105" }]
}
```
This tells Google's Knowledge Graph exactly what this entity is, enabling rich results in search (school info box, map pin, phone number, rating).

### Layer 5: Dynamic Per-Route SEO (SEO.jsx Component)
The `SEO.jsx` component changes `document.title` and the meta description tag every time the user navigates to a different route. This ensures each page has unique, relevant SEO metadata, which is critical because search engines crawl different URLs independently.

### Layer 6: Google Site Verification
```html
<meta name="google-site-verification" content="4B2YzZUQyLGofpmXDrMyFskrL1hQG-Cv4Qu2ZTCOo3E" />
```
This proves to Google that AHWS owns this website, enabling Google Search Console access for performance monitoring.

### Layer 7: Semantic HTML
All pages use proper semantic HTML5 elements:
- `<header>` for the navigation
- `<main>` for the main content
- `<section>` for content sections
- `<footer>` for the footer
- `<h1>` only once per page (the most important heading)
- `<h2>`, `<h3>` for section and subsection headings in proper hierarchy
- `<nav>` for navigation with `aria-label`
- `<img>` with descriptive `alt` attributes on every image

---

## 12. Build System — Vite & Bundling

### Development Mode (`npm run dev`)
1. Vite starts a local dev server (usually at `http://localhost:5173`)
2. It does NOT bundle files — it serves them as native ES Modules
3. When you save a file, only that file is re-processed
4. React Fast Refresh updates the browser in under 50ms without losing component state
5. Source maps are generated for easy debugging in browser DevTools

### Production Build (`npm run build`)
1. Vite runs Rollup to bundle all JS files into one optimized file
2. CSS is extracted and optimized (minified, vendor-prefixed)
3. `vite-plugin-singlefile` inlines all JS, CSS, and small assets into `index.html`
4. The result: a single `index.html` file in the `dist/` folder
5. This file is entirely self-contained — it can be opened directly in a browser from your desktop without any server

### Build Optimizations Applied:
- **Tree-shaking**: Unused JavaScript code is eliminated — if a library export is imported but not used anywhere, it is removed
- **Minification**: Variable names are shortened, whitespace removed (`if (isScrolled)` becomes `if(a)`)
- **Dead code elimination**: Code inside `if (process.env.NODE_ENV === 'development')` blocks is removed entirely from the production bundle
- **CSS minification**: Whitespace, comments, and redundant rules removed
- **Module coalescing**: All JS modules merged into one minimal file

### `@vitejs/plugin-legacy` — Older Browser Support
This plugin (listed in devDependencies) generates a second version of the bundle using Babel to transpile modern JavaScript (ES2022) down to ES5 for older browsers that do not support ES modules. It automatically serves the right version to each browser using the `<script type="module">` / `<script nomodule>` pattern.

---

## 13. Performance Patterns Used in This Codebase

### 13.1 `loading="lazy"` on Images
Heavy images (gallery, leader portraits) use the HTML `loading="lazy"` attribute. The browser only downloads these images when they are about to scroll into view, saving bandwidth on initial page load. Without this, all images would download immediately even if the user never scrolls to them.

### 13.2 Scroll-Triggered Animations (Intersection Observer)
Animations and CountUp counters only activate when visible. This prevents unnecessary JavaScript computation and CSS repaints on sections the user has not reached yet.

### 13.3 Event Listener Cleanup
Every `addEventListener` in a `useEffect` has a corresponding `removeEventListener` in its cleanup function:
```jsx
useEffect(() => {
  window.addEventListener('scroll', handler)
  return () => window.removeEventListener('scroll', handler)
}, [])
```
Without cleanup, old event listeners accumulate every time the component mounts, causing memory leaks where the browser holds on to dead references.

### 13.4 `rel="noopener noreferrer"` on External Links
Every `<a target="_blank">` link includes `rel="noopener noreferrer"`. This prevents the opened tab from accessing the opener window's `window.opener` property — a security vulnerability known as "reverse tabnapping". It also slightly improves performance as the new tab cannot slow down the original page.

### 13.5 Conditional Rendering (Not `display:none`)
Instead of hiding elements with CSS `display: none` (which still renders them in the DOM), this codebase uses conditional rendering:
```jsx
{isOpen && <div className="dropdown">...</div>}
```
When `isOpen` is `false`, the dropdown element does not exist in the DOM at all — saving memory, avoiding layout recalculations, and preventing hidden elements from interfering with screen readers.

### 13.6 External Images via CDN
All school logo, teacher portraits, and facility images are served from `ahws.edu.in` or Unsplash's CDN (Content Delivery Network). CDNs serve images from edge servers closest to the user's location, reducing download time significantly compared to serving from a single server.

---

## 14. External Libraries — What They Do & Why Used

| Library | Version | Purpose | Why This One |
|---|---|---|---|
| `react` | ^18.3.1 | Core UI framework | Industry standard, massive ecosystem |
| `react-dom` | ^18.3.1 | React's browser renderer | Required companion to React |
| `react-router-dom` | ^6.26.2 | Client-side routing (SPA navigation) | Official React routing solution |
| `swiper` | ^11.1.14 | Touch-enabled carousels and sliders | Best-in-class, mobile-native, modern API |
| `react-countup` | ^6.5.3 | Animated number counters | Simple API, smooth easing animations |
| `react-intersection-observer` | ^9.13.1 | Viewport entry detection for scroll effects | Thin wrapper over powerful browser API |
| `react-icons` | ^5.3.0 | SVG icon library (20+ icon sets) | Tree-shakable, no icon font needed |
| `vite` | ^5.4.8 | Build tool and dev server | Fastest developer experience available |
| `@vitejs/plugin-react` | ^4.3.1 | JSX transform + Hot Module Replacement | Official Vite-React integration |
| `vite-plugin-singlefile` | ^2.3.3 | Bundle entire app into one HTML file | Enables simple static file deployment |
| `@vitejs/plugin-legacy` | ^5.4.3 | Legacy browser (ES5) compatibility | Supports older browsers automatically |

---

## 15. Deployment Strategy

### Current Deployment Model
The website is deployed as a **static single HTML file**. The deployment workflow is:
1. Developer edits source code in `src/`
2. Runs `npm run build` → Vite generates `dist/index.html`
3. Uploads `dist/index.html` to the web server at `https://ahws.edu.in/`

### Why This Model Works
- **Zero server-side infrastructure needed** — no Node.js, PHP, Python, or database required on the server
- **Extremely fast** — the browser receives all content in one network response, no additional API calls
- **Resilient** — no backend to crash, patch, or maintain
- **CDN-friendly** — a static HTML file can be cached and served from edge locations worldwide
- **Cost-effective** — can be hosted on any basic web server, GitHub Pages, Netlify, or even from a file share

### GitHub Repository
The source code is maintained in a GitHub repository, enabling:
- **Version control** — every change is tracked with commit messages describing what changed and why
- **Collaboration** — multiple developers can work on different features simultaneously using branches
- **Rollback** — any previous version of the website can be restored instantly by reverting to an older commit
- **Code review** — pull requests allow changes to be reviewed before merging
- **History** — complete audit trail of every modification to the website

### Recommended CI/CD Enhancement (Future)
A GitHub Actions workflow could automate the build and deployment:
1. Developer pushes code changes to GitHub
2. GitHub Actions automatically runs `npm run build`
3. The resulting `dist/index.html` is automatically uploaded to the web server via FTP/SSH
4. Zero manual deployment steps required

---

## 16. Data Flow Diagram — End to End

```
USER VISITS https://ahws.edu.in/
         │
         ▼
[Web Server] serves index.html (single bundled file, ~2-5 MB)
         │
         ▼
[Browser] parses HTML:
  ├── reads JSON-LD → Google's crawler indexes school info
  ├── reads <meta> og: tags → Facebook/WhatsApp use for previews
  └── reads <meta> twitter: tags → Twitter/X uses for card preview
         │
         ▼
[Browser JavaScript Engine] executes inline JS bundle
         │
         ▼
[React] mounts:
  ReactDOM.createRoot(document.getElementById('root'))
         │
         ▼
[App.jsx renders]:
  <HashRouter>              ← enables URL-based navigation
    <ScrollToTop />         ← scrolls to top on route change
    <SEO />                 ← manages dynamic <title> and <meta>
    <AnnouncementTicker />  ← renders ticker from tickerItems[]
    <Header />              ← renders nav from navItems[]
    <Routes>                ← decides which page to show
    <Footer />              ← renders footer links
    <FloatingEnquiry />     ← renders floating form button
  </HashRouter>
         │
         ▼
[URL Hash Read] → e.g. /#/ matches Route path="/"
         │
         ▼
[Home.jsx renders]:
  ├── infraItems.map()     → <InfraCard /> × 4
  ├── uniquenessData.map() → <UniCard /> × 8
  ├── statistics.map()     → <CountUp /> × 5 (triggers on scroll)
  ├── testimonials.map()   → <Swiper slide /> × N
  └── tickerItems.map()    → <TickerItem /> × N
         │
         ▼
[Browser DOM] — React-generated HTML rendered on screen
         │
USER SCROLLS → IntersectionObserver fires → CountUp animates
USER HOVERS NAV → openDropdown state set → dropdown renders
USER CLICKS "About Us" → React Router → URL changes to /#/about
         │
         ▼
[Routes rematch] → <About /> mounts, <Home /> unmounts
  → ScrollToTop fires → window.scrollTo(0,0)
  → SEO fires → document.title = "About Us | AHWS Delhi"
         │
         ▼
[About.jsx renders]:
  ├── leaders.map()        → 3 leadership quote cards
  ├── whyItems.map()       → 6 FlippableWhyCard components
  └── app360 features      → static content
         │
         ▼
USER CLICKS CARD → setIsFlipped(true) → card.is-flipped CSS class
  → CSS rotateY(180deg) → 3D flip animation plays
         │
USER CLICKS "Enquire Now" BUTTON:
  → setIsOpen(true) → floating panel slides up
  → form renders with Parent Name, Phone, Email, Class fields
  → onSubmit → setIsSubmitting(true) → 1s timeout
  → setTimeout → setSubmitted(true) → success message shows
  → 2.5s timeout → setSubmitted(false), setIsOpen(false)
```

---

## Summary

The AHWS website is a modern, high-performance, static Single Page Application built with the following key technical choices:

| Decision | Choice | Reason |
|---|---|---|
| UI Framework | React 18 | Component model, huge ecosystem, industry standard |
| Build Tool | Vite 5 | Fastest dev experience, Rollup production bundles |
| Routing | React Router v6 (HashRouter) | SPA navigation, static file compatible |
| Deployment | vite-plugin-singlefile | Single file = zero infrastructure |
| Data Storage | JS arrays in component files | No backend needed, instant reads |
| Styling | Component-scoped CSS + CSS variables | Simple, maintainable, design system |
| SEO | JSON-LD + OG + Twitter + dynamic meta | Full coverage for search + social |
| Animations | CSS keyframes + Intersection Observer | GPU-accelerated, scroll-triggered |
| Icons | react-icons | Tree-shakable, no font files |
| Sliders | Swiper.js | Touch-native, accessible |
| Counters | react-countup + react-intersection-observer | Viewport-triggered for impact |

Every page is a React component. Every list of items (nav links, facility cards, events, committee members) is a JavaScript array mapped to JSX. Every user interaction (open dropdown, submit form, filter gallery) is managed with `useState`. The build system compiles everything into a single optimized HTML file that can be uploaded to any web server and requires zero backend infrastructure.

---

*Document prepared for Academic Heights World School — Development Reference | August 2026*

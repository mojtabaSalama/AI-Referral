📘 **AI-Referral – Flutter Reader-Friendly Guide**  
*(what every page does, in plain English)*

---

### 1️⃣ `main.dart` – **The Front-Door**
- Registers `PatientsProvider` (global state).
- Builds `MaterialApp` with **4 named routes**:
  - `/form` → data-entry screen
  - `/prediction` → result screen
  - `/dashboard` → statistics home
  - `/list` → history list
- Sets **Arabic-fluent Cairo font** + unified **blue theme**.

---

### 2️⃣ `PatientFormScreen` – **Data Entry**
*(not shown but referenced)*  
Collects 9 vital signs → calls `provider.insertRecord()` → pushes `/prediction`.

---

### 3️⃣ `PredictionScreen` – **The Verdict**
- **Watches** the provider for the **latest** record.
- While waiting: white screen + “Predicting” + spinner.
- When ready:
  - **RED card** if `triageLevel == 1` (Urgent)  
  - **GREEN card** if `0` (Normal)
- Lists **all vitals** in cute shadow-cards.
- **Two floating buttons**:
  - “Make New Prediction” → `/form`
  - “Previous Assessments” → `/list`

---

### 4️⃣ `PatientList` – **History**
- On open: auto-fetches **full summary**.
- Chips: *All / Urgent / Normal* (filter not wired yet).
- Cards: ID, complaint, coloured border (red/green).
- Tap card → navigates to `Assessment(id)` for **deep-dive**.

---

### 5️⃣ `PatientDashboard` – **Statistics Home**
- **Total count** big headline.
- **Two stat-cards**: Urgent vs Normal (live numbers).
- **Same two floating buttons** as PredictionScreen for quick actions.

---

### 6️⃣ `Assessment` – **Single Record Deep-Dive**
- Receives `id` in constructor.
- On open: fetches **one** record by ID.
- Shows:
  - **Triage-level banner** (red/green)
  - **Age / Gender** split box
  - **Chief-complaint** paragraph
  - **5 vital cards** (each sign gets its own card + icon)
  - **Pain-grade** with tiny progress-bar
- **Only one floating button**: “Make New Prediction” (clears stack back to form).

---

### 7️⃣ `PatientsProvider` – **The Brain**
*(not shown but drives everything)*  
- `insertRecord()` → POST to Flask API → updates local list.
- `fetchSummary()` → GET `/summary` → fills dashboard & list.
- `getByID(id)` → GET `/record/<id>` → fills Assessment page.
- Exposes `List<PatientRecord> records`, `Summary summary`, `PatientRecord? record`, `bool isLoading`.

---

### 🎨 Visual Language
- **Blue primary** (`#2563EB`) – headers & CTAs  
- **Red accent** – urgent states  
- **Green accent** – normal states  
- **Grey surface** – cards background  
- **Rounded 16 px** – universal radius  
- **Cairo font** – Arabic readability

---

### 🧭 Navigation Flow
```
/form → /prediction → /list → /assessment(id)
   ↖__________/dashboard________↙
```
Every screen can jump back to **form** or **history** instantly via floating buttons.

---

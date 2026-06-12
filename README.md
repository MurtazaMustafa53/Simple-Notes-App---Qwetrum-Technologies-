# Notes Application — Dynamic SQLite & MVC Architecture

A minimalist, clean, and user-centric mobile Notes application built to demonstrate structured layout design, consistent component styling, and robust architectural separation using the MVC (Model-View-Controller) pattern powered by Provider state management and SQLite persistence.

This project covers the implementation of core mobile layout challenges, focusing on crisp UI presentation, local database synchronization, real-time search filtering, and responsive view layouts.

---

## 🚀 Features & Requirements

The application transforms complex functional engineering requirements into a reactive local system across three primary screens:

* **Home Screen (Dynamic Layouts):** Displays saved notes with the ability to instantly toggle between a clean **List View** and a balanced **2-Column Grid View**. Includes a real-time responsive app bar switcher.
* **Real-Time Search Bar:** Implements a localized query filter at the top of the Home Screen that isolates notes by title instantly as the user types without database latency.
* **Add Note Screen:** A dedicated, clutter-free workflow featuring intuitive input fields (Note Title and Body) paired with an asynchronous saving mechanism to avoid application thread blocking.
* **View Note Detail Screen:** A focused, streamlined interface optimized for a distraction-free, effortless reading experience. Features a **Destructive Action Safety Guard** (Confirmation Dialog) before allowing the permanent deletion of any note.
* **Automatic Metadata Generation:** Every single note object automatically computes its creation timestamp and generates a customized background color tag for a polished interface.

---

## 🎨 UI/UX & Design Consistency

* **Unified Visual Identity:** Implemented a unified color palette featuring deep teal accents across all action buttons, app bars, and interface highlights.
* **Dynamic Card Colors:** Automatically converts generated background color integer properties into matching card canvas accents.
* **Typography & Component Styling:** Maintained consistent fonts, customized padding, input borders, and elevated button styles across all screens to eliminate clutter.
* **Clean Layouts:** Prioritizes whitespace, elegant font-weighting, and maximum content readability across list and grid items.

---

## 🏗️ Architecture (MVC + Provider)

To ensure the codebase remains maintainable, scalable, and modular, the project is structured strictly around the **Model-View-Controller (MVC)** architectural pattern coupled with **Provider state management** to ensure unidirectional data flow and clean separation of concerns:


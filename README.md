# Notes Application — Static UI \& MVC Architecture



A minimalist, clean, and user-centric mobile Notes application built to demonstrate structured layout design, consistent component styling, and robust architectural separation using the MVC (Model-View-Controller) pattern.



This project covers the implementation of core mobile layout challenges, focusing on crisp UI presentation, layout structure, and design consistency.



##### 🚀 Features \& Requirements



The application transforms specific functional design requirements into a working layout across three primary screens:



* Home Screen (List View): Displays saved notes using a clean list layout showing note titles, brief body previews, and creation dates for at-a-glance navigation. Includes an accessible Floating Action Button (+) to effortlessly navigate to the creation flow.



* Add Note Screen: A dedicated, clutter-free workflow featuring intuitive text input fields (Note Title and Body) paired with a prominent, styled Save Note action button.



* View Note Detail Screen: A focused, streamlined interface optimized for a distraction-free, effortless reading experience.





##### 🎨 UI/UX \& Design Consistency



* Unified Visual Identity: Implemented a unified color palette featuring deep teal accents (#00695C style) across all action buttons, app bars, and interface highlights.



* Typography \& Component Styling: Maintained consistent fonts, customized padding, input borders, and button styles across all screens to eliminate clutter.



* Clean Layouts: Designed to avoid complex or overlapping elements, prioritizing whitespace and high readability.





##### 🏗️ Architecture (MVC)



To ensure the codebase remains maintainable, scalable, and modular, the project is structured strictly around the Model-View-Controller (MVC) architectural pattern. This guarantees a clean separation of presentation layers from data structures:



* Model (models/): Defines the data blueprint and structural properties of a Note object (including ID, title, body preview text, and creation timestamp).



* View (views/): Handles the frontend layout presentation, UI rendering, and interface elements (Home, Add Note, and Detail views).



* Controller (controllers/): Manages the core business logic, mapping user interactions from the View layer and preparing data structures for future dynamic state handling.




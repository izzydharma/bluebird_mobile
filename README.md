# bluebird_mobile

## ASSIGNMENT 7

### Stateless Widgets vs. Stateful Widgets

- Stateless Widgets: These widgets do not maintain any internal state and are immutable. They are rebuilt when their parent widget rebuilds. Examples in this project include MaterialApp, AppBar, and Text.

- Stateful Widgets: These widgets can maintain internal state that may change over time. They can be rebuilt to reflect changes in their state. While not explicitly used in your code, StatefulWidget is generally employed for interactive components like forms or buttons that respond to user input.

### Widgets Used in This Project

- MaterialApp: Initializes the app and sets the theme.
- Scaffold: Provides the basic layout structure, including the AppBar and body.
- AppBar: Displays the title and actions for the current screen.
- Padding: Adds space around the child widget.
- Column: Arranges child widgets vertically.
- SizedBox: Creates fixed space between widgets.
- Center: Centers child widgets within its area.
- GridView.count: Displays items in a grid layout.
- Card: Provides a visually distinct container for content.
- Container: Adds padding and layout control around child widgets.
- InkWell: Provides touch feedback for interactive elements.
- SnackBar: Displays brief messages to the user upon actions.

### Use-case for setState()

The setState() method is used within a StatefulWidget to notify the framework that the internal state has changed, prompting a rebuild of the widget. It affects variables declared in the state class, such as counters, toggles, or any data that may change based on user interactions.

### Difference Between const and final

- const: Used for compile-time constants. The value is immutable and cannot change. If a widget is declared as const, it is created only once, which can improve performance.

- final: Used for runtime constants. A variable can only be assigned once, but it can be initialized with a value that may be determined at runtime.

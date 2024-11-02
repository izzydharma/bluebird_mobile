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


### Step by step implementation

**1. Create a new Flutter application with the E-Commerce theme that matches the previous assignments.**
Create the new flutter app by running ```flutter create bluebird_mobile``` 

Open lib/main.dart and set the MyApp class to match the last assignment's theme :

```
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(secondary: Colors.lightBlueAccent[400]),
      ),
      home: MyHomePage(),
    );
  }
}
```

then also import these two things :

```
import 'package:flutter/material.dart';
import 'package:bluebird_mobile/menu.dart'; // Import your menu.dart file
```

2. Create three simple buttons with icons and texts

in the ```lib``` directory make a new file called menu.dart add a new class called MyHomePage with this

```
final List<ItemHomepage> items = [
  ItemHomepage("View Product", Icons.mood, Colors.blue), 
  ItemHomepage("Add Product", Icons.add, Colors.green), 
  ItemHomepage("Logout", Icons.logout, Colors.red), 
];
```

Use a GridView to display the buttons

```
GridView.count(
  primary: true,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 3,
  shrinkWrap: true,
  children: items.map((ItemHomepage item) {
    return ItemCard(item);
  }).toList(),
)
```
3. Give each buttons diffrent color

Crate a new class called ```ItemHomePage```, Add a constructor to initialize these properties:

```
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  
  ItemHomepage(this.name, this.icon, this.color);
}
```

4. Display a Snackbar with  messages:

Crate the ```ItemCard``` class to show the Snackbar with the messages

```
class ItemCard extends StatelessWidget {
  final ItemHomepage item;
  
  const ItemCard(this.item, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // Handle button tap with specific messages
          String message;
          switch (item.name) {
            case "View Product":
              message = "You have pressed the View Product button!";
              break;
            case "Add Product":
              message = "You have pressed the Add Product button!";
              break;
            case "Logout":
              message = "You have pressed the Logout button!";
              break;
            default:
              message = "";
          }
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(item.name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```






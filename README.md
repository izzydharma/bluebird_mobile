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

**2. Create three simple buttons with icons and texts**

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
**3. Give each buttons diffrent color**

Crate a new class called ```ItemHomePage```, Add a constructor to initialize these properties:

```
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  
  ItemHomepage(this.name, this.icon, this.color);
}
```

**4. Display a Snackbar with  messages:**

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

# bluebird_mobile

## ASSIGNMENT 8

### Step by step implementation

#### Creating the form

make a new file in the lib directory called ```add_item_form.dart```, with this codes

```
import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double amount = 0.0;
  String description = '';

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Form Data'),
          content: Text('Name: $name\nAmount: $amount\nDescription: $description'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('OK')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a name';
                  if (value.length < 3) return 'Name must be at least 3 characters';
                  if (value.length > 50) return 'Name cannot exceed 50 characters';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => amount = double.tryParse(value ?? '0') ?? 0.0,
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null) return 'Please enter a valid number';
                  if (parsed < 0) return 'Amount cannot be negative';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => description = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a description';
                  if (value.length < 5) return 'Description must be at least 5 characters';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveForm, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
```

#### Redirect the user to the new item addition form when they press the Add Item button on the main page.

On the ItemCard widget in the ```menu.dart``` add this code after the ontap method

```
        onTap: () {
          if (item.name == "Add Product") {
            // Navigate to AddItemForm when "Add Product" is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => AddItemForm()),
            );
          }
```

####  Display the data from the form in a pop-up after pressing the Save button on the new item addition form page.

in the ```add_item_form.dart``` add this code snippet in the ```_AddItemFormState``` class 

```
  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Form Data'),
          content: Text('Name: $name\nAmount: $amount\nDescription: $description'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('OK')),
          ],
        ),
```

#### Create a drawer in the application 

Create a new folder called ```widget``` in the lib directory, then make a new file called ```drawer_widget.daty``` and add these following code

```
import 'package:flutter/material.dart';
import 'package:bluebird_mobile/add_item_form.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Item'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddItemForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
```

### 1. Purpose of const in Flutter

The const keyword in Flutter is used to define compile-time constants. This means that the value or object that is marked as const is determined during the compilation, not at runtime. Using const allows Flutter to optimize widget trees by reusing widget instances rather than creating new ones every time the widget is built.

Advantages of using const in Flutter:

- Performance Optimization: When you use const, Flutter reuses the widget instead of recreating it every time the widget tree is rebuilt. This can improve performance by reducing unnecessary widget instantiations.
- Memory Efficiency: const widgets are stored in the memory pool, meaning they are only created once, leading to lower memory usage.
- Compile-time Evaluation: Using const enables the Flutter framework to evaluate values at compile-time, which can help catch errors earlier and reduce runtime overhead.
  
When to use const:

- When the widget or value is known at compile time and will not change.
- For static, non-changing content like icons, images, and text.

### 2. Usage of Column and Row in Flutter

- Column: The Column widget is a layout widget that arranges its children vertically. It takes a list of widgets and places them one after the other, vertically. You can customize its alignment, spacing, and behavior when there is limited space.

- Row: The Row widget arranges its children horizontally. Like Column, it takes a list of widgets but arranges them from left to right.

Example of Column:

```
dart
Copy code
Column(
  children: [
    Text('First Item'),
    Text('Second Item'),
    RaisedButton(onPressed: () {}, child: Text('Click Me')),
  ],
)
```

Example of Row:

```
dart
Copy code
Row(
  children: [
    Icon(Icons.home),
    Text('Home'),
    Icon(Icons.search),
  ],
)
```

### 3. Input Elements Used on the Form Page

In my AddItemForm page, the following input elements are used:

  1. TextFormField for Name:

  - It accepts text input, with validation to ensure it's at least 3 characters long, does not exceed 50 characters, and is not empty.

  2. TextFormField for Amount:

  - It accepts numeric input with the keyboardType: TextInputType.number to prompt the numeric keyboard. Validation ensures the value is a valid number and is not negative.

  3. TextFormField for Description:

  - It accepts multi-line text with maxLines: 3, with validation to ensure it's at least 5 characters long and is not empty.


Other Flutter Input Elements You Didn’t Use:

- Checkbox: Used for binary choices (true/false).
- Radio: Allows a set of mutually exclusive options.
- Switch: Toggles between two states (on/off).
- DatePicker / TimePicker: Allows the user to pick a date or time from a calendar or clock interface.
- DropdownButton: For selecting from a list of options.
- These elements could be useful for other form fields if your application requires binary or multiple choice options.

### 4. Setting the Theme in Flutter

To ensure consistency in a Flutter app, themes are used to define colors, font styles, button styles, etc. The theme is set globally through the ThemeData object in the MaterialApp widget. 

Here is my theme

```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

### 5. Managing Navigation in a Multi-Page Flutter Application

In Flutter, navigation between pages is managed using the Navigator widget. The Navigator.push method is used to navigate to a new page, while Navigator.pop is used to go back to the previous page.

this is an example from my app

```
  onTap: () {
          if (item.name == "Add Product") {
            // Navigate to AddItemForm when "Add Product" is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => AddItemForm()),
            );
          }
```


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

## ASSIGNMENT 8
### Step by step implementation
### Implement the registration feature in the Flutter project. Create a login page in the Flutter project.
add this in django:
```
@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Successful login status.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login successful!"
                # Add other data if you want to send data to Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login failed, account disabled."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login failed, check email or password again."
        }, status=401)
    
@csrf_exempt
def register(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data['username']
        password1 = data['password1']
        password2 = data['password2']

        # Check if the passwords match
        if password1 != password2:
            return JsonResponse({
                "status": False,
                "message": "Passwords do not match."
            }, status=400)

        # Check if the username is already taken
        if User.objects.filter(username=username).exists():
            return JsonResponse({
                "status": False,
                "message": "Username already exists."
            }, status=400)

        # Create the new user
        user = User.objects.create_user(username=username, password=password1)
        user.save()

        return JsonResponse({
            "username": user.username,
            "status": 'success',
            "message": "User created successfully!"
        }, status=200)

    else:
        return JsonResponse({
            "status": False,
            "message": "Invalid request method."
        }, status=400)

@csrf_exempt
def logout(request):
    username = request.user.username

    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logged out successfully!"
        }, status=200)
    except:
        return JsonResponse({
        "status": False,
        "message": "Logout failed."
        }, status=401)
```
also dont forget to add login.dart and register.dart in screens directory

### Integrate the Django authentication system with the Flutter project.

add this in login.dart
```
import 'package:bluebird_mobile/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bluebird_mobile/screens/register.dart';
void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(secondary: Colors.blue[400]),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password = _passwordController.text;
                      final response = await request
                          .login("http://127.0.0.1:8000/auth/login/", {
                        'username': username,
                        'password': password,
                      });

                      if (request.loggedIn) {
                        String message = response['message'];
                        String uname = response['username'];
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                  content:
                                      Text("$message Welcome, $uname.")),
                            );
                        }
                      } else {
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Login Failed'),
                              content: Text(response['message']),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 36.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

add this in register.dart
```
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password1 = _passwordController.text;
                      String password2 = _confirmPasswordController.text;

                      // Check credentials
                      // TODO: Change the url, don't forget to add a slash (/) inthe end of the URL!
                      // To connect Android emulator with Django on localhost,
                      // use the URL http://10.0.2.2/
                      final response = await request.postJson(
                          "http://localhost:8000/auth/register/",
                          jsonEncode({
                            "username": username,
                            "password1": password1,
                            "password2": password2,
                          }));
                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Successfully registered!'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to register!'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### Create a custom model according to your Django application project.

add this in models
```
// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String model;
    String pk;
    Fields fields;

    ProductEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int price;
    String description;
    int rating;
    DateTime date;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.description,
        required this.rating,
        required this.date,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        rating: json["rating"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "description": description,
        "rating": rating,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}


```

### Create a page containing a list of all items available at the JSON endpoint in Django that you have deployed.]

make list_productentry.dart in screens directory and populate with this

```
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:bluebird_mobile/models/product_entry.dart';
import 'package:bluebird_mobile/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bluebird_mobile/screens/product_detail.dart'; // Import the ProductDetail page

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json/');
    var data = response;
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'There is no product data.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  var product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(product: product),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.fields.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Price: \$${product.fields.price}"),
                          const SizedBox(height: 10),
                          Text("Rating: ${product.fields.rating}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

```

### Create a detail page for each item listed on the Product list page.
add this in detail page

```
import 'package:flutter/material.dart';
import 'package:vin_shop/models/product_entry.dart';

class ProductDetail extends StatelessWidget {
  final ProductEntry product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.fields.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Price: \$${product.fields.price}"),
            const SizedBox(height: 10),
            Text("Description: ${product.fields.description}"),
            const SizedBox(height: 10),
            Text("Rating: ${product.fields.rating}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Product List'),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Filter the item list page to display only items associated with the currently logged-in user.

add this in django
```
def create_product_entry(request):
    form = ProductForm(request.POST or None)

    if form.is_valid() and request.method == "POST":
        product_entry = form.save(commit=False)
        product_entry.user = request.user
        product_entry.save()
        return redirect('main:show_main')

    context = {'form': form}
    return render(request, "create_product_entry.html", context)
```

### Why We Need a Model to Retrieve or Send JSON Data

A model provides a structured way to manage and process JSON data exchanged between the Flutter frontend and the Django backend. It ensures consistency, simplifies serialization and deserialization, and allows the app to handle complex data structures effortlessly. 

If a model is not created, the app will still function for simple JSON parsing. However, as data complexity grows, manual handling increases the risk of errors, such as type mismatches or missing keys, leading to potential runtime exceptions and poor maintainability.

---

### Function of the `http` Library

The `http` library facilitates communication between the Flutter app and the backend server. It provides methods to:
- Send `GET`, `POST`, `PUT`, or `DELETE` requests.
- Manage headers and body content for API interactions.
- Handle responses, including status codes and data.

In this project, it enables sending user credentials to Django endpoints and retrieving responses, such as authentication success or failure.

---

### Function of `CookieRequest` and Its Shared Instance

`CookieRequest` is used to handle authenticated sessions by managing cookies automatically. It:
1. Stores authentication cookies after successful login.
2. Includes cookies in subsequent requests to maintain the session state.
3. Simplifies the management of persistent authentication across the app.

Sharing the `CookieRequest` instance with all components ensures that every request made by the app carries the necessary authentication cookies, maintaining a consistent session.

---

### Mechanism of Data Transmission (Input to Display)

1. **Input**: User enters data (e.g., username and password) into Flutter’s UI form.
2. **Transmission**: Data is sent to the Django backend via the `http` library or `CookieRequest`.
3. **Backend Processing**: Django processes the input, performs actions (e.g., validating credentials), and sends a JSON response.
4. **Frontend Processing**: Flutter parses the response using a model and updates the state.
5. **Display**: UI widgets in Flutter are rebuilt using the updated data.

This flow ensures seamless communication and a responsive user experience.

---

### Authentication Flow

#### Login
1. **Input**: User provides username and password in the Flutter login form.
2. **Transmission**: Flutter sends a `POST` request with credentials to Django’s `/auth/login/` endpoint via `CookieRequest`.
3. **Backend Validation**: Django verifies the credentials:
   - If valid, it generates a session cookie and returns it with a success message and user details.
   - If invalid, it returns an error message.
4. **Frontend Handling**:
   - On success: The `CookieRequest` stores the session cookie, and the app navigates to the main menu.
   - On failure: An error dialog is displayed.

#### Registration
1. **Input**: User provides account details in Flutter’s registration form.
2. **Transmission**: Flutter sends a `POST` request to Django’s `/auth/register/` endpoint.
3. **Backend Processing**: Django validates the data, creates a new user account, and returns a response.
4. **Frontend Handling**: The app displays success or failure feedback.

#### Logout
1. **Action**: User taps the logout button in Flutter.
2. **Transmission**: Flutter sends a `POST` request to Django’s `/auth/logout/` endpoint.
3. **Backend Processing**: Django invalidates the session and clears cookies.
4. **Frontend Handling**: The app resets the session state and navigates to the login screen.

---


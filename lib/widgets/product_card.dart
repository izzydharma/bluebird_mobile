import 'package:bluebird_mobile/screens/list_productentry.dart';
import 'package:bluebird_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../screens/additem_form.dart'; 

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Material(
      color: item.color, // Use the specific color for this item
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          if (item.name == "Add Product") {
            // Navigate to AddItemForm when "Add Product" is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => ProductEntryFormPage()),
            );
          } else if (item.name == "View Product") {
            // Navigate to ProductEntryPage when "View Product" is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => ProductEntryPage()),
            );
          } else if (item.name == "Home") {
            // Navigate to the home page when "Home" is tapped
            Navigator.of(context).pushReplacementNamed('/home');
          } else if (item.name == "Logout") {
            // Logout the user when "Logout" is tapped
    final response = await request.logout(
        // TODO: Change the URL to your Django app's URL. Don't forget to add the trailing slash (/) if needed.
        "http://127.0.0.1:8000/auth/logout/");
    String message = response["message"];
    if (context.mounted) {
        if (response['status']) {
            String uname = response["username"];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Goodbye, $uname."),
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
            );
        } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(message),
                ),
            );
        }
    }
}
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

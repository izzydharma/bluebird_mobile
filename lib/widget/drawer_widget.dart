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

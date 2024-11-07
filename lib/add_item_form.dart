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

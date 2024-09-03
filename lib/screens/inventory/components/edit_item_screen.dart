import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/inventory_item.dart';
import '../../../providers/inventory_provider.dart';

class EditItemScreen extends StatefulWidget {
  final InventoryItem item;

  const EditItemScreen({super.key, required this.item});

  @override
  EditItemScreenState createState() => EditItemScreenState();
}

class EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String image;
  late String dateAdded;
  late String expiryDate;
  late int quantity;
  late double price;
  late String details;

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    image = widget.item.image;
    dateAdded = widget.item.dateAdded;
    expiryDate = widget.item.expiryDate;
    quantity = widget.item.quantity;
    price = widget.item.price;
    details = widget.item.details!;
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedItem = InventoryItem(
        name: name,
        image: image,
        dateAdded: dateAdded,
        expiryDate: expiryDate,
        quantity: quantity,
        price: price,
        details: details, category: '',
      );

      Provider.of<InventoryProvider>(context, listen: false)
          .updateItem(widget.item, updatedItem);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                initialValue: image,
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (value) {
                  image = value ?? '';
                },
              ),
              TextFormField(
                initialValue: dateAdded,
                decoration: const InputDecoration(labelText: 'Date Added'),
                onSaved: (value) {
                  dateAdded = value ?? '';
                },
              ),
              TextFormField(
                initialValue: expiryDate,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                onSaved: (value) {
                  expiryDate = value ?? '';
                },
              ),
              TextFormField(
                initialValue: quantity.toString(),
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  quantity = int.tryParse(value!) ?? 0;
                },
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  price = double.tryParse(value!) ?? 0.0;
                },
              ),
              TextFormField(
                initialValue: details,
                decoration: const InputDecoration(labelText: 'Details'),
                onSaved: (value) {
                  details = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

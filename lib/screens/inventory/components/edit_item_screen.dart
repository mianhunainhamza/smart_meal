import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/widgets/custom_button.dart';
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
  String? category;

  @override
  void initState() {
    super.initState();
    name = widget.item.name;
    image = widget.item.image;
    dateAdded = widget.item.dateAdded;
    expiryDate = widget.item.expiryDate;
    quantity = widget.item.quantity;
    price = widget.item.price;
    details = widget.item.details ?? '';
    category = widget.item.category;
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
        details: details,
        category: category ?? '', // Save selected category
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
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              _buildTextField(
                initialValue: name,
                label: 'Item Name',
                icon: Icons.label,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              const SizedBox(height: 30),
              _buildTextField(
                initialValue: image,
                label: 'Image URL',
                icon: Icons.image,
                onSaved: (value) => image = value ?? '',
              ),
              const SizedBox(height: 30),
              _buildDateField(
                label: 'Date Added',
                date: dateAdded,
                onTap: () => _selectDate(context, true),
              ),
              _buildDateField(
                label: 'Expiry Date',
                date: expiryDate,
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                initialValue: quantity.toString(),
                label: 'Quantity',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
                onSaved: (value) => quantity = int.tryParse(value!) ?? 0,
              ),
              const SizedBox(height: 30),
              _buildPriceField(),
              const SizedBox(height: 30),
              _buildCategoryDropdown(), // Add category dropdown
              const SizedBox(height: 30),
              _buildTextField(
                initialValue: details,
                label: 'Details',
                icon: Icons.description,
                onSaved: (value) => details = value ?? '',
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: _saveItem,
               text:  'Save Changes',
                isLoading: false,
                tag: "",backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String initialValue,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }

  Widget _buildDateField({
    required String label,
    required String date,
    required void Function() onTap,
  }) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      subtitle: Text(
        date.isEmpty ? 'Select Date' : date,
        style: TextStyle(color: date.isEmpty ? Colors.grey : Colors.black),
      ),
      trailing: Icon(Icons.calendar_today,
          color: Theme.of(context).colorScheme.primary),
      onTap: onTap,
    );
  }

  Widget _buildPriceField() {
    return Stack(
      children: [
        TextFormField(
          initialValue: price.toString(),
          decoration: InputDecoration(
            labelText: 'Price',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: Text(
                '€',
                style: TextStyle(
                  fontSize: 23,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || double.tryParse(value) == null) {
              return 'Please enter a valid price';
            }
            return null;
          },
          onSaved: (value) => price = double.tryParse(value!) ?? 0.0,
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    final List<String> categories = [
      'Fruits',
      'Vegetables',
      'Dairy',
      'Meat',
      'Bakery',
      'Frozen Foods',
      'Snacks',
      'Beverages',
      'Others',
    ];

    return DropdownButtonFormField<String>(
      value: category,
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          category = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category, color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context, bool isDateAdded) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDateAdded) {
          dateAdded = DateFormat('dd-MM-yyyy').format(picked);
        } else {
          expiryDate = DateFormat('dd-MM-yyyy').format(picked);
        }
      });
    }
  }
}

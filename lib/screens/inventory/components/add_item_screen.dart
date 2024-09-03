import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_meal/widgets/custom_button.dart';
import '../../../models/inventory_item.dart';
import '../../../providers/inventory_provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  AddItemScreenState createState() => AddItemScreenState();
}

class AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');
  String name = '';
  String image = '';
  String dateAdded = '';
  String expiryDate = '';
  int quantity = 0;
  double price = 0.0;
  String details = '';
  String currencySign = '\$';

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
          dateAdded = _dateFormat.format(picked);
        } else {
          expiryDate = _dateFormat.format(picked);
        }
      });
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newItem = InventoryItem(
        name: name,
        image: image.isNotEmpty ? image : 'assets/images/general.png',
        dateAdded: dateAdded,
        expiryDate: expiryDate,
        quantity: quantity,
        price: price,
        details: details,
      );

      Provider.of<InventoryProvider>(context, listen: false).addItem(newItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20,),
              _buildTextField(
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
              _buildTextField(
                label: 'Details',
                icon: Icons.description,
                onSaved: (value) => details = value ?? '',
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: _saveItem,
                text: 'Add Item',
                isLoading: false,
                backgroundColor: Theme.of(context).colorScheme.primary,
                tag: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
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
          decoration: InputDecoration(
            labelText: 'Price',
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currencySign,
                  items: const [
                    DropdownMenuItem(value: '\$', child: Text('\$')),
                    DropdownMenuItem(value: '€', child: Text('€')),
                    DropdownMenuItem(value: '£', child: Text('£')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      currencySign = value!;
                    });
                  },
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
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
}

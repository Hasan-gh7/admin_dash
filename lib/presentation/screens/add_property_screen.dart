import 'package:flutter/material.dart';
import 'package:real_estate_dashboard/data/models/property_model.dart';
import 'package:real_estate_dashboard/data/repositories/property_service.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ownerController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  String _status = 'معروض';

  final _propertyService = PropertyService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final property = PropertyModel(
        id: '', // سيتم توليده من السيرفر
        ownerName: _ownerController.text,
        status: _status,
        address: _addressController.text,
        price: double.parse(_priceController.text),
      );

      try {
        await _propertyService.addProperty(property);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إضافة العقار بنجاح')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة عقار')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // اسم المالك
              TextFormField(
                controller: _ownerController,
                decoration: const InputDecoration(labelText: 'اسم المالك'),
                validator: (value) =>
                    value!.isEmpty ? 'يرجى إدخال اسم المالك' : null,
              ),

              // الحالة
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'حالة العقار'),
                items: const [
                  DropdownMenuItem(value: 'معروض', child: Text('معروض')),
                  DropdownMenuItem(value: 'محجوز', child: Text('محجوز')),
                  DropdownMenuItem(value: 'مؤجر', child: Text('مؤجر')),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),

              // العنوان
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (value) =>
                    value!.isEmpty ? 'يرجى إدخال العنوان' : null,
              ),

              // السعر
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'السعر'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'يرجى إدخال السعر' : null,
              ),

              const SizedBox(height: 24),

              // زر الحفظ
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('حفظ العقار'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class PropertyManagementPage extends StatefulWidget {
  @override
  _PropertyManagementPageState createState() => _PropertyManagementPageState();
}

class _PropertyManagementPageState extends State<PropertyManagementPage> {
  List<Map<String, dynamic>> properties = [
    {
      'name': 'شقة فاخرة',
      'location': 'الرياض',
      'price': 250000,
      'status': 'متاحة',
    },
    {
      'name': 'فيلا راقية',
      'location': 'جدة',
      'price': 750000,
      'status': 'مؤجرة',
    },
  ];

  void _showAddPropertyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('إضافة عقار جديد'),
          content: Text('هنا سيكون النموذج لإضافة العقار'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('إلغاء')),
            ElevatedButton(onPressed: () {}, child: Text('حفظ')),
          ],
        );
      },
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('تأكيد الحذف'),
        content: Text('هل أنت متأكد من حذف هذا العقار؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              setState(() => properties.removeAt(index));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم الحذف بنجاح')));
            },
            child: Text('حذف'),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    return status == 'متاحة' ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إدارة العقارات')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('الاسم')),
            DataColumn(label: Text('الموقع')),
            DataColumn(label: Text('السعر')),
            DataColumn(label: Text('الحالة')),
            DataColumn(label: Text('إجراءات')),
          ],
          rows: List.generate(properties.length, (index) {
            final property = properties[index];
            return DataRow(cells: [
              DataCell(Text(property['name'])),
              DataCell(Text(property['location'])),
              DataCell(Text('${property['price']} ريال')),
              DataCell(Text(
                property['status'],
                style: TextStyle(color: _statusColor(property['status']), fontWeight: FontWeight.bold),
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // تعديل العقار
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(index),
                  ),
                ],
              )),
            ]);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPropertyDialog,
        child: Icon(Icons.add),
        tooltip: 'إضافة عقار',
      ),
    );
  }
}
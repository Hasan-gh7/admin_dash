import 'package:flutter/material.dart';

class BookingManagementPage extends StatefulWidget {
  @override
  _BookingManagementPageState createState() => _BookingManagementPageState();
}

class _BookingManagementPageState extends State<BookingManagementPage> {
  List<Map<String, dynamic>> bookings = [
    {
      'client': 'أحمد',
      'property': 'شقة الرياض',
      'date': '2025-09-01',
      'status': 'قيد الانتظار',
    },
    {
      'client': 'سارة',
      'property': 'فيلا جدة',
      'date': '2025-09-03',
      'status': 'مؤكد',
    },
  ];

  void _showAddBookingDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('إضافة حجز جديد'),
        content: Text('هنا سيكون النموذج لإضافة الحجز'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('إلغاء')),
          ElevatedButton(onPressed: () {}, child: Text('حفظ')),
        ],
      ),
    );
  }

  void _updateStatus(int index, String newStatus) {
    setState(() {
      bookings[index]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تحديث الحالة إلى "$newStatus"')),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'مؤكد':
        return Colors.green;
      case 'ملغي':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إدارة الحجوزات')),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('${booking['client']} - ${booking['property']}'),
              subtitle: Text('📅 ${booking['date']}'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    booking['status'],
                    style: TextStyle(
                      color: _statusColor(booking['status']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () => _updateStatus(index, 'مؤكد'),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => _updateStatus(index, 'ملغي'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookingDialog,
        child: Icon(Icons.add),
        tooltip: 'إضافة حجز',
      ),
    );
  }
}
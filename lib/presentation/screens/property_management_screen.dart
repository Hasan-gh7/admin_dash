import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/data/repositories/property_service.dart';
import '../../logic/blocs/property_bloc/property_bloc.dart';
import '../../logic/blocs/property_bloc/property_event.dart';
import '../../logic/blocs/property_bloc/property_state.dart';
import 'add_property_screen.dart'; 

class PropertyManagementScreen extends StatelessWidget {
  const PropertyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة العقارات')),
      body: BlocProvider(
        create: (context) => PropertyBloc(PropertyService())..add(LoadProperties()),
        child: BlocBuilder<PropertyBloc, PropertyState>(
          builder: (context, state) {
            if (state is PropertiesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PropertiesLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // زر إضافة عقار
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('إضافة عقار'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPropertyScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // جدول العقارات
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 24,
                          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                          columns: const [
                            DataColumn(label: Text('المالك')),
                            DataColumn(label: Text('الحالة')),
                            DataColumn(label: Text('العنوان')),
                            DataColumn(label: Text('السعر')),
                          ],
                          rows: state.properties.map((property) {
                            return DataRow(cells: [
                              DataCell(Text(property.ownerName)),
                              DataCell(Text(property.status)),
                              DataCell(Text(property.address)),
                              DataCell(Text('${property.price} \$')),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PropertiesError) {
              return Center(child: Text('حدث خطأ: ${state.message}'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_estate_dashboard/presentation/screens/add_property_screen.dart';
import 'package:real_estate_dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:real_estate_dashboard/presentation/screens/booking_management_page.dart';
import 'package:real_estate_dashboard/presentation/screens/property_management_screen.dart';
import 'data/services/auth_service.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/user_management_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(AuthService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لوحة تحكم العقارات',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home:  BookingManagementPage() ,
      routes: {
        '/users': (context) => const UserScreen(),
        '/properties': (context) =>  PropertyManagementPage(),
        '/add-property': (context) => const AddPropertyScreen(),
        '/admin_dashboard':(context)=> const AdminDashboardScreen(),
        '/login':(context)=>  LoginScreen() ,
        '/booking':(context)=> BookingManagementPage() ,
      },
    ); 
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:real_estate_dashboard/logic/blocs/stats_bloc/stats_bloc.dart';
// import 'package:real_estate_dashboard/logic/blocs/stats_bloc/stats_event.dart';
// import 'package:real_estate_dashboard/logic/blocs/stats_bloc/stats_state.dart';

// import '../widgets/stat_card.dart';
// import '../widgets/recent_activity_list.dart';
// import '../widgets/admin_sidebar.dart'; // تأكد من استيراد الـ Drawer

// class AdminDashboardScreen extends StatefulWidget {
//   const AdminDashboardScreen({super.key});

//   @override
//   State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
// }

// class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
//   String? token;
//   late StatsBloc statsBloc;

//   @override
//   void initState() {
//     super.initState();
//     _loadToken();
//   }

//   Future<void> _loadToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     final storedToken = prefs.getString('access_token');
//     if (storedToken != null) {
//       setState(() {
//         token = storedToken;
//         statsBloc = StatsBloc(token!)..add(FetchStatsEvent());
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (token == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return BlocProvider.value(
//       value: statsBloc,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("لوحة التحكم"),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.refresh),
//               onPressed: () {
//                 statsBloc.add(FetchStatsEvent());
//               },
//             ),
//           ],
//         ),
//         drawer: const AdminSidebar(), // ✅ إضافة الـ Drawer هنا
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocBuilder<StatsBloc, StatsState>(
//             builder: (context, state) {
//               if (state is StatsLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is StatsError) {
//                 return Center(child: Text(state.message));
//               } else if (state is StatsLoaded) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Wrap(
//                         spacing: 16,
//                         runSpacing: 16,
//                         children: [
//                           StatCard(
//                             title: "عدد العقارات",
//                             value: "${state.propertiesCount}",
//                             icon: Icons.home_work,
//                           ),
//                           StatCard(
//                             title: "عدد المستخدمين",
//                             value: "${state.usersCount}",
//                             icon: Icons.people,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 32),
//                       const Text(
//                         "الأنشطة الأخيرة",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 16),
//                       const RecentActivityList(),
//                     ],
//                   ),
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:real_estate_dashboard/logic/blocs/stats_bloc/stats_bloc.dart';
import 'package:real_estate_dashboard/logic/blocs/stats_bloc/stats_event.dart';
import 'package:real_estate_dashboard/logic/blocs/stats_bloc/stats_state.dart';

import '../widgets/stat_card.dart';
import '../widgets/recent_activity_list.dart';
import '../widgets/admin_sidebar.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = snapshot.data!;
        final statsBloc = StatsBloc(token)..add(FetchStatsEvent());

        return BlocProvider.value(
          value: statsBloc,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("لوحة التحكم"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    statsBloc.add(FetchStatsEvent());
                  },
                ),
              ],
            ),
            drawer: const AdminSidebar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<StatsBloc, StatsState>(
                builder: (context, state) {
                  if (state is StatsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StatsError) {
                    return Center(child: Text(state.message));
                  } else if (state is StatsLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              StatCard(
                                title: "عدد العقارات",
                                value: "${state.propertiesCount}",
                                icon: Icons.home_work,
                              ),
                              StatCard(
                                title: "عدد المستخدمين",
                                value: "${state.usersCount}",
                                icon: Icons.people,
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            "الأنشطة الأخيرة",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          const RecentActivityList(),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
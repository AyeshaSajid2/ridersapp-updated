// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:ridersapp/authentication/auth_screen.dart';
import 'package:ridersapp/global/global.dart';

class HomeScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Card makeDashboardItem(String title, IconData iconData, int index,
      List<Color> gradientColors, List<double> gradientStops) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: gradientStops,
            tileMode: TileMode.clamp,
          ),
        ),
        child: InkWell(
          onTap: () {
            // Handle onTap for each index
            if (index == 0) {
              //New Available Orders
              // Navigator.push(context,
              // MaterialPageRoute(builder: (c) => const NewOrdersScreen()));
            }
            if (index == 1) {
              //Parcels in Progress
            }
            if (index == 2) {
              //Not Yet Delivered
            }
            if (index == 3) {
              //History
            }
            if (index == 4) {
              //Total Earnings
            }
            if (index == 5) {
              //Logout
              firebaseAuth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const AuthScreen()));
              });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50.0),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF56B89F),
                Color(0xFF39F3BB),
                Colors.cyan,
              ],
            ),
          ),
        ),
        title: Text(
          // ignore: prefer_interpolation_to_compose_strings
          "Welcome " + sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontFamily: "Signatra",
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Color(0xFF56B89F),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem(
              "New Available Orders",
              Icons.assignment,
              0,
              [
                const Color(0xFFBE7ACA),
                const Color(0xFF39F3BB),
                const Color(0xFF77B5E9),
                const Color(0xFF5A74C4),
              ],
              [0.0, 0.3, 0.6, 1.0],
            ),
            makeDashboardItem(
              "Parcels in Progress",
              Icons.airport_shuttle,
              1,
              [
                const Color(0xFFBE7ACA),
                const Color(0xFF39F3BB),
                const Color(0xFF77B5E9),
                const Color(0xFF5A74C4),
              ],
              [0.0, 0.3, 0.6, 1.0],
            ),
            makeDashboardItem(
              "Not Yet Delivered",
              Icons.location_history,
              2,
              [
                const Color(0xFFBE7ACA),
                const Color(0xFF77B5E9),
                const Color(0xFF39F3BB),
                const Color(0xFF5A74C4),
              ],
              [0.0, 0.3, 0.7, 1.0],
            ),
            makeDashboardItem(
              "History",
              Icons.done_all,
              3,
              [
                const Color(0xFFBE7ACA),
                const Color(0xFF77B5E9),
                const Color(0xFF39F3BB),
                const Color(0xFF5A74C4),
              ],
              [0.0, 0.3, 0.7, 1.0],
            ),
            makeDashboardItem(
              "Total Earnings",
              Icons.monetization_on,
              4,
              [
                const Color(0xFF39F3BB),
                const Color(0xFFBE7ACA),
                const Color(0xFF77B5E9),
                const Color(0xFF5A74C4),
              ],
              [0.0, 0.3, 0.9, 1.0],
            ),
            makeDashboardItem(
              "Logout",
              Icons.logout,
              5,
              [
                const Color(0xFF39F3BB),
                const Color(0xFFBE7ACA),
                const Color(0xFF77B5E9),
                const Color(0xFF5A74C4),
              ],
              [0.0, 0.3, 0.9, 1.0],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ridersapp/authentication/login.dart';
import 'package:ridersapp/authentication/register.dart';

class AuthScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  Widget _buildTab(String text, int index) {
    return Container(
      width: 120.0, // Adjust the width as needed
      height: 50.0,
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? const Color.fromARGB(202, 14, 206, 46)
            : Colors.transparent,
        // borderRadius: BorderRadius.horizontal(
        //   left: Radius.circular(index == 0 ? 50.0 : 0.0),
        //   right: Radius.circular(index == 1 ? 50.0 : 0.0),
        // ),
        gradient: _selectedIndex == index
            ? const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF56B89F),
                  Color(0xFF39F3BB),
                  Colors.cyan,
                ],
              )
            : null,
      ),
      child: InkWell(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                color: _selectedIndex == index ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 8.0),
              Text(
                text,
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.white : Colors.black,
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
                // Color(0xFF56B89F),
                // Color(0xFF39F3BB),
                // Colors.cyan,
                Color(0xFF574BCD),
                Color(0xFF2999AD),
                Color(0xFF41E975),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "FoodFlow",
          style: TextStyle(
            fontSize: 50,
            color: Colors.black,
            fontFamily: "Signatra",
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: TabBar(
            controller: _tabController,
            tabs: [
              _buildTab("Login", 0),
              _buildTab("Register", 1),
            ],
            indicatorColor: Colors.black,
            indicatorWeight: 6,
            labelColor: Colors.transparent,
            unselectedLabelColor: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.black, Color(0xFF56B89F)],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: const [
            LoginScreen(),
            RegisterScreen(),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Position? position;
List<Placemark>? placeMarks;
String completeAddress="";


//   //const Color(0xFF39F3BB),
//                 const Color.fromARGB(255, 60, 116, 164),
//                 const Color.fromARGB(255, 168, 198, 225),
//                 const Color(0xFF77B5E9),
//                 const Color(0xFF5A74C4),
//               ],
//               [0.0, 0.3, 0.6, 1.0],
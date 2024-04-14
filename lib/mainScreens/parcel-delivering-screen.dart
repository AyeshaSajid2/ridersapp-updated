import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ridersapp/assistantMethods/get_current_location.dart';
import 'package:ridersapp/global/global.dart';
import 'package:ridersapp/maps/map_utils.dart';
import '../splash_screen/splashscreen.dart';
import '../widgets/error_dialog.dart';
import 'home-screen.dart';
// import 'error_dialog.dart'; // Import the ErrorDialog widget

class ParcelDeliveringScreen extends StatefulWidget {
  final String? purchaserId;
  final String? purchaserAddress;
  final double? purchaserLat;
  final double? purchaserLng;
  final String? sellerId;
  final String? getOrderId;

  const ParcelDeliveringScreen({
    Key? key,
    this.purchaserId,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
    this.sellerId,
    this.getOrderId,
  }) : super(key: key);

  @override
  _ParcelDeliveringScreenState createState() =>
      _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen> {
  late String orderTotalAmount = "";
  late String previousEarnings = "";
  late String previousRiderEarnings = "";
  late String perParcelDeliveryAmount = "";
  late String? _currentSellerId;

  @override
  void initState() {
    super.initState();
    UserLocation().getCurrentLocation();
    getOrderTotalAmount();
  }

  Future<void> getOrderTotalAmount() async {
    final orderSnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get();

    setState(() {
      orderTotalAmount =
          orderSnapshot.data()?["totalAmount"]?.toString() ?? "";
      _currentSellerId = orderSnapshot.data()?["sellerUID"]?.toString() ?? "";
    });

    await getSellerData();
  }

  Future<void> getSellerData() async {
    final sellerSnapshot = await FirebaseFirestore.instance
        .collection("sellers")
        .doc(_currentSellerId)
        .get();

    setState(() {
      previousEarnings = sellerSnapshot.data()?["earnings"]?.toString() ?? "";
    });
  }

  void confirmParcelHasBeenDelivered(getOrderId, sellerId, purchaserId,
      purchaserAddress, purchaserLat, purchaserLng) async {
    try {
      await getOrderTotalAmount();

      final riderNewTotalEarningAmount = double.parse(previousRiderEarnings) +
          double.parse(perParcelDeliveryAmount);

      await FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
        "status": "ended",
        "address": purchaserAddress,
        "lat": purchaserLat,
        "lng": purchaserLng,
        "earnings": perParcelDeliveryAmount,
      });

      await FirebaseFirestore.instance.collection("riders").doc(sharedPreferences!.getString("uid") ?? "").update({
        "earnings": riderNewTotalEarningAmount.toString(),
      });

      await FirebaseFirestore.instance.collection("sellers").doc(sellerId).update({
        "earnings":
        (double.parse(orderTotalAmount) + double.parse(previousEarnings))
            .toString(),
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(purchaserId)
          .collection("orders")
          .doc(getOrderId)
          .update({
        "status": "ended",
        "riderUID": sharedPreferences!.getString("uid"),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Completed')),
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(message: error.toString());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/confirm1.png",
            width: 350,
          ),
          const SizedBox(height: 5,),
          GestureDetector(
            onTap: () {
              MapUtils.lauchMapFromSourceToDestination(
                  position!.latitude, position!.longitude, widget.purchaserLat, widget.purchaserLng);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/restaurant.png',
                  width: 50,
                ),
                const SizedBox(width: 7,),
                Column(
                  children: const [
                    SizedBox(height: 12,),
                    Text(
                      "Show user/drop of Location",
                      style: TextStyle(
                        fontFamily: "Signatra",
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: InkWell(
                onTap: () {
                  UserLocation uLocation = UserLocation();
                  uLocation.getCurrentLocation();

                  confirmParcelHasBeenDelivered(
                      widget.getOrderId,
                      _currentSellerId,
                      widget.purchaserId,
                      widget.purchaserAddress,
                      widget.purchaserLat,
                      widget.purchaserLng
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyan,
                          Colors.amber,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      )
                  ),
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Order has been Delivered - Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:ridersapp/global/global.dart';
import 'package:ridersapp/models/address.dart';
import 'package:ridersapp/widgets/progress_bar.dart';
import 'package:ridersapp/widgets/shipment_address_design.dart';
import 'package:ridersapp/widgets/status_banner.dart';
//import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderID;

  // ignore: use_key_in_widget_constructors
  const OrderDetailsScreen({this.orderID});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";
  String orderByUser = "";

  getOrderInfo() {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderID)
        .get()
        .then((DocumentSnapshot) {
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderByUser = DocumentSnapshot.data()!["orderBy"].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    getOrderInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("orders")
              .doc(widget.orderID)
              .get(),
          builder: (c, snapshot) {
            Map? dataMap;
            if (snapshot.hasData) {
              dataMap = snapshot.data!.data()! as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
            }
            return snapshot.hasData
                // ignore: avoid_unnecessary_containers
                ? Container(
                    child: Column(
                      children: [
                        StatusBanner(
                          status: dataMap!["isSuccess"],
                          orderStatus: orderStatus,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              "€  " + dataMap["totalAmount"].toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "Order Id = " + widget.orderID!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     // ignore: prefer_interpolation_to_compose_strings
                        //     "Order at: " +
                        //         DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                        //             DateTime.fromMillisecondsSinceEpoch(
                        //                 int.parse(dataMap["orderTime"]))),
                        //     style: const TextStyle(
                        //         fontSize: 16, color: Colors.grey),
                        //   ),
                        // ),
                        const Divider(
                          thickness: 4,
                        ),
                        orderStatus == "ended"
                            ? Image.asset("images/success.jpg")
                            : Image.asset("images/confirm_pick.png"),
                        const Divider(
                          thickness: 4,
                        ),
                        FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(orderByUser)
                              .collection("userAddress")
                              .doc(dataMap["addressID"])
                              .get(),
                          builder: (c, snapshot) {
                            return snapshot.hasData
                                ? ShipmentAddressDesign(
                                    model: Address.fromJson(snapshot.data!
                                        .data()! as Map<String, dynamic>),
                                    orderStatus: orderStatus,
                                  )
                                : Center(
                                    child: circularProgress(),
                                  );
                          },
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: circularProgress(),
                  );
          },
        ),
      ),
    );
  }
}

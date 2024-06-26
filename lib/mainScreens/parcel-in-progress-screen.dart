import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ridersapp/assistantMethods/assistant_methods.dart';
// import 'package:ridersapp/global/global.dart';
import 'package:ridersapp/widgets/order_card.dart';
import 'package:ridersapp/widgets/progress_bar.dart';
import 'package:ridersapp/widgets/simple_app_bar.dart';


//
// class ParcelInProgressScreen extends StatefulWidget
// {
//   @override
//   _ParcelInProgressScreenState createState() => _ParcelInProgressScreenState();
// }
//
//
//
// class _ParcelInProgressScreenState extends State<ParcelInProgressScreen>
// {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: SimpleAppBar(title: "Parcel In Progress",),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection("orders")
//               .where("riderUID", isEqualTo: sharedPreferences!.getString("uid"))
//               .where("status", isEqualTo: "picking")
//               .snapshots(),
//           builder: (c, snapshot)
//           {
//             return snapshot.hasData
//                 ? ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (c, index)
//               {
//                 return FutureBuilder<QuerySnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection("items")
//                       .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
//                       .orderBy("publishedDate", descending: true)
//                       .get(),
//                   builder: (c, snap)
//                   {
//                     return snap.hasData
//                         ? OrderCard(
//                       itemCount: snap.data!.docs.length,
//                       data: snap.data!.docs,
//                       orderID: snapshot.data!.docs[index].id,
//                       seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
//                     )
//                         : Center(child: circularProgress());
//                   },
//                 );
//               },
//             )
//                 : Center(child: circularProgress(),);
//           },
//         ),
//       ),
//     );
//   }
// }

class ParcelInProgressScreen extends StatefulWidget
{
  @override
  _ParcelInProgressScreenState createState() => _ParcelInProgressScreenState();
}



class _ParcelInProgressScreenState extends State<ParcelInProgressScreen>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar(title: "Parcel In Progress",),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("status", isEqualTo: "picking")
              .orderBy("orderTime", descending: true)
              .snapshots(),
          builder: (c, snapshot)
          {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, index)
              {
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                      .where("orderBy", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, snap)
                  {
                    return snap.hasData
                        ? OrderCard(
                      itemCount: snap.data!.docs.length,
                      data: snap.data!.docs,
                      orderID: snapshot.data!.docs[index].id,
                      seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                    )
                        : Center(child: circularProgress());
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}

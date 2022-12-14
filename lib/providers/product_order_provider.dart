import 'package:food_app/models/order_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/review_cart_model.dart';

class ProductOrderProvider with ChangeNotifier{
  
  
  Future<void> addOrderProduct()async{

    QuerySnapshot allItem = await FirebaseFirestore.instance.collection("ReviewCart").doc(FirebaseAuth.instance.currentUser.uid)
    .collection("YourReviewCart").get();

    allItem.docs.forEach((element) {
      FirebaseFirestore.instance.collection("OrderCart").
      doc(FirebaseAuth.instance.currentUser.uid). 
      collection("allOrders").doc(element.get("cartId")).set({
        "cartId":element.get("cartId"),
         "cartName": element.get("cartName"),
        "cartImage":  element.get("cartImage"),
        "cartPrice": element.get("cartPrice"),
        "cartQuantity": element.get("cartQuantity"),
        "cartUnit": element.get("cartUnit"),
        "cartQuantity": element.get("cartQuantity"),

        "isAdd":true,
        "dateTime":DateTime.now(),
    });
    allItem.docs.forEach((element) {
        FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid).collection("YourReviewCart").doc(element.get("cartId")).delete(); 
    });
    notifyListeners(); 
    });
  }
  
  List<OrderCartModel> get getOrderList => orderList ; 
  Map<String, List<OrderCartModel>> OrderMap = {};
  List<OrderCartModel> orderList = []; 

    
    
    
    // test fetch 
    Future<void> fetchOrderList()async{
    // List<ReviewCartModel> newList = [] ; 
    print("0000000000000000000");
    //  print("fetch order list"); 

      DocumentSnapshot docKey = await FirebaseFirestore.instance.collection("OrderList").
      doc(FirebaseAuth.instance.currentUser.uid).collection("DocKey").doc("DocKey").get();
      List<OrderCartModel> singleOrderList = [];
      Map<String, List<OrderCartModel>> orderListMap = {};
      List<dynamic> val =   docKey.get("list");
      for(int i=0;i<val.length;i++){
      QuerySnapshot allorders = await  FirebaseFirestore.instance.collection("OrderList").doc(FirebaseAuth.instance.currentUser.uid). 
        collection("YourOrder").doc(val[i].toString()).collection(val[i].toString()).get();
          allorders.docs.forEach((element) {
            OrderCartModel data = OrderCartModel(
              cartId: element.get("cartId"),
              cartImage: element.get("cartImage"),
              cartName: element.get("cartName"),
              cartPrice: element.get("cartPrice"),
              cartQuantity: element.get("cartQuantity"),
              cartUnit: element.get("cartUnit"),
              dateTime: element.get("dateTime"),
              totalPrice: element.get("totalPrice"), 
              totalproduct: element.get("totalProduct"), 
            );
            singleOrderList.add(data);
          });// end of foreach
         
        orderListMap.putIfAbsent(val[i].toString(), () {
          return singleOrderList;
        } );
      }// end of for loop
      print("map key");
      orderListMap.forEach((key,value){
        print("map key is ${key}");
        value.forEach((element) {
          
          print(element.cartName);
        });
        print("---------------");
      });




        
        print("xxxxxxxxxxx");
  print("end fetch order list");

  //   orders.docs.forEach((element) {
  //     Timestamp t = element.get("dateTime"); 
  //     DateTime date = t.toDate(); 
      
  //     String DateTimeKey  = date.day.toString() + date.month.toString() + date.year.toString() + date.hour.toString() + date.minute.toString();
  //     print(DateTimeKey);
  //   ReviewCartModel data = ReviewCartModel(
  //     cartId: element.get("cartId"),
  //     cartImage: element.get("cartImage"),
  //     cartName: element.get("cartName"),
  //     cartPrice: element.get("cartPrice"),
  //     cartQuantity: element.get("cartQuantity"),
  //   cartUnit: element.get("cartUnit"),
  //   dateTime: element.get("dateTime"),
  //   // dateTime:  element.get("dateTime"),
  //   );
  //   newList.add(data);
  //   // print("DateTime is here");
  //   // print(data);
  // });

  OrderMap = orderListMap;
  notifyListeners(); 
  }

    addOrderTest()async{
  //  DocumentSnapshot tvalue = await FirebaseFirestore.instance.collection("OrderCart").doc(FirebaseAuth.instance.currentUser.uid).get();
  //  tvalue.get("allOrders");
  //  print( tvalue.get("allOrders").);
  //  print("all test here");
  //  print(tvalue.data());
  List<OrderCartModel> order = []; 
  QuerySnapshot allItem = await FirebaseFirestore.instance.collection("ReviewCart").doc(FirebaseAuth.instance.currentUser.uid)
    .collection("YourReviewCart").get();
  double totalPrice = 0 ;
  int totalProduct = 0 ; 
  allItem.docs.forEach((element) {
    totalPrice += element.get("cartPrice"); 
    totalProduct += element.get("cartQuantity"); 
  });

 
  DateTime dt = DateTime.now(); 
  int day = dt.day;
  int month = dt.month; 
  int year = dt.year ; 
  int hour = dt.hour; 
  int min = dt.minute; 
  String docKey = "${day.toString()}${month.toString()}${year.toString()}${hour.toString()}${min.toString()}";
  String SdocKey = docKey.toString();

  //  await  FirebaseFirestore.instance.collection('DocKeyOfOrder').doc(FirebaseAuth.instance.currentUser.uid).update({
  //         'list': FieldValue.arrayRemove([SdocKey]),
  //       });
  //  await  FirebaseFirestore.instance.collection('OrderList').
  //  doc(FirebaseAuth.instance.currentUser.uid).
  //  collection("DocKey").doc("DocKey").update({
  //         'list': FieldValue.arrayUnion([SdocKey]),
  //       }); 
           await  FirebaseFirestore.instance.collection('OrderList').
   doc(FirebaseAuth.instance.currentUser.uid).
   collection("DocKey").doc("DocKey").update({
          'list': FieldValue.arrayUnion([SdocKey]),
        });
  allItem.docs.forEach((element) {
      FirebaseFirestore.instance.collection("OrderList").
      doc(FirebaseAuth.instance.currentUser.uid). 
      collection("YourOrder").doc(docKey).collection(docKey).doc(element.get("cartId")).set({
        "cartId":element.get("cartId"),
         "cartName": element.get("cartName"),
        "cartImage":  element.get("cartImage"),
        "cartPrice": element.get("cartPrice"),
        "cartQuantity": element.get("cartQuantity"),
        "cartUnit": element.get("cartUnit"),
        "isAdd":true,
        "totalPrice" : totalPrice, 
        "totalProduct" : totalProduct, 
        "dateTime":DateTime.now(),
    });
    allItem.docs.forEach((element) {
        FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid).collection("YourReviewCart").doc(element.get("cartId")).delete(); 
    });

    // FirebaseFirestore.instance.collection("OrderList").
    //   doc(FirebaseAuth.instance.currentUser.uid). 

    notifyListeners(); 
    });

  }
}
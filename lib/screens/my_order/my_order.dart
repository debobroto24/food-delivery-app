import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/product_order_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/check_out/delivery_details/delivery_details.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatelessWidget {
  ReviewCartProvider reviewCartProvider;
  ProductOrderProvider productOrderProvider; 
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    productOrderProvider = Provider.of<ProductOrderProvider>(context);
    reviewCartProvider.getReviewCartData();
    productOrderProvider.fetchOrderList();
    // productOrderProvider.addOrderTest();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Order",
//           style: TextStyle(color: textColor, fontSize: 18),
//         ),
//       ),
//       body: productOrderProvider.getOrderList.isEmpty
//           ? Center(
//               child: Text("You don't have any order"),
//             )
//           : ListView.builder(
//               itemCount: productOrderProvider.getOrderList.length,
//               itemBuilder: (context, index) {
//                 ReviewCartModel data =
//                     productOrderProvider.getOrderList[index];
//                 // return Column(
//                 //   children: [
//                 //     SizedBox(
//                 //       height: 10,
//                 //     ),
//                 //     SingleItem(
//                 //       isBool: true,
//                 //       wishList: false,
//                 //       productImage: data.cartImage,
//                 //       productName: data.cartName,
//                 //       productPrice: data.cartPrice,
//                 //       productId: data.cartId,
//                 //       productQuantity: data.cartQuantity,
//                 //       productUnit: data.cartUnit,
//                 //       onDelete: () {
//                 //         showAlertDialog(context, data);
//                 //       },
//                 //     ),
//                 //   ],
//                 // );
//  Timestamp t = data.dateTime; 
//       DateTime date = t.toDate(); 
//       // Text("${date.day}/${date.month}/${date.year}");
//        bool isbig; 
//        String firstHalf; 
    
//      if(data.cartName.length > 15){
//       firstHalf =data.cartName.substring(0,15); 
//       isbig = true ; 
//     }else{ 
//       firstHalf =data.cartName; 
//         isbig = false ; 
//     }
//                 return Container(
//                   padding: EdgeInsets.only(top:20),
//                   child: SingleChildScrollView(
//                     child: Row(  
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
                          
//                           margin:EdgeInsets.only(left:10,right:10), 
//                           child:Row(  
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 // color:Colors.red,
//                                 // width:double.infinity, 
//                                 height: 90, 
//                                 child: Center(child: Image.network(data.cartImage , height: 90, width:100,fit:BoxFit.cover),),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(left:10),
//                                 child: Column(  
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text( isbig?firstHalf+ "...":firstHalf ?? "...",maxLines: 1,),
//                                       SizedBox(height:5),  
//                                     Text("${data.cartPrice.toString()} ৳" ?? ""), 
//                                     SizedBox(height:5), 
//                                     // Text(data.cartUnit ?? 0),                                   
//                                     // Text(data.dateTime.toString()), 
//                                      Text("${date.day}/${date.month}/${date.year}"),
//                                   ],
//                                 )
//                               ),
//                             ],
//                           )
//                         ),
//                         // right side 
//                         // Wrap(children: [Text(data.dateTime.toString() ?? "")]),
                      
//                         Container(
//                           margin:EdgeInsets.only(right:15), 
//                           child:Column(  
//                             children: [
//                               Text("Total"), 
//                               Text(data.cartQuantity.toString() ?? "",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
//                             ],
//                           )

//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
  return Scaffold(body: Center(child: Text("Empty"),));
  }
}

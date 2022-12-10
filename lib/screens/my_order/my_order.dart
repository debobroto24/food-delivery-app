import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/check_out/delivery_details/delivery_details.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class MyOrder extends StatelessWidget {
  ReviewCartProvider reviewCartProvider;
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
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Order",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Text("NO DATA"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getReviewCartDataList[index];
                // return Column(
                //   children: [
                //     SizedBox(
                //       height: 10,
                //     ),
                //     SingleItem(
                //       isBool: true,
                //       wishList: false,
                //       productImage: data.cartImage,
                //       productName: data.cartName,
                //       productPrice: data.cartPrice,
                //       productId: data.cartId,
                //       productQuantity: data.cartQuantity,
                //       productUnit: data.cartUnit,
                //       onDelete: () {
                //         showAlertDialog(context, data);
                //       },
                //     ),
                //   ],
                // );

                return Container(
                  padding: EdgeInsets.only(top:20),
                  child: SingleChildScrollView(
                    child: Row(  
                      children: [
                        Container(
                          
                          margin:EdgeInsets.only(left:10,right:10), 
                          child:Row(  
                            children: [
                              Container(
                                height: 90, 
                                child: Center(child: Image.network(data.cartImage),),
                              ),
                              Container(
                                margin: EdgeInsets.only(left:10),
                                child: Column(  
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data.cartPrice}" ?? ""), 
                                    SizedBox(height:10), 
                                    Text(data.cartUnit ?? 0),
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                        // right side 
                        // Wrap(children: [Text(data.dateTime.toString() ?? "")]),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

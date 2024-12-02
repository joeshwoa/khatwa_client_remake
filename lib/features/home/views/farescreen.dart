import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:khatwa_client/old_core/widgets/snack_bar_widget.dart';
import '../../../old_core/contants/api.dart';
import '../../../old_core/functions/global_function.dart';
import '../../../old_core/functions/ratingdriver.dart';
import '../../../old_core/services/cache_storage_services.dart';

class FareScreen extends StatelessWidget {
  final String id;
  final String fare;
  final bool isLast;
  const FareScreen(  {super.key, required this.id, required this.fare,required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Center(
            child: Text(
              "المبلغ المطلوب دفعة= ${fare} جنية",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),

          if(isLast)
          ElevatedButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              var couponController=TextEditingController();
              return Dialog(

                child: Center(
                  child: Container(
                    height: 250,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: couponController,

                          ),
                        ),
                        ElevatedButton(onPressed: () {

                          print(CacheStorageServices().token);

                          post(Uri.parse("${baseUri}coupons/apply/${couponController.text}"),
                              headers: authHeadersWithToken(CacheStorageServices().token),
                              body: jsonEncode({}),)
                              .then((response) {
                                print (response.body);
                                Navigator.pop(context);
                                if(response.statusCode==400)
                                showSnackBarWidget(context: context, requestStates:RequestStates.error,message: jsonDecode(response.body)?['message'] );
                                else
                                  showSnackBarWidget(context: context, requestStates:RequestStates.success,message: jsonDecode(response.body)?['message'] );



                          });


                        }, child: Text('تطبيق الرمز الترويجي',style: TextStyle(color: Colors.deepOrange),)),
                      ],
                    ),
                  ),
                ),
              );
            },);
          }, child: Text('اضافة رمز ترويجي',style: TextStyle(color: Colors.deepOrange),)),

          SizedBox(height: 20,),

          if(isLast)
          ElevatedButton(onPressed: () {
            showDialog(context: context, builder: (context) {
              var couponController=TextEditingController();
              return Dialog(

                child: Center(
                  child: ElevatedButton(onPressed: () {

                    print(CacheStorageServices().token);

                    read(Uri.parse("${baseUri}user/payWithWallet"),
                      headers: authHeadersWithToken(CacheStorageServices().token),)
                        .then((response) {
                      print (response);
                      Navigator.pop(context);
                        showSnackBarWidget(context: context, requestStates:RequestStates.info,message: response );



                    });


                  }, child: Text('تأكيد الدفع عن طريق المحفظة',style: TextStyle(color: Colors.deepOrange),)),
                ),
              );
            },);
          }, child: Text('الدفع بواسطة المحفظة',style: TextStyle(color: Colors.deepOrange),)),


          Expanded(
            child: SizedBox(),
          ),
          MaterialButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              navigateTo(RatingScreen(id: id));
            },
            child: const Text(
              "تقييم السائق",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

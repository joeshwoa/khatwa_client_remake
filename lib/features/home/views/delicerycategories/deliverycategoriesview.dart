import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../old_core/class/statusrequst.dart';
import '../../../../old_core/contants/api.dart';
import '../../../../old_core/functions/global_function.dart';
import '../../../../old_core/rescourcs/app_colors.dart';
import '../driversforcategories/driversforcategoriesview.dart';
import 'deliverycategoriescontroller.dart';

class DeliveryCategories extends StatelessWidget {
  final double lat;
  final double long;
  const DeliveryCategories({super.key, required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    print("del lat $lat");
    print("del lat $long");
    DeliveryCategoriesController deliveryCategoriesController =
        Get.put(DeliveryCategoriesController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final childAspectRatio = (screenWidth / 1.2) / (screenHeight / 3);
    return Scaffold(
      appBar: AppBar(
        title: Text("توصيل"),
        centerTitle: true,
      ),
      body: GetBuilder<DeliveryCategoriesController>(
        builder: (controller){
          if(controller.statusRequest==StatusRequest.loading){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }else if(controller.categories.isEmpty){
            return Center(
              child: Text("لا يوجد بيانات الان",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true, // Add this line
                  physics: NeverScrollableScrollPhysics(), // Add this line
                  itemCount: controller.categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        //send category id
                        print(controller.categories[index]['_id']);
                        navigateTo(DriversForCategories(
                          id:controller.categories[index]['_id'] ,
                          lat:lat ,
                          long: long,
                        ));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "${baseUri}images/${controller.categories[index]['image']}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            "${controller.categories[index]['name']}",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " جنيهات ${controller.categories[index]['commission']}",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                " : العمولة",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "جنية ${controller.categories[index]['delivery_fee']?? "5"}",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                " : سعر التوصيل",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

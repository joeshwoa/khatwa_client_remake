

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Feather/Home/presentation/cubit/home_cubit.dart';
import 'package:khatwa_client/Feather/Home/presentation/cubit/home_states.dart';

class ChooseCategoriesScreen extends StatefulWidget {
  const ChooseCategoriesScreen({super.key});

  @override
  State<ChooseCategoriesScreen> createState() => _ChooseCategoriesScreenState();
}

class _ChooseCategoriesScreenState extends State<ChooseCategoriesScreen> {

  @override
  void initState() {
    print('choose cat screeeeeeeeeeen');
    HomeCubit.get(context).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is GetCategoriesSuccess,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height*0.3,
                color: Colors.white,
                child: Column(

                  children: [

                    SizedBox(height: 5),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "المركبات",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: ColorData.primaryColor,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            ListView.builder(
                              shrinkWrap: true, // Add this line
                              physics:
                              NeverScrollableScrollPhysics(), // Add this line
                              itemCount: HomeCubit.get(context).categoriesModel.categories?.length,

                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //send category id


                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
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
                                              HomeCubit.get(context).categoriesModel.categories![index].image??'',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "${HomeCubit.get(context).categoriesModel.categories?[index].name}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),








                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   child: Text(
                            //     "Delivery",
                            //     style: TextStyle(
                            //       fontSize: 25,
                            //       color: ColorData.primaryColor,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 5),
                            // InkWell(
                            //   onTap: () {
                            //     //nav to delivery categories
                            //     // navigateTo(DeliveryCategories(
                            //     //   lat: HomeCubit.get(context).categoriesModel.position!.latitude,
                            //     //   long: HomeCubit.get(context).categoriesModel.position!.longitude,
                            //     // ));
                            //   },
                            //   child: Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           height: 70,
                            //           width: 80,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //           ),
                            //           child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(20),
                            //             child: Image.asset(
                            //               "assets/deliveryboy.png",
                            //               fit: BoxFit.fill,
                            //             ),
                            //           ),
                            //         ),
                            //         Text(
                            //           "Delivery",
                            //           style: TextStyle(
                            //             color: ColorData.primaryColor,
                            //             fontWeight: FontWeight.bold,
                            //             fontSize: 15,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 50),




                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            fallback:(context) =>  CircularProgressIndicator(),
        );


      },
    );
  }
}

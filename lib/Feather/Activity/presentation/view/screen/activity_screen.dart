import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/activity_cubit.dart';
import '../../cubit/activity_states.dart';

class ActivityView extends StatefulWidget {
  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {


  @override
  void initState() {

    ActivityCubit.get(context).getClientTrips();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit,ActivityState>(
     builder: (context, state) {
       return SingleChildScrollView(
         child: Column(
           children: [
             // Profile Header Section

           ],
         ),
       );
     },

    );


  }
}

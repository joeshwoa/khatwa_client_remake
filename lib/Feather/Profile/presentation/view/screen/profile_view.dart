import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khatwa_client/Core/helper/loading_custom.dart';
import 'package:khatwa_client/Core/unit/color_data.dart';
import 'package:khatwa_client/Feather/Layout/presentation/cubit/layout_cubit.dart';
import 'package:khatwa_client/Feather/Profile/presentation/cubit/profile_cubit.dart';
import 'package:khatwa_client/Feather/Profile/presentation/cubit/profile_states.dart';
import 'package:khatwa_client/Feather/Profile/presentation/view/widget/change_name_bottom_sheet_custom.dart';
import 'package:khatwa_client/Feather/Profile/presentation/view/widget/change_phone_bottom_sheet_custom.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  late final ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProfileCubit.get(context);
    cubit.getClientProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
     builder: (context, state) {
       return state is GetClientProfileLoading ? Center(child: LoadingCustom(),) : SingleChildScrollView(
         child: Column(
           children: [
             Stack(
               alignment: Alignment.bottomCenter,
               children: [
                 Column(
                   children: [
                     Container(
                       height: 120,
                       decoration: BoxDecoration(
                         color: ColorData.primary50Color,
                         borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(20),
                             bottomLeft: Radius.circular(20)),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.shade300,
                             spreadRadius: 1,
                             blurRadius: 10,
                             offset: Offset(0, 5),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       height: 100,
                       color: Colors.transparent,
                     )
                   ],
                 ),
                 Column(
                   children: [
                     SizedBox(height: 10),

                     Stack(
                       alignment: Alignment.bottomRight,
                       children: [

                         Stack(
                           alignment: Alignment.center,
                           children: [
                             CircleAvatar(
                               radius: 60,
                               backgroundColor: ColorData.primary75Color,
                             ),
                             CircleAvatar(
                               radius: 55,
                               backgroundImage:
                               NetworkImage(cubit.clientProfileModel?.image??'',),
                               // Replace with real image URL
                             ),
                           ],
                         ),

                         InkWell(
                           onTap: () {
                             cubit.updateAvatar();
                           },
                           child: CircleAvatar(
                             //backgroundColor: AppColors.primaryColor,
                             child: Icon(
                               Icons.edit,
                               color: ColorData.blackColor.withOpacity(.7),
                             ),
                           ),
                         ),
                       ],
                     ),
                     SizedBox(height: 8),
                     Text(
                       '${cubit.clientProfileModel?.name}',
                       style: TextStyle(
                         fontSize: 22,
                         fontWeight: FontWeight.bold,
                         color: Colors.white,
                       ),
                     ),
                     SizedBox(height: 10),
                   ],
                 ),
               ],
             ),
             SizedBox(height: 10),

             // Account Info Section
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Container(
                 padding: EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.shade300,
                       spreadRadius: 1,
                       blurRadius: 10,
                       offset: Offset(0, 5),
                     ),
                   ],
                 ),
                 child: Column(
                   children: [
                     AccountInfoTile(
                       icon: Icons.person,
                       label: '${cubit.clientProfileModel?.name}',
                       onPressed: () {
                         LayoutCubit.get(context).showBottomSheet(context: context, builder: (context) => ChangeNameBottomSheetCustom());
                       },
                       editable: true,
                     ),
                     Divider(),
                     AccountInfoTile(
                       icon: Icons.phone,
                       label: '${cubit.clientProfileModel?.phone}',
                       onPressed: () {
                         LayoutCubit.get(context).showBottomSheet(context: context, builder: (context) => ChangePhoneBottomSheetCustom());
                       },
                       editable: true,
                     ),
                     Divider(),
                     AccountInfoTile(
                       icon: Icons.attach_money_rounded,
                       label: '${cubit.clientProfileModel?.wallet}',
                       onPressed: () {},
                       editable: false,
                     ),
                   ],
                 ),
               ),
             ),
             SizedBox(height: 20),

             // Change Password and Saved Places
             // OptionTile(
             //   label: 'Change Password',
             //   onTap: (){},
             // ),
             //
             // OptionTile(
             //   label: 'Saved Places',
             //   onTap: (){},
             // ),

             // Delete Account Button
             Padding(
               padding: const EdgeInsets.only(bottom: 20.0),
               child: TextButton.icon(
                 onPressed: () {
                   // Handle account deletion
                 },
                 icon: Icon(Icons.logout, color: Colors.red),
                 label: Text(
                   'تسجيل الخروج',
                   style: TextStyle(color: Colors.red, fontSize: 16),
                 ),
               ),
             ),
           ],
         ),
       );
     },

    );



  }
}

class AccountInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  bool editable = true;
  AccountInfoTile(
      {required this.icon,
      required this.label,
      required this.onPressed,
      required this.editable});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
        ),
        Visibility(
          visible: editable,
          replacement: Container(
            height: 40,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.edit, color: Colors.grey[600]),
          ),
        )
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  final String label;
  Function onTap;

  OptionTile({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ListTile(
          title: Text(label,
              style: TextStyle(fontSize: 16, color: Colors.grey[800])),
          trailing:
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
          onTap: () => onTap,
        ),
      ),
    );
  }
}

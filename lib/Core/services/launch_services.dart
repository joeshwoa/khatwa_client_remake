
import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

launchLink(String uri)async{
  try{
    await launchUrl(Uri.parse(uri));
  }catch(e){
    log(e.toString());
  }
}

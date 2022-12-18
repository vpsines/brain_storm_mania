import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomZoomDrawerController extends GetxController{
  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer(){
    zoomDrawerController.toggle?.call();
    update();
  }

  void signIn(){

  }

  void signOut(){

  }

  void sendEmail(){
    final Uri emailUri = Uri(scheme: 'mailTo',path: 'vpsines1001@gmail.com');
    _launch(emailUri.path);
  }

  void launchWebsite(){

  }

  Future<void> _launch(String url) async{
    if(await launch(url)){
      throw 'could not launch $url';
    }
  }
}
import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxService{


  Future<String?> getImage(String? imageName) async{
    if(imageName == null){
      return null;
    }
    try{
      final urlRef = firebaseStorage.child("question_paper_images").child('${imageName!.toLowerCase()}.png');
      final imageUrl = await urlRef.getDownloadURL();
      return imageUrl;
    }catch(e){
      return null;
    }
  }
}
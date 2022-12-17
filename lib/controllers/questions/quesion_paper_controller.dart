import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:brain_storm_mania/models/question_paper_model.dart';
import 'package:brain_storm_mania/services/firebase_storage_service.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperController extends GetxController{

  final paperImages =<String>[].obs;
  final papers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getImages();
    super.onReady();
  }

  List<String> imageNames = ["biology","physics","chemistry","maths"];


  Future<void> getImages() async{
    try{
      QuerySnapshot<Map<String,dynamic>> data = await questionPaperRef.get();
      final paperList = data.docs.map((e) => QuestionPaperModel.fromSnapshot(e)).toList();
      papers.assignAll(paperList);

      for(var paper in paperList){
        final imageUrl = await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imageUrl;
      }
      papers.assignAll(paperList);
    }catch(e){
      print(e);
    }
  }
}
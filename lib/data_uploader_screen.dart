import 'package:brain_storm_mania/controllers/questions/data_uploader.dart';
import 'package:brain_storm_mania/firebase_ref/loading_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? "Upload Completed"
                : "Uploading")),
      ),
    );
  }
}

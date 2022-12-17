import 'package:brain_storm_mania/configs/themes/app_light_theme.dart';
import 'package:brain_storm_mania/models/question_paper_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPaperCard extends StatelessWidget {
  const QuestionPaperCard({Key? key, required this.questionPaperModel})
      : super(key: key);

  final QuestionPaperModel questionPaperModel;

  @override
  Widget build(BuildContext context) {
    double _padding = 10.0;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(_padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ColoredBox(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  child: SizedBox(
                    width: Get.width * 0.15,
                    height: Get.width * 0.15,
                    child: CachedNetworkImage(
                      imageUrl: questionPaperModel.imageUrl!,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/app_splash_logo.png"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(questionPaperModel.title),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Text(questionPaperModel.description),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

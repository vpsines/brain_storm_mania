import 'package:brain_storm_mania/configs/themes/app_icons.dart';
import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/models/question_paper_model.dart';
import 'package:brain_storm_mania/widgets/app_icon_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPaperCard extends StatelessWidget {
  const QuestionPaperCard({Key? key, required this.questionPaperModel})
      : super(key: key);

  final QuestionPaperModel questionPaperModel;

  @override
  Widget build(BuildContext context) {
    double _padding = 10.0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: Padding(
        padding: EdgeInsets.all(_padding),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                      Text(
                        questionPaperModel.title,
                        style: cardTitles(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Text(questionPaperModel.description),
                      ),
                      Row(
                        children: [
                          AppIconText(
                            icon: Icon(
                              Icons.help_outline_sharp,
                              color: UIParameters.isDarkMode()
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            text: Text(
                              '${questionPaperModel.questionCount} questions',
                              style: detailText.copyWith(
                                  color: UIParameters.isDarkMode()
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          AppIconText(
                            icon: Icon(
                              Icons.timer,
                              color: UIParameters.isDarkMode()
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            text: Text(
                              questionPaperModel.timeInMinutes(),
                              style: detailText.copyWith(
                                  color: UIParameters.isDarkMode()
                                      ? Colors.white
                                      : Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                bottom: -_padding,
                right: -_padding,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(cardBorderRadius),
                            bottomRight: Radius.circular(cardBorderRadius))),
                    child: const Icon(
                      AppIcons.trophyOutline,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

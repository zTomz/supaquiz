import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../provider/quiz_provider.dart';
import '../widgets/done_image.dart';
import '../widgets/result_box.dart';

@RoutePage()
class QuizEndPage extends StatelessWidget {
  const QuizEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kLargePadding),
        child: Column(
          children: [
            const Spacer(),
            const DoneImage(),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text(
                "You finished ${quizProvider.quizInfo.name == 'Random' ? 'a random' : 'the ${quizProvider.quizInfo.name}'} quiz!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: kHugePadding,
              runSpacing: kDefaultPadding,
              children: [
                ResultBox(
                  value: "${quizProvider.quizInfo.correct}",
                  title: "Correct",
                  color: AppColors.blue,
                ),
                ResultBox(
                  value: "${quizProvider.quizInfo.incorrect}",
                  title: "Incorrect",
                  color: AppColors.red,
                ),
                ResultBox(
                  value:
                      "${quizProvider.quizInfo.time?.elapsed.inMinutes.toString().padLeft(2, '0')}:${quizProvider.quizInfo.time?.elapsed.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                  title: "Time",
                  color: AppColors.green,
                ),
                ResultBox(
                  value: "${quizProvider.quizInfo.skipped}",
                  title: "Skipped",
                  color: AppColors.red,
                ),
                ResultBox(
                  value: "${quizProvider.quizInfo.totalPoints}",
                  title: "Total Points",
                  color: AppColors.primary,
                ),
              ],
            ),
            const Spacer(),
            CustomElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Done",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              onPressed: () async {
                await context.read<QuizProvider>().uploadQuizToDatabase(
                      quiz: quizProvider.quiz!,
                    );

                if (context.mounted) {
                  await context.read<QuizProvider>().updatePoints(
                        offsetPoints: quizProvider.quizInfo.totalPoints,
                      );
                }

                if (context.mounted) {
                  context.router.push(
                    const SkeletonRoute(),
                  );
                }
              },
            ),
            const SizedBox(height: kLargeSpacing),
          ],
        ),
      ),
    );
  }
}

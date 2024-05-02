import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../../core/utils/functions/calculate_max_width.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../provider/quiz_provider.dart';
import '../widgets/answer_container.dart';
import '../widgets/info_box.dart';

@RoutePage()
class QuizPage extends HookWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    if (quizProvider.quizInfo.currentQuestion >=
        (quizProvider.quiz?.questions.length ?? 0)) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final selectedAnswer = useState<String>('');

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: calculateMaxWidth(context),
            padding: const EdgeInsets.symmetric(horizontal: kLargePadding),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kLargePadding),
                  child: Text(
                    "${quizProvider.quizInfo.name} Quiz",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoBox(
                      child: Text(
                        "${quizProvider.quizInfo.currentQuestion + 1} / ${quizProvider.quiz?.questions.length}",
                      ),
                    ),
                    InfoBox(
                      child: Text(
                        "${quizProvider.quiz?.questions[quizProvider.quizInfo.currentQuestion].difficulty.name}",
                      ),
                    ),
                    InfoBox(
                      child: Text(
                        "Points: ${quizProvider.quizInfo.totalPoints}",
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kHugePadding),
                  child: Text(
                    "${quizProvider.quiz?.questions[quizProvider.quizInfo.currentQuestion].question}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                ...quizProvider.quiz!
                    .questions[quizProvider.quizInfo.currentQuestion].answers!
                    .map(
                  (answer) => Padding(
                    padding: const EdgeInsets.only(bottom: kDefaultPadding),
                    child: AnswerContainer(
                      answer: answer,
                      selectedAnswer: selectedAnswer.value,
                      setSelectedAnswer: () {
                        selectedAnswer.value = answer;
                      },
                    ),
                  ),
                ),
                const Spacer(),
                CustomElevatedButton(
                  onPressed: () async {
                    if (selectedAnswer.value.isEmpty) {
                      return;
                    }

                    final currentInfo = quizProvider.quizInfo;

                    final isCorrect = selectedAnswer.value.substring(4) ==
                        quizProvider
                            .quiz
                            ?.questions[quizProvider.quizInfo.currentQuestion]
                            .correctAnswer;

                    context.read<QuizProvider>().updateQuizInfo(
                          currentQuestion: currentInfo.currentQuestion + 1,
                          correct: isCorrect
                              ? currentInfo.correct + 1
                              : currentInfo.correct,
                          incorrect: !isCorrect
                              ? currentInfo.incorrect + 1
                              : currentInfo.incorrect,
                          totalPoints: isCorrect
                              ? currentInfo.totalPoints + 2
                              : currentInfo.totalPoints - 1,
                        );

                    selectedAnswer.value = '';

                    // If we are at the last question, go to the end route
                    if (context.read<QuizProvider>().quizInfo.currentQuestion >=
                        quizProvider.quiz!.questions.length) {
                      // Stop timer
                      context.read<QuizProvider>().quizInfo.time?.stop();

                      // Navigate to end route
                      await context.replaceRoute(const QuizEndRoute());
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                CustomElevatedButton(
                  onPressed: () async {
                    final currentInfo = quizProvider.quizInfo;

                    context.read<QuizProvider>().updateQuizInfo(
                          currentQuestion: currentInfo.currentQuestion + 1,
                          skipped: currentInfo.skipped + 1,
                        );

                    selectedAnswer.value = '';

                    // If we are at the last question, go to the end route
                    if (context.read<QuizProvider>().quizInfo.currentQuestion >=
                        quizProvider.quiz!.questions.length) {
                      // Stop timer
                      context.read<QuizProvider>().quizInfo.time?.stop();

                      // Navigate to end route
                      await context.replaceRoute(const QuizEndRoute());
                    }
                  },
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Skip",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(height: kLargeSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../core/config/router/app_router.dart';
import '../../../core/config/utils/constants/colors.dart';
import '../../../core/config/utils/constants/numbers.dart';
import '../../quiz/data/enums/quiz_categories.dart';
import '../../quiz/data/enums/quiz_difficulty.dart';
import '../../quiz/data/enums/quiz_type.dart';
import '../../quiz/data/params/quiz_params.dart';
import '../../quiz/presentation/provider/quiz_provider.dart';
import '../../../core/config/utils/widgets/custom_elevated_button.dart';

class CreateNewQuizDialog extends HookWidget {
  const CreateNewQuizDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final quizType = useState<QuizType?>(null);
    final quizDifficulty = useState<QuizDifficulty?>(null);
    final quizCategory = useState<QuizCategory?>(null);
    final number = useState<int>(10);

    return AlertDialog(
      title: const Text("Create a quiz"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Quiz Type:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          SegmentedButton<QuizType?>(
            segments: [
              const ButtonSegment(
                value: null,
                label: Text('Any'),
              ),
              ...QuizType.values.map(
                (value) => ButtonSegment(
                  value: value,
                  label: Text(value.name),
                ),
              ),
            ],
            onSelectionChanged: (newValue) {
              quizType.value = newValue.first;
            },
            selected: {
              quizType.value,
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Quiz Category:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton<QuizCategory?>(
              underline: const SizedBox.shrink(),
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Any'),
                ),
                ...QuizCategory.values.map(
                  (e) => DropdownMenuItem<QuizCategory?>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
              ],
              onChanged: (newValue) => quizCategory.value = newValue,
              value: quizCategory.value,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Quiz Difficulty:",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton<QuizDifficulty?>(
              underline: const SizedBox.shrink(),
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Any'),
                ),
                ...QuizDifficulty.values.map(
                  (e) => DropdownMenuItem<QuizDifficulty?>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
              ],
              onChanged: (newValue) => quizDifficulty.value = newValue,
              value: quizDifficulty.value,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Number: ${number.value}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          Slider(
            value: number.value.toDouble(),
            onChanged: (value) {
              number.value = value.toInt();
            },
            min: 1,
            max: 50,
            divisions: 50,
          ),
        ],
      ),
      actions: [
        CustomElevatedButton(
          color: AppColors.red,
          onTap: () async {
            await context.router.maybePop();
          },
          child: const Text(
            "Close",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomElevatedButton(
          onTap: () async {
            await context.read<QuizProvider>().eitherFailureOrQuiz(
                  params: QuizParams(
                    number: number.value,
                    type: quizType.value,
                    category: quizCategory.value,
                    difficulty: quizDifficulty.value,
                  ),
                );

            if (context.mounted) {
              context.read<QuizProvider>().updateQuizInfo(
                    name: quizCategory.value?.name ?? "Random",
                  );

              await context.router.maybePop().then(
                    (value) async => await context.router.push(
                      const QuizRoute(),
                    ),
                  );
            }
          },
          child: const Text(
            "Create",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

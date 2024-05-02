import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/router/app_router.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/numbers.dart';
import '../../../quiz/presentation/provider/quiz_provider.dart';
import '../../data/models/public_quiz_model.dart';

class PublicQuizListView extends StatelessWidget {
  final List<PublicQuizModel> quizzes;

  const PublicQuizListView({
    super.key,
    required this.quizzes,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];

          return PublicQuizListTile(quiz: quiz);
        },
      ),
    );
  }
}

class PublicQuizListTile extends StatelessWidget {
  final PublicQuizModel quiz;

  const PublicQuizListTile({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(quiz.name),
      subtitle: Wrap(
        spacing: 10,
        children: [
          Text(
            "Score: ${quiz.totalPoints}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Correct: ${quiz.correct}",
            style: const TextStyle(color: AppColors.green),
          ),
          Text(
            "Incorrect: ${quiz.incorrect}",
            style: const TextStyle(color: AppColors.red),
          ),
          Text(
            "Skipped: ${quiz.skipped}",
            style: const TextStyle(color: AppColors.blue),
          ),
        ],
      ),
      leading: const Icon(Icons.quiz_outlined),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Do you want to start the quiz: ${quiz.name}?"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Start"),
                onPressed: () {
                  Navigator.of(context).pop();

                  // Update the quiz provider
                  context.read<QuizProvider>().setQuiz(
                        quiz.quiz,
                        name: quiz.name,
                      );

                  context.pushRoute(const QuizRoute());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

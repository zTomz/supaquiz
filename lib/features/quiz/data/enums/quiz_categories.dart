
import '../../../../core/utils/errors/exeptions.dart';

enum QuizCategory {
  generalKnowledge('General Knowledge', '9'),
  books('Books', '10'),
  film('Film', '11'),
  music('Music', '12'),
  musicalsAndTheatres('Musicals & Theatres', '13'),
  television('Television', '14'),
  videoGames('Video Games', '15'),
  boardGames('Board Games', '16'),
  scienceAndNature('Science & Nature', '17'),
  computers('Computers', '18'),
  mathematics('Mathematics', '19'),
  mythology('Mythology', '20'),
  sports('Sports', '21'),
  geography('Geography', '22'),
  history('History', '23'),
  politics('Politics', '24'),
  art('Art', '25'),
  celebrities('Celebrities', '26'),
  animals('Animals', '27'),
  vehicles('Vehicles', '28'),
  entertainmentComics('Comics', '29'),
  scienceGadgets('Gadgets', '30'),
  japaneseAnimeAndManga('Japanese Anime & Manga', '31'),
  cartoonAndAnimations('Cartoon & Animations', '32');

  const QuizCategory(
    this.name,
    this.value,
  );

  /// Used in the UI
  final String name;

  /// Used in the api call
  final String value;

  factory QuizCategory.fromValue(String value) {
    for (final category in values) {
      if (category.name ==
          value
              .replaceAll(
                'Entertainment: ',
                '',
              )
              .replaceAll(
                'Science: ',
                '',
              )) {
        return category;
      }
    }

    throw NoEnumFieldFoundException('Unknown category: $value');
  }

  factory QuizCategory.fromId(String id) {
    for (final category in values) {
      if (category.value == id) {
        return category;
      }
    }

    throw NoEnumFieldFoundException('Unknown id: $id');

  }
}

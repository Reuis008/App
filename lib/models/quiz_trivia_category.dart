class QuizTriviaCategory {
  String imageUrl;
  String name;
  String value;
  String totalQuestions;
  String type;
  String url;
  String startColor;
  String endColor;
  List<String> metawords;

  QuizTriviaCategory({
    required this.imageUrl,
    required this.name,
    required this.value,
    required this.totalQuestions,
    required this.type,
    required this.url,
    required this.startColor,
    required this.endColor,
    required this.metawords,
  });

  static List<QuizTriviaCategory> quizTriviaList = <QuizTriviaCategory>[
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/brain_quiz.svg',
      name: "Brain Teasers",
      value: 'brain-teasers',
      totalQuestions: '286',
      type: 'widget',
      url: '',
      startColor: '#000428',
      endColor: '#004E92',
      metawords: <String>['286 Questions', 'Puzzles,Riddles'],
    ),
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/general_quiz.svg',
      name: "General Knowledge",
      value: 'general',
      totalQuestions: '2960',
      type: 'widget',
      url: '',
      startColor: '#093028',
      endColor: '#237A57',
      metawords: <String>['2960 Questions', 'All Subjects, Global GK'],
    ),
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/animal_quiz.svg',
      name: "Animal",
      value: 'animals',
      totalQuestions: '1014',
      type: 'widget',
      url: '',
      startColor: '#642B73',
      endColor: '#C6426E',
      metawords: <String>['1014 Questions', 'Reptiles, Birds, Mammals'],
    ),
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/geography_quiz.svg',
      name: "Geography",
      value: 'geography',
      totalQuestions: '771',
      type: 'widget',
      url: '',
      startColor: '#BA8B02',
      endColor: '#181818',
      metawords: <String>['771 Questions', 'World Geography'],
    ),
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/science_quiz.svg',
      name: "Science & Technology",
      value: 'science-technology',
      totalQuestions: '2106',
      type: 'widget',
      url: '',
      startColor: '#333333',
      endColor: '#DD1818',
      metawords: <String>[
        '2106 Questions',
        'Biology, Chemistry, Physics, Maths'
      ],
    ),
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/history_quiz.svg',
      name: "History",
      value: 'history',
      totalQuestions: '1432',
      type: 'widget',
      url: '',
      startColor: '#C02425',
      endColor: '#ED8F03',
      metawords: <String>['1432 Questions', 'World History'],
    ),
    QuizTriviaCategory(
      imageUrl: 'assets/img/quiz/humanities_quiz.svg',
      name: "Humanities",
      value: 'humanities',
      totalQuestions: '938',
      type: 'widget',
      url: '',
      startColor: '#23074D',
      endColor: '#CC5333',
      metawords: <String>[
        '938 Questions',
        'Art, Literature,Philisophy, Anthropology'
      ],
    ),
  ];
}

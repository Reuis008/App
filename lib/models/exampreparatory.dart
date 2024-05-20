class ExamPreparatory {
  String? imageUrl;
  String? name;
  String? value;
  String? type;
  String? url;
  String? startColor;
  String? endColor;
  List<String>? metawords;

  ExamPreparatory({
    this.imageUrl,
    this.name,
    this.value,
    this.type,
    this.url,
    this.startColor,
    this.endColor,
    this.metawords,
  });

  static List<ExamPreparatory> examPreparatoryList = <ExamPreparatory>[
    ExamPreparatory(
      imageUrl: 'assets/img/exampreparatory/mock_test.svg',
      name: "NEET Mock Tests",
      value: 'AIPMT',
      type: 'widget',
      url: '',
      startColor: '#1E130C',
      endColor: '#9A8478',
      metawords: <String>['Biology,', 'Chemistry,', 'Physics'],
    ),
    ExamPreparatory(
      imageUrl: 'assets/img/exampreparatory/mock_test.svg',
      name: "JEE Mock Tests",
      value: 'JEE',
      type: 'widget',
      url: '',
      startColor: '#2C3E50',
      endColor: '#2980B9',
      metawords: <String>['Mathematics,', 'Chemistry,', 'Physics'],
    ),
    ExamPreparatory(
      imageUrl: 'assets/img/exampreparatory/questionbank.svg',
      name: "MBOSE Question Bank",
      value: 'MBOSE',
      type: 'widget',
      url: '',
      startColor: '#16222A',
      endColor: '#3A6073',
      metawords: <String>['Year wise', 'Question Papers', 'All Subjects'],
    ),
    ExamPreparatory(
      imageUrl: 'assets/img/exampreparatory/questionbank.svg',
      name: "CBSE Question Bank",
      value: 'NCERT',
      type: 'widget',
      url: '',
      startColor: '#141E30',
      endColor: '#243B55',
      metawords: <String>['Year wise', 'Question Papers', 'All Subjects'],
    ),
    ExamPreparatory(
      imageUrl: 'assets/img/exampreparatory/questionbank.svg',
      name: "JEE Question Bank",
      value: 'JEEQB',
      type: 'widget',
      url: '',
      startColor: '#0083B0',
      endColor: '#00B4DB',
      metawords: <String>[
        'Questions with year',
        'Answers in last pages',
        'As per JEE Syllabus'
      ],
    ),
    ExamPreparatory(
      imageUrl: 'assets/img/exampreparatory/questionbank.svg',
      name: "NEET Question Bank",
      value: 'NEETQB',
      type: 'widget',
      url: '',
      startColor: '#3C1053',
      endColor: '#AD5389',
      metawords: <String>[
        'Questions with year',
        'Answers in last pages',
        'As per NEET Syllabus'
      ],
    ),
  ];
}

class StudyMaterials {
  String imageUrl;
  String name;
  String value;
  String type;
  String url;
  String startColor;
  String endColor;
  List<String> metawords;

  StudyMaterials({
    required this.imageUrl,
    required this.name,
    required this.value,
    required this.type,
    required this.url,
    required this.startColor,
    required this.endColor,
    required this.metawords,
  });

  static List<StudyMaterials> studyMaterialsList = <StudyMaterials>[
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/referenceBooks.svg',
      name: "Reference Books",
      value: 'NCERT',
      type: 'widget',
      url: '',
      startColor: '#e57373',
      endColor: '#ef5350',
      metawords: <String>['NCERT Hyperlink,', 'Requires Internet,'],
    ),
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/jeeneetBooks.svg',
      name: "JEE Books",
      value: 'JEE',
      type: 'widget',
      url: '',
      startColor: '#f06292',
      endColor: '#ec407a',
      metawords: <String>['Detailed Explanation', 'As per JEE syllabus'],
    ),
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/jeeneetVideos.svg',
      name: "JEE Videos",
      value: 'JEEVid',
      type: 'widget',
      url: '',
      startColor: '#ba68c8',
      endColor: '#ab47bc',
      metawords: <String>['Detailed Explanation', 'As per JEE syllabus'],
    ),
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/jeeneetBooks.svg',
      name: "NEET Books",
      value: 'NEET',
      type: 'widget',
      url: '',
      startColor: '#9575cd',
      endColor: '#7e57c2',
      metawords: <String>['Detailed Explanation', 'As per NEET syllabus'],
    ),
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/jeeneetVideos.svg',
      name: "NEET Videos",
      value: 'NEETVid',
      type: 'widget',
      url: '',
      startColor: '#7986cb',
      endColor: '#5c6bc0',
      metawords: <String>['Detailed Explanation,', 'As per NEET syllabus'],
    ),
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/math_formulae.svg',
      name: "Maths Formulae - I",
      value: 'FormulaeHandbook1',
      type: 'widget',
      url: '',
      startColor: '#4db6ac',
      endColor: '#26a69a',
      metawords: <String>['Important Formulae', 'For Classes IX-X'],
    ),
    StudyMaterials(
      imageUrl: 'assets/img/study_materials/math_formulae.svg',
      name: "Maths Formulae - II",
      value: 'FormulaeHandbook2',
      type: 'widget',
      url: '',
      startColor: '#90a4ae',
      endColor: '#78909c',
      metawords: <String>['Important Formulae', 'For Classes XI-XII'],
    ),
  ];
}

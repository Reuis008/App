import 'dart:async';
// import 'dart:convert';
import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'models/courses.dart';
import 'models/subjects.dart';
// import 'models/units.dart';
import 'models/chapters.dart';
import 'models/topics.dart';
import 'models/exampreparatoryquiz.dart';
import 'models/exampreparartory_questions.dart';
import 'models/assessmentquiz.dart';
import 'models/assessment_questions.dart';
// import 'models/reference_books.dart';
import 'models/question_bank.dart';
import 'models/study_materials_neet_jee.dart';
import 'models/question_bank_neet_jee.dart';
import 'models/videos_neet_jee.dart';
import 'models/videos_category_neet_jee.dart';
import 'models/videos_subject_neet_jee.dart';
import 'models/quiz_trivia.dart';
import 'models/historypedia.dart';

class appDBFunctions {
  static Database? db;
  static const courseTable = 'course';
  static const subjectTable = 'subject';
  static const courseName = 'coursename';
  //static const chaptersTable = 'chapters';
  static const topicsTable = 'topic';

  static const courseID = 'courseid';
  static const board = 'board';
  static const standard = 'standard';
  static const stream = 'stream';
  static const selected = 'selected';

  static const subjectID = 'subjectid';
  static const subjectName = 'subjectname';
  static const totalChapters = 'totalChapters';
  static const totalContents = 'totalContents';
  static const totalVideos = 'totalVideos';
  static const totalBooks = 'totalBooks';

  static const unitNo = 'unitno';
  static const unitName = 'unitname';

  static const chapterNo = 'chapterno';
  static const chapterName = 'chaptername';
  static const chapterVideos = 'chapterVideos';

  static const topicID = 'topicid';
  static const topicNo = 'topicorder';
  static const topicName = 'topicname';
  static const type = 'doctype';
  static const path = 'datapath';
  static const metaData = 'metadata';

  static const exampreparatoryID = 'exampreparatoryid';
  static const examType = 'examtype';
  static const quizName = 'quizname';
  static const quizSet = 'quizset';
  static const totalQuestions = 'totalquestions';
  static const totalMarks = 'totalmarks';
  static const level = 'level';
  static const timeLength = 'timelength';

  static const questionID = 'questionid';
  static const questionNo = 'questionno';
  static const mark = 'mark';
  static const question = 'question';
  static const optionA = 'optiona';
  static const optionAType = 'optionatype';
  static const optionAImg = 'optionaimg';
  static const optionB = 'optionb';
  static const optionBType = 'optionbtype';
  static const optionBImg = 'optionbimg';
  static const optionC = 'optionc';
  static const optionCType = 'optionctype';
  static const optionCImg = 'optioncimg';
  static const optionD = 'optiond';
  static const optionDType = 'optiondtype';
  static const optionDImg = 'optiondimg';
  static const answer = 'answer';
  static const hint = 'hint';
  static const solution = 'solution';
  static const diagram = 'diagram';
  static const solutionType = 'solutiontype';
  static const diagramType = 'diagramtype';

  static const classTestID = 'classtestid';

  static const ID = 'id';
  static const category = 'category';
  static const documentName = 'documentname';
  static const documentPath = 'documentpath';

  static const year = 'year';

  static List<VideosNEETJEE>? NEETJEEvideos;
  // static List<Map<String, dynamic>>? chapterNames;
  // static List<Map<String, dynamic>>? unitNames;

  static const correctAnswer = 'correctanswer';

  static const date = 'date';
  static const description = 'description';
  static const category1 = 'category1';
  static const category2 = 'category2';

  static bool _dbInitialized = false;
  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>>? selectQueryResult,
      int? insertAndUpdateQueryResult]) {
    // print(functionName);
    // print(sql);
    if (selectQueryResult != null) {
      // print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      // print(insertAndUpdateQueryResult);
    }
  }

  Future<void> _initilizeDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'lms_mobile.db');
    db = await openDatabase(databasePath);
    _dbInitialized = true;
  }

  Future<List<Course>> getAllCourses() async {
    if (!_dbInitialized) await _initilizeDB();

    var dbClient = db;
    final results = await dbClient?.rawQuery(
        "select * from course where standard <> '09' and standard <> '10' order by standard");
    //final results = await dbClient.rawQuery("select * from course order by standard");
    List<Course> courses = [];
    for (final row in results ?? []) {
      final course = Course.fromJson(row);
      courses.add(course);
    }
    return courses;
  }

  Future<Course> getSelectedCourse() async {
    if (!_dbInitialized) await _initilizeDB();

    var dbClient = db;
    final results =
        await dbClient?.rawQuery("select * from course where selected = 1");
    final courses = Course.fromJson(results!.first);
    return courses;
  }

  Future<int> updateCourse(courseID) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    if (dbClient != null) {
      await dbClient.rawUpdate('update course set selected=0');
      return await dbClient.rawUpdate(
        'update course set selected=1 where courseid = ?',
        [courseID],
      );
    } else {
      // Handle the case where dbClient is null
      // For example, you could throw an exception or return a default value
      throw Exception('Database client is null');
    }
  }

////////////////////Subject Start ///////////////////

  Future<List<Subject>> getAllSubjects(selectedCourseID) async {
    if (!_dbInitialized) await _initilizeDB();

    var dbClient = db;

    final results = await dbClient?.rawQuery('''
        select x1.*, cast(count(distinct x2.chaptername) as text) as totalChapters, cast(count( distinct x2.topicID) as text) as totalContents,
        cast((select count(*) from nicedata where dataid like x1.subjectid || '%' and doctype like '%mp4') as text) as totalVideos,
        cast((select count(*) from nicedata where dataid like x1.subjectid || '%' and doctype like '%pdf') as text) as totalBooks
        from subject x1
        left join topic x2 on x1.subjectID=x2.subjectID
        where x1.courseID = "$selectedCourseID" group by x1.subjectID order by x1.subjectName
        ''');
    List<Subject> subjects = [];

    for (final row in results ?? []) {
      final subject = Subject.fromJson(row);
      subjects.add(subject);
    }

    return subjects;
  }

  // Future<List<Unit>> getUnits(subjectID) async {
  //   print('subjectID $subjectID');
  //   if (!_dbInitialized) await _initilizeDB();
  //   var dbClient = await db;
  //   final results = await dbClient?.rawQuery('''
  //       select unitno, unitname from topic where subjectid = "${subjectID}" group by unitname order by unitno
  //       ''');
  //   List<Unit> units = [];
  //   for (final row in results ?? []) {
  //     print('row $row');
  //     final unit = Unit.fromJson(row);
  //     units.add(unit);
  //   }
  //   // print('units $units');
  //   return units;
  // }

  Future<List<Chapter>> getChapters(subjectID) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select courseid, subjectid, unitno, unitname, chapterno, chaptername from topic where subjectid =? group by chaptername order by cast(unitno as int), cast(chapterno as int)
        ''', [subjectID]);
    List<Chapter> chapters = [];
    for (final row in results ?? []) {
      final chapter = Chapter.fromJson(row);
      chapters.add(chapter);
    }
    return chapters;
  }

  Future<List<Topic>> getTopics(
      selectedSubject, selectedunitNo, selectedchapterNo) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select x1.*, x2.doctype, x2.datapath from topic x1
        inner join nicedata x2 on x2.dataid=x1.dataid
        where x1.subjectid = "$selectedSubject" and x1.unitno= "$selectedunitNo" and x1.chapterno= "$selectedchapterNo" and x2.doctype="video/mp4" order by x1.topicorder
        ''');
    List<Topic> topics = [];
    for (final row in results ?? []) {
      final topic = Topic.fromJson(row);
      topics.add(topic);
    }
    return topics;
  }

  Future<List<Topic>> getPDFTopics(
      selectedSubject, selectedunitNo, selectedchapterNo) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select x1.*, x2.doctype, x2.datapath from topic x1
        inner join nicedata x2 on x2.dataid=x1.dataid
        where x1.subjectid = "$selectedSubject" and x1.unitno= "$selectedunitNo" and x1.chapterno= "$selectedchapterNo" and x2.doctype="application/pdf" order by x1.topicorder
        ''');
    List<Topic> topics = [];
    for (final row in results ?? []) {
      final topic = Topic.fromJson(row);
      topics.add(topic);
    }

    return topics;
  }

////////////////////Subject end ///////////////////

////////////////////Assessment Quiz Start ///////////////////
  Future<List<Assessment>> getAssessmentQuiz(
      selectedSubjectID, selectedChapterName) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery(
      '''
        select x1.*, x2.subjectname from classtests x1
        inner join subject x2 on x2.subjectid=x1.subjectid
         where x1.subjectid = ? and x1.chaptername = ? order by x1.quizset
        ''',
      [selectedSubjectID, selectedChapterName],
    );
    List<Assessment> quizes = [];
    for (final row in results ?? []) {
      final quiz = Assessment.fromJson(row);
      quizes.add(quiz);
    }

    return quizes;
  }

  Future<List<AssessmentQuestions>> getAssessmentQuizQuestions(
      selectedAssessmentQuizID) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select cast(questionid as text) as questionid, classtestid, questionno, mark, question, optiona, optionb, optionc, optiond, answer, hint, solution, diagram from classtests_questions
         where classtestid = ? order by CAST(questionno AS INTEGER)
        ''', [selectedAssessmentQuizID]);
    List<AssessmentQuestions> questions = [];
    for (final row in results ?? []) {
      final question = AssessmentQuestions.fromJson(row);
      questions.add(question);
    }
    return questions;
  }

////////////////////Assessment Quiz end ///////////////////

////////////////////Exampreparatory  Start ///////////////////

  Future<List<Exampreparatory>> getExampreparatoryQuiz(examType) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select x1.*, x2.subjectname from exampreparatoryquiz x1
        inner join subject x2 on x2.subjectid=x1.subjectid
         where x1.examtype = "$examType" order by LENGTH(x1.quizname), x1.quizname
        ''');
    List<Exampreparatory> quizes = [];
    for (final row in results ?? []) {
      final quiz = Exampreparatory.fromJson(row);
      quizes.add(quiz);
    }
    return quizes;
  }

  Future<List<ExampreparatoryQuestions>> getExampreparatoryQuizQuestions(
      exampreparatoryID) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select cast(questionid as text) as questionid, exampreparatoryid, questionno, mark, question, optiona, optionatype, optionaimg, optionb, optionbtype, optionbimg, optionc, optionctype, optioncimg, optiond, optiondtype, optiondimg, answer, hint, solution, diagram, solutiontype, diagramtype from exampreparatory_questions
         where exampreparatoryid = "$exampreparatoryID" order by CAST(questionno AS INTEGER)
        ''');
    List<ExampreparatoryQuestions> questions = [];
    for (final row in results ?? []) {
      final question = ExampreparatoryQuestions.fromJson(row);
      questions.add(question);
    }
    return questions;
  }

  // Future<List<ReferenceBooks>> getReferenceBooks(selectedClass) async {
  //   if (!_dbInitialized) await this._initilizeDB();
  //   var dbClient = await db;
  //   final results = await dbClient.rawQuery('''
  //       select cast(id as text) as id, category, courseid, subjectname, documentname, documentpath from reference_books  where courseid like "%${selectedClass}" order by subjectname, LENGTH(subjectname)
  //       ''');
  //   List<ReferenceBooks> referenceBooks = List();
  //   for (final row in results) {
  //     final referenceBook = ReferenceBooks.fromJson(row);
  //     referenceBooks.add(referenceBook);
  //   }
  //   return referenceBooks;
  // }

  Future<List<QuestionBank>> getQuestionBank(selectedBoardType) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select cast(id as text) as id, category, year, courseid, documentname, documentpath from question_bank
         where category = "$selectedBoardType" order by cast(year as int), documentname, LENGTH(documentname)
        ''');
    List<QuestionBank> questionBank = [];
    for (final row in results ?? []) {
      final questionPaper = QuestionBank.fromJson(row);
      questionBank.add(questionPaper);
    }
    return questionBank;
  }

  Future<List<QuestionBankNEETJEE>> getQuestionBankNEETJEE(
      selectedCourse, selectedCategory) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select cast(id as text) as id, category,courseid, subjectname, chaptername, documentname, documentpath from neet_jee_question_bank  where category like "$selectedCategory" and courseid="$selectedCourse" order by chaptername
        ''');
    List<QuestionBankNEETJEE> neetJeeQuestionBankList = [];
    for (final row in results ?? []) {
      final neetJeeQuestionBank = QuestionBankNEETJEE.fromJson(row);
      neetJeeQuestionBankList.add(neetJeeQuestionBank);
    }
    return neetJeeQuestionBankList;
  }

////////////////////Exampreparatory  end ///////////////////

////////////////////StudyMaterial  Start ///////////////////

  Future<List<StudyMaterialsNeetJee>> getStudyMaterialsNEETJEE(
      selectedCategory) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select cast(id as text) as id, category, subjectname, documentname, documentpath from study_materials  where category like "$selectedCategory" order by documentname
        ''');
    List<StudyMaterialsNeetJee> booksList = [];
    for (final row in results ?? []) {
      final book = StudyMaterialsNeetJee.fromJson(row);
      booksList.add(book);
    }
    return booksList;
  }

  Future<List<VideosSubjectNEETJEE>> getVideosSubjectUnitsNEETJEE() async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient!.rawQuery('''
        select x1.subjectname from jee_neet_video_maping x1 group by x1.subjectname
        ''');
    List<VideosSubjectNEETJEE> subjectUnits = [];
    for (final row in results) {
      final results2 = await dbClient.rawQuery('''
        select x1.chaptername as unitname from jee_neet_video_maping x1
        where x1.subjectname=?
        group by x1.chaptername
      ''', [row['subjectname']]);
      List<VideosCategoryNEETJEE> units = [];
      for (final row2 in results2) {
        final results3 = await dbClient.rawQuery(
          '''
          select x1.topicname as chaptername from jee_neet_video_maping x1
          where x1.subjectname= ? and x1.chaptername= ?
          group by x1.topicname
        ''',
          [row['subjectname'], row2['unitname']],
        );
        List<String> chapters = [];
        for (final row3 in results3) {
          chapters.add(row3['chaptername'] as String);
        }
        //Map<String, dynamic> unit={'unitname': row2["unitname"], 'chapters': chapters};
        final unit = VideosCategoryNEETJEE.fromJson(row2, chapters);
        units.add(unit);
      }
      final subjectUnit = VideosSubjectNEETJEE.fromJson(row, units);
      subjectUnits.add(subjectUnit);
    }
    return subjectUnits;
  }

  Future<List<VideosNEETJEE>> getNEETJEETopics(
      selectedSubject, selectedUnit, selectedChapter) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select distinct x2.topicname, x3.datapath, x2.metadata from jee_neet_video_maping x1
        inner join topic x2 on x2.topicid=x1.topicid
        inner join nicedata x3 on x3.dataid=x2.dataid
        where x1.subjectname = ? and x1.chaptername= ? and x1.topicname= ? and x3.doctype="video/mp4" order by x2.topicorder
        ''', [selectedSubject, selectedUnit, selectedChapter]);
    List<VideosNEETJEE> topics = [];
    for (final row in results ?? []) {
      final topic = VideosNEETJEE.fromJson(row);
      topics.add(topic);
    }
    return topics;
  }

////////////////////StudyMaterial  End ///////////////////

////////////////////Search  Start ///////////////////

  Future<List<Topic>> getSearchedVideoTopics(
      searchString, selectedCourse) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select x1.*, x2.doctype, x2.datapath, x3.subjectname from topic x1
        inner join nicedata x2 on x2.dataid=x1.dataid
        inner join subject x3 on x3.subjectid=x1.subjectid
        where x1.courseid=$selectedCourse and x1.topicname LIKE %$searchString% and x2.doctype="video/mp4" order by subjectID
        ''');
    List<Topic> topics = [];
    for (final row in results ?? []) {
      final topic = Topic.fromJson(row);
      topics.add(topic);
    }
    return topics;
  }

  Future<List<StudyMaterialsNeetJee>> getSearchedBookTopics(
      searchString) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
        select cast(id as text) as id, category, subjectname, documentname, documentpath from study_materials  where documentname like "%$searchString%" group by documentname order by documentname
        ''');
    List<StudyMaterialsNeetJee> booksList = [];
    for (final row in results ?? []) {
      final book = StudyMaterialsNeetJee.fromJson(row);
      booksList.add(book);
    }
    return booksList;
  }

  ////////////////////Search  end ///////////////////

  ////////////////////QuizTrivia  start ///////////////////

  Future<List<QuizTrivia>> getQuizTriviaQuestions(
      currentCategory, currentSet) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    int startingLimit = currentSet * 10;
    final results = await dbClient?.rawQuery('''
        select cast(id as text) as id, category, question, correctAnswer, optiona, optionb, optionc, optiond from quiz_trivia a where category = "$currentCategory" order by id limit $startingLimit, 10
        ''');
    List<QuizTrivia> questionList = [];
    int rowNum = 1;
    for (final row in results ?? []) {
      final question = QuizTrivia.fromJson(row, rowNum.toString());
      questionList.add(question);
      rowNum++;
    }

    return questionList;
  }

  ////////////////////QuizTrivia  end ///////////////////

  ////////////////////Historypedia  start ///////////////////

  Future<List<SearchHistorypedia>> getSearchedHistorypedia(searchString,
      {int limit = 20, int offset = 0}) async {
    if (!_dbInitialized) await _initilizeDB();
    var dbClient = db;
    final results = await dbClient?.rawQuery('''
      SELECT date, description, category1, category2 FROM world_history 
      WHERE description LIKE "%$searchString%" 
      ORDER BY date 
      LIMIT ? OFFSET ?
      ''', [limit, offset]);
    List<SearchHistorypedia> eventList = [];
    for (final row in results ?? []) {
      final event = SearchHistorypedia.fromJson(row);
      eventList.add(event);
    }
    return eventList;
  }

  ////////////////////Historypedia  end ///////////////////
}

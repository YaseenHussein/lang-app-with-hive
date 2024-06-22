class WordModel {
  final String text;
  final int indexAtDatabase;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  const WordModel({
    required this.text,
    required this.indexAtDatabase,
    required this.isArabic,
    required this.colorCode,
    this.arabicSimilarWords = const [],
    this.englishSimilarWords = const [],
    this.arabicExamples = const [],
    this.englishExamples = const [],
  });

  WordModel decrementIndexAtDatabase() {
    return WordModel(
      text: text,
      indexAtDatabase: indexAtDatabase - 1,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      arabicSimilarWords: arabicSimilarWords,
      englishExamples: englishExamples,
      englishSimilarWords: englishSimilarWords,
    );
  }

  WordModel addSimilarWord(
      {required String similarWord, required bool isArabicSimilarWord}) {
    List<String> newSimilarWords =
        _checkSimilarWordIsArabic(isArabicSimilarWord);

    newSimilarWords.add(similarWord);
    return _getSimilarWordModel(isArabicSimilarWord, newSimilarWords);
  }

  WordModel deleteSimilarWord(
      {required int indexAtSimilarWord, required bool isArabicSimilarWord}) {
    List<String> newSimilarWords =
        _checkSimilarWordIsArabic(isArabicSimilarWord);

    newSimilarWords.removeAt(indexAtSimilarWord);
    return _getSimilarWordModel(isArabicSimilarWord, newSimilarWords);
  }

  WordModel _getSimilarWordModel(
      bool isArabicSimilarWord, List<String> newSimilarWords) {
    return WordModel(
      text: text,
      indexAtDatabase: indexAtDatabase,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
    );
  }

  List<String> _checkSimilarWordIsArabic(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWords);
      // newSimilarWords = [...arabicSimilarWords];
    } else {
      return List.from(englishSimilarWords);
    }
  }

  WordModel addExample(
      {required String example, required bool isArabicExample}) {
    List<String> newExamples = _checkExampleIsArabic(isArabicExample);

    newExamples.add(example);
    return _getSimilarWordModel(isArabicExample, newExamples);
  }

  WordModel deleteExample(
      {required int indexAtExampleWord, required bool isArabicExample}) {
    List<String> newExamples = _checkExampleIsArabic(isArabicExample);

    newExamples.removeAt(indexAtExampleWord);
    return _getExampleWordModel(isArabicExample, newExamples);
  }

  WordModel _getExampleWordModel(
      bool isArabicExample, List<String> newExamples) {
    return WordModel(
      text: text,
      indexAtDatabase: indexAtDatabase,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: isArabicExample ? newExamples : arabicExamples,
      englishExamples: !isArabicExample ? newExamples : englishExamples,
    );
  }

  List<String> _checkExampleIsArabic(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExamples);
      // newSimilarWords = [...arabicSimilarWords];
    } else {
      return List.from(englishExamples);
    }
  }
}

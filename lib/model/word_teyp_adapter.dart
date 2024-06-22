import 'package:hive/hive.dart';
import 'package:learn_lang_app/model/word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
      text: reader.readString(),
      indexAtDatabase: reader.readInt(),
      isArabic: reader.readBool(),
      colorCode: reader.readInt(),
      arabicExamples: reader.readStringList(),
      arabicSimilarWords: reader.readStringList(),
      englishExamples: reader.readStringList(),
      englishSimilarWords: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeString(obj.text);
    writer.writeInt(obj.indexAtDatabase);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.colorCode);
    writer.writeStringList(obj.arabicExamples);
    writer.writeStringList(obj.arabicSimilarWords);
    writer.writeStringList(obj.englishExamples);
    writer.writeStringList(obj.englishSimilarWords);
  }
}

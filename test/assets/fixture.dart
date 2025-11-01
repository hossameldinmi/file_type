import 'package:cross_file/cross_file.dart';

class Fixture {
  static const pathes = Pathes();
  static final sample_image = XFile(pathes.sample_image);
  static final sample_video = XFile(pathes.sample_video);
  static final sample_audio = XFile(pathes.sample_audio);
  static final sample_document = XFile(pathes.sample_document);
  static final sample_unknown_file = XFile(pathes.sample_unknown_file);
}

class Pathes {
  final sample_image = 'test/assets/sample_image.jpg';
  final sample_video = 'test/assets/sample_video.mp4';
  final sample_audio = 'test/assets/sample_audio.mp3';
  final sample_document = 'test/assets/sample_document.pdf';
  final sample_unknown_file = 'test/assets/sample_unknown_file.sh';
  const Pathes();
}

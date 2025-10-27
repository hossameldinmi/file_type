import 'package:mime/src/default_extension_map.dart' show defaultExtensionMap;

class ExtensionsGrouping {
  static final categorizedExtensions = _group(defaultExtensionMap);

  static Map<String, Map<String, String>> _group(Map<String, String> extensionMap) {
    final categorized = Map<String, Map<String, String>>.fromEntries(
      _groups.map((filter) => MapEntry(filter.name, <String, String>{})),
    );

    extensionMap.forEach((extension, mime) {
      for (var filter in _groups) {
        if (filter.test(extension, mime)) {
          categorized[filter.name]![extension] = mime;
          return;
        }
      }
    });

    return categorized;
  }

  static final Iterable<ExtensionGroupFilter> _groups = [
    ExtensionGroupFilter.image,
    ExtensionGroupFilter.audio,
    ExtensionGroupFilter.video,
    ExtensionGroupFilter.document,
    ExtensionGroupFilter.html,
    ExtensionGroupFilter.archive,

    /// keep it last element, to catch all others
    ExtensionGroupFilter.other,
  ];
}

class ExtensionGroupFilter {
  final String name;
  final bool Function(String extension, String mime) test;

  ExtensionGroupFilter(this.name, this.test);

  static final image = ExtensionGroupFilter('image', _isImage);
  static final audio = ExtensionGroupFilter('audio', _isAudio);
  static final video = ExtensionGroupFilter('video', _isVideo);
  static final document = ExtensionGroupFilter('document', _isDocument);
  static final html = ExtensionGroupFilter('html', _isHtml);
  static final archive = ExtensionGroupFilter('archive', _isArchive);
  static final other = ExtensionGroupFilter('other', (extension, mime) => true);

  static bool _isImage(String extension, String mime) => mime.startsWith('image/');
  static bool _isAudio(String extension, String mime) => mime.startsWith('audio/');
  static bool _isVideo(String extension, String mime) => mime.startsWith('video/') || extension.contains('m3u8');
  static bool _isDocument(String extension, String mime) =>
      mime.startsWith('application/pdf') ||
      mime.startsWith('application/msword') ||
      mime.startsWith('application/vnd.openxmlformats-officedocument') ||
      mime.startsWith('application/vnd.ms-excel') ||
      mime.startsWith('application/vnd.ms-powerpoint') ||
      mime.startsWith('text/plain') ||
      mime.startsWith('application/rtf') ||
      mime.startsWith('application/vnd.oasis.opendocument') ||
      mime.startsWith('text/markdown') ||
      mime.startsWith('application/epub+zip') ||
      mime.startsWith('application/x-mobipocket-ebook') ||
      mime.startsWith('application/x-fictionbook+xml') ||
      mime.startsWith('application/x-abiword');

  static bool _isHtml(String extension, String mime) =>
      mime.startsWith('text/html') ||
      mime.startsWith('application/xhtml') ||
      mime == 'text/uri-list' ||
      extension == 'html' ||
      extension == 'htm' ||
      extension == 'xhtml' ||
      extension == 'xht';

  static bool _isArchive(String extension, String mime) =>
      mime.contains('zip') ||
      mime.contains('rar') ||
      mime.contains('tar') ||
      mime.contains('gzip') ||
      mime.contains('bzip') ||
      mime.contains('7z') ||
      mime.contains('xz') ||
      mime.contains('stuffit') ||
      mime.contains('arj') ||
      mime.contains('cab') ||
      mime.contains('lzh') ||
      mime.contains('ace') ||
      mime.contains('arc') ||
      mime.contains('zmachine');
}

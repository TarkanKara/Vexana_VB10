// ignore_for_file: constant_identifier_names

enum NetworkPath { COMMENTS }

extension NetworkPathExtension on NetworkPath {
  String get rawValue {
    switch (this) {
      case NetworkPath.COMMENTS:
        return "comments";
      default:
        throw Exception("Network path doesnt not found");
    }
  }
}

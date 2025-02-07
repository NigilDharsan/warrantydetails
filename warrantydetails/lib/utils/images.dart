class Images {
  static const String noDataFound = 'assets/images/no_data_found.jpg';

  static String get us => 'us'.png;
  static String get categoryOne => 'category_one'.svg;
}

extension on String {
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/images/$this.svg';
}

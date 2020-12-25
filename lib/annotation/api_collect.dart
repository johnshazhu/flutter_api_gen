class Collector {
  Map<String, List<Map<String, dynamic>>> _functionsMap;
  Map<String, List<Map<String, dynamic>>> _importsMap;
  Map<String, Map<String, bool>> _importMap;
  Collector._() {
    _functionsMap = Map<String, List<Map<String, dynamic>>>();
    _importsMap = Map<String, List<Map<String, dynamic>>>();
    _importMap = Map<String, Map<String, bool>>();
  }

  static final Collector _instance = Collector._();
  static Collector get inst => _instance;

  Map<String, Map<String, bool>> get importMap => _importMap;
  Map<String, List<Map<String, dynamic>>> get importsMap => _importsMap;
  Map<String, List<Map<String, dynamic>>> get functionsMap => _functionsMap;
}
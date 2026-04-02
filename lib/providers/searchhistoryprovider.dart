import 'package:flutter/material.dart';

class SearchHistoryProvider extends ChangeNotifier {
  final List<String> _history = [];

  List<String> get history => List.unmodifiable(_history);

  void addSearch(String term) {
    if (term.isEmpty) return;
    if (_history.contains(term)) {
      _history.remove(term); // move to top
    }
    _history.insert(0, term);
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
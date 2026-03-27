import 'package:bigcart/model/transactionmodel.dart';
import 'package:flutter/material.dart';


class TransactionProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  void addTransaction(TransactionModel transaction) {
    _transactions.add(transaction);
    notifyListeners(); // 🔥 IMPORTANT
  }
  int _selectedCard = 0;

  int get selectedCard => _selectedCard;

  void selectCard(int index) {
    _selectedCard = index;
    notifyListeners();
  }
}
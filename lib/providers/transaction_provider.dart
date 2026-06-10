import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/transactionmodel.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  final supabase = Supabase.instance.client;

  Future<void> loadTransactions() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('transactions')
        .select()
        .eq('user_id', user.id)
        .order('date', ascending: false);

    _transactions = data.map<TransactionModel>((item) {
      return TransactionModel(
        name: "Customer",
        amount: item['amount'],
        method: item['method'],
       date: item['date'],
      );
    }).toList();

    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel txn) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('transactions').insert({
      'user_id': user.id,
      'method': txn.method,
      'amount': txn.amount,
      'date': DateTime.now().toIso8601String(),
    });

    _transactions.insert(0, txn);
    notifyListeners();
  }
}
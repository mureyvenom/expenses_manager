import 'package:flutter/material.dart';
//
import 'transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  const UserTransaction(this.userTransactions, this.deleteTransaction,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[TransactionList(userTransactions, deleteTransaction)],
    );
  }
}

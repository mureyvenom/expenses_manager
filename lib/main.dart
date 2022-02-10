import 'package:flutter/material.dart';
//
import 'widgets/user_transaction.dart';
import 'widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightBlue)
            .copyWith(secondary: Colors.blue),
        appBarTheme: AppBarTheme(
            toolbarTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  headline6: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )
                .bodyText2,
            titleTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  headline6: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )
                .headline6),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   't1',
    //   'New Laptop',
    //   450000,
    //   DateTime.now(),
    // ),
    // Transaction(
    //   't2',
    //   'New Shoe',
    //   15000,
    //   DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, num amount, DateTime date) {
    final newTx = Transaction(DateTime.now().toString(), title, amount, date);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Expenses',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add),
              color: Colors.white,
            )
          ],
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Chart(_recentTransactions),
                UserTransaction(_userTransactions, _deleteTransaction)
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

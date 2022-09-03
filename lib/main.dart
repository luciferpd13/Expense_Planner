import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewtransactionHandler(
          String title, double amount, DateTime selectedDate) =>
      setState(() {
        _transactions.add(Transaction(
            id: DateTime.now().toString(),
            title: title,
            amount: amount,
            date: selectedDate));
      });

  void _removeTransaction(String id) {
    print(id);
    setState(() {
      _transactions.removeWhere((trans) => trans.id == id);
    });
  }

  void _showNewTransaction(BuildContext ctx) => {
        showModalBottomSheet(
            context: ctx,
            builder: (_) {
              return GestureDetector(
                onTap: null,
                child: NewTransaction(_addNewtransactionHandler),
                behavior: HitTestBehavior.opaque,
              );
            })
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () => _showNewTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Chart(_recentTransactions),
          ),
          TransactionList(_transactions, _removeTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(Icons.add),
          onPressed: () => _showNewTransaction(context),
        ),
      ),
    );
  }
}

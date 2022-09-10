import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeTransaction;

  TransactionList(this._transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(builder: ((context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet !',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            }))
          : ListView.builder(
              itemBuilder: (context, index) {
                // return Card(
                //   child: Row(children: [
                //     Container(
                //       margin: const EdgeInsets.symmetric(
                //         vertical: 10,
                //         horizontal: 15,
                //       ),
                //       child: Text(
                //         '\$${_transactions[index].amount.toStringAsFixed(2)}',
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20,
                //           color: Theme.of(context).primaryColor,
                //         ),
                //       ),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //         color: Theme.of(context).primaryColor,
                //         width: 2,
                //       )),
                //       padding: const EdgeInsets.all(10),
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           _transactions[index].title,
                //           style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         Text(
                //           '${DateFormat.yMMMd().format(_transactions[index].date)}',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             color: Colors.grey,
                //           ),
                //         )
                //       ],
                //     )
                //   ]),
                // );
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${_transactions[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(_transactions[index].date)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                        color: Colors.red,
                        onPressed: () {
                          _removeTransaction(_transactions[index].id);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}

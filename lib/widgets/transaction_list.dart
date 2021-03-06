import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> trans;
  final Function deleteTx;

  TransactionList(this.trans, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,
      child: trans.isEmpty
          ? LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${trans[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      trans[index].title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(trans[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                            onPressed: () => deleteTx(trans[index].id),
                            icon: Icon(Icons.delete),
                            textColor: Theme.of(context).errorColor,
                            label: Text('Delete'),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(trans[index].id),
                          ),
                  ),
                );
              },
              itemCount: trans.length,
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  const NewTransaction(this.addTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final String enteredTitle = _titleController.text;
    final num enteredAmount = num.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (val) => _submitData,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (val) => _submitData,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Text(
                        _selectedDate != null
                            ? DateFormat.yMd().format(_selectedDate as DateTime)
                            : 'No Date Chosen',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Add'),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontWeight: FontWeight.bold)),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

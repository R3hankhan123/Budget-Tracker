import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracker/controllers/db_helper.dart';
import 'package:money_tracker/pages/home.dart';
import 'package:money_tracker/themes/colours.dart';
import 'package:unicons/unicons.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? amount;
  String description = "Some Reason";
  String type = "Expense";
  DateTime selectedDate = DateTime.now();
  bool date = false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100, 12),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: ListView(padding: const EdgeInsets.all(12), children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const HomePage())));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: primaryMaterialColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 80),
              Text(
                "Add Transaction",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 8, 8, 8),
                child: Text(
                  '\u{20B9}',
                  style: TextStyle(
                      fontSize: 30,
                      color: primaryMaterialColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() {
                      amount = int.parse(val);
                    });
                  },
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.description,
                  color: primaryMaterialColor,
                  size: 40,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Description",
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  UniconsLine.transaction,
                  color: primaryMaterialColor,
                  size: 40,
                ),
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: Text(
                  'Received',
                  style: TextStyle(
                    fontSize: 20,
                    color: type == "Received" ? Colors.white : Colors.black,
                  ),
                ),
                selected: type == "Received" ? true : false,
                selectedColor: primaryMaterialColor,
                onSelected: (val) {
                  setState(() {
                    type = "Received";
                  });
                },
              ),
              const SizedBox(width: 12),
              ChoiceChip(
                label: Text(
                  'Expense',
                  style: TextStyle(
                    fontSize: 20,
                    color: type == "Expense" ? Colors.white : Colors.black,
                  ),
                ),
                selected: type == "Expense" ? true : false,
                selectedColor: primaryMaterialColor,
                onSelected: (val) {
                  setState(() {
                    type = "Expense";
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.calendar_month,
                color: primaryMaterialColor,
                size: 40,
              ),
              const SizedBox(width: 12),
              TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                      date == false
                          ? "Date"
                          : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryMaterialColor))),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (amount != null && description.isNotEmpty) {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(amount!, description, type, selectedDate);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const HomePage())));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text("Please fill all the fields"),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }
              },
              child: const Text("Add"),
            ),
          ),
        ]));
  }
}

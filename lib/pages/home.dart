import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/controllers/db_helper.dart';
import 'package:money_tracker/pages/add_transaction.dart';
import 'package:money_tracker/themes/colours.dart';
import 'package:money_tracker/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  int totalBalance = 0;
  int expense = 0;
  int recived = 0;
  DbHelper dbHelper = DbHelper();
  List<FlSpot> dataSet = [];
  getTotalBalance(Map data) {
    totalBalance = 0;
    expense = 0;
    recived = 0;
    data.forEach((key, value) {
      if (value['type'] == 'Expense') {
        totalBalance -= value['amount'] as int;
        recived += value['amount'] as int;
      } else {
        totalBalance += value['amount'] as int;
        expense += value['amount'] as int;
      }
    });
  }

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == 'Expense' &&
          (value['date'] as DateTime).month == today.month) {
        dataSet.add(FlSpot((value['date'] as DateTime).day.toDouble(),
            (value['amount']).toDouble()));
      } else {}
    });
    return dataSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: primaryMaterialColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text(
              "Expense Tracker",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryMaterialColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => const AddTransaction()))
              .whenComplete(() {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        disabledElevation: 0.0,
        tooltip: 'Add transaction',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<Map>(
          future: dbHelper.fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Data"),
                );
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(12),
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            primaryMaterialColor,
                            Colors.blueAccent,
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      child: Column(
                        children: [
                          const Text(
                            'Balance',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '\u{20B9} $totalBalance',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardIncome(expense.toString()),
                              cardExpense(recived.toString())
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        "Expenses",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              spreadRadius: 5,
                              offset: Offset(0, 4))
                        ]),
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(12),
                    height: 300,
                    child: LineChart(LineChartData(
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                              spots: getPlotPoints(snapshot.data!),
                              isCurved: false,
                              barWidth: 2.5,
                              color: Colors.blueAccent)
                        ])),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text(
                        "Recent Transactions",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Map dataAtIndex = snapshot.data![index];
                        if (dataAtIndex['type'] == 'Expense') {
                          return expenseCard(dataAtIndex['amount'],
                              dataAtIndex['description']);
                        } else {
                          return recivedCard(dataAtIndex['amount'],
                              dataAtIndex['description']);
                        }
                      }),
                ],
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          }),
    );
  }
}

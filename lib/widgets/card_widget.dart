import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

Widget cardIncome(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(6),
        child: const Icon(
          UniconsLine.money_insert,
          color: Colors.green,
        ),
        margin: const EdgeInsets.only(right: 8.0),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recived",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      )
    ],
  );
}

Widget cardExpense(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(6),
        child: const Icon(
          UniconsLine.money_withdraw,
          color: Colors.red,
        ),
        margin: const EdgeInsets.only(right: 8.0),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expense",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      )
    ],
  );
}

Widget expenseCard(int value, String description) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xffced4eb),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Icon(
              UniconsLine.money_withdraw,
              color: Colors.red,
              size: 29,
            ),
            const Text(
              'Expense',
              style: TextStyle(
                  fontSize: 24, color: Colors.red, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 170),
            Text(
              '\u{20B9} $value',
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget recivedCard(int value, String description) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xffced4eb),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Icon(
              UniconsLine.money_insert,
              color: Colors.green,
              size: 29,
            ),
            const Text(
              'Recived',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 170),
            Text(
              '\u{20B9} $value',
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ],
        )
      ],
    ),
  );
}

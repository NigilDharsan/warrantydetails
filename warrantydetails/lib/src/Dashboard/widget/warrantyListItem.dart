import 'package:flutter/material.dart';
import 'package:warrantydetails/src/Dashboard/Model/WarrantyListModel.dart';

Widget warrantyListItems(WarrantyData warrantyData) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'S.no: ${warrantyData.serialNumber}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Center(
                      child: Text(
                    "Approve",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ],
            ),
            Text(
              'Model: ${warrantyData.model}',
              style: TextStyle(fontSize: 14),
            ),
            warrantyData.chno != null
                ? Text(
                    'CHNO: ${warrantyData.chno}',
                    style: TextStyle(fontSize: 14),
                  )
                : SizedBox(),
            Text(
              'Purchased Date: ${warrantyData.purchaseDate}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 20,
              child: customDottedLine(),
            ),
            Text(
              'Customer Name: ${warrantyData.customerName}',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'Phone Number: ${warrantyData.phoneNumber}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget customDottedLine() => Row(
      children: List.generate(
        1000 ~/ 10,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0
                ? Colors.transparent
                : const Color.fromRGBO(23, 48, 86, 1),
            height: 1.2,
          ),
        ),
      ),
    );

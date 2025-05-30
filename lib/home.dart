import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/components/expantion_widget.dart';
import 'package:untitled/controller.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // ✅ Get the chatId from URL query parameter like ?chatId=12345
    final String? chatId = Uri.base.queryParameters['chatId'];
    print('Chat ID from URL: $chatId');

    // If needed, you can store this in the controller or use it elsewhere.
    controller.transectionData();
    controller.transectionSummeryData();
    controller.issueData();

    return Scaffold(
      appBar: AppBar(title: Text("Transection Detail")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          'total Diposit: ${controller.summeryModel.value.results?.totalTransactions}',
                        ),
                      ),
                      Obx(
                        () => Text(
                          'Exchange Rate: ${controller.summeryModel.value.results?.exchangeRate}',
                        ),
                      ),
                      Obx(
                        () => Text(
                          'Rate: ${controller.summeryModel.value.results?.rate}',
                        ),
                      ),
                      Obx(
                        () => Text(
                          'Not issued: ${controller.summeryModel.value.results?.notIssuedMoney} || ${(controller.summeryModel.value.results?.notIssuedCrypto)?.toStringAsFixed(2)} USDT',
                        ),
                      ),
                      Obx(
                        () => Text(
                          'total Issued: ${controller.summeryModel.value.results?.totalIssuedMoney} || ${(controller.summeryModel.value.results?.totalIssuedUsdt)?.toStringAsFixed(2)} USDT',
                        ),
                      ),
                    ],
                  ),
                ),

                ExpantionWidget(
                  title: Text('Respondent Category'),
                  maxWidth: Get.width / 2,
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            children: [
                              TableCell(
                                child: Text(
                                  'Reply',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Deposit',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Issued',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Not issued',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Text('')),
                              TableCell(child: Text('')),
                              TableCell(child: Text('')),
                              TableCell(child: Text('')),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Obx(
              () => Text(
                'Deposit (${controller.transectionModel.value.count} Transections)',
              ),
            ),
            SizedBox(height: 10),

            Obx(
              () =>
                  controller.transectionModel.value.results != null
                      ? Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          controller.transectionModel.value.results!.isNotEmpty
                              ? TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                children: [
                                  TableCell(
                                    child: Text(
                                      'time',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Amount',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Reply',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Operator',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                              : TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                children: [
                                  TableCell(
                                    child: Text(
                                      'No data',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                          for (
                            int index = 0;
                            index <
                                controller
                                    .transectionModel
                                    .value
                                    .results!
                                    .length;
                            index++
                          )
                            if (controller
                                .transectionModel
                                .value
                                .results![index]
                                .chatId!
                                .contains(chatId ?? ''))
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Obx(
                                      () => Text(
                                        '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse("${controller.transectionModel.value.results?[index].time}"))}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Obx(() {
                                      double rat =
                                          controller
                                              .transectionModel
                                              .value
                                              .results?[index]
                                              .rate ??
                                          0;
                                      double amout =
                                          controller
                                              .transectionModel
                                              .value
                                              .results?[index]
                                              .amount ??
                                          1;
                                      return Text(
                                        '${controller.transectionModel.value.results?[index].amount}/${controller.transectionModel.value.results?[index].rate} = ${(amout / rat).toStringAsFixed(2)}',
                                        textAlign: TextAlign.center,
                                      );
                                    }),
                                  ),
                                  TableCell(
                                    child: Obx(
                                      () => Text(
                                        '${controller.transectionModel.value.results?[index].repliedBy}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Obx(
                                      () => Text(
                                        '${controller.transectionModel.value.results?[index].operatorName}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      )
                      : Text('No data found'),
            ),

            SizedBox(height: 20),

            Text('Issue(Pen)'),
            SizedBox(height: 10),

            Obx(
              () =>
                  controller.issueModel.value.results != null
                      ? Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          controller.issueModel.value.results!.isNotEmpty
                              ? TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                children: [
                                  TableCell(
                                    child: Text(
                                      'time',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Amount',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Reply',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Operator',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              )
                              : TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                ),
                                children: [
                                  TableCell(
                                    child: Text(
                                      'No data',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                          for (
                            int index = 0;
                            index < controller.issueModel.value.results!.length;
                            index++
                          )
                            if (controller
                                .issueModel
                                .value
                                .results![index]
                                .chatId!
                                .contains(chatId ?? ''))
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Obx(
                                      () => Text(
                                        '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse("${controller.issueModel.value.results?[index].time}"))}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Obx(() {
                                      double amount =
                                          controller
                                              .issueModel
                                              .value
                                              .results?[index]
                                              .amount ??
                                          0;
                                      return Text(
                                        '$amount',
                                        textAlign: TextAlign.center,
                                      );
                                    }),
                                  ),
                                  TableCell(
                                    child: Obx(
                                      () => Text(
                                        '${controller.issueModel.value.results?[index].reply}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Obx(
                                      () => Text(
                                        '${controller.issueModel.value.results?[index].operatorName}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      )
                      : Text('No data found'),
            ),








            Obx(()=>controller.issueModel.value.results != null?


                Row(
              children: [
                ExpantionWidget(
                  title: Text('Deposit Respondent Classification'),
                  maxWidth: Get.width / 2.2,
                  child: Column(children: [



                    Table(
                      border: TableBorder.all(),
                      columnWidths:  {
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                            TableCell(
                              child: Text(
                                'Reply',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Amount',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Reduced rates',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TableCell(
                              child: Text(
                                'Conversion',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),


                        for (
                        int index = 0;
                        index < controller.issueModel.value.results!.length;
                        index++
                        )
                          if (controller.issueModel.value.results![index].chatId!.contains(chatId ?? '')&&controller.issueModel.value.results?[index].reply!='')



                            TableRow(
                              children: [
                                TableCell(child: Obx(
                                      () => Text(
                                    '${controller.issueModel.value.results?[index].reply}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),),
                                TableCell(
                                  child: Obx(
                                        () => Text(
                                      '${controller.issueModel.value.results?[index].amount}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Obx(
                                        () => Text(
                                      '${(controller.issueModel.value.results?[index].amount)?.toStringAsFixed(2)}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Obx(
                                        () => Text(
                                      '${(controller.issueModel.value.results?[index].amount)?.toStringAsFixed(2)}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),



                  ],


                  ),
                ),

                ExpantionWidget(
                  title: Text('Deposit operator classification'),
                  maxWidth: Get.width / 2.2,
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            children: [
                              TableCell(
                                child: Text(
                                  'Operator',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Amount',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Conversion',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(child: Text('')),
                              TableCell(
                                child: Obx(
                                      () => Text(
                                    '${controller.summeryModel.value.results?.totalTransactions}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Obx(
                                      () => Text(
                                    '${(controller.summeryModel.value.results?.totalTransactionsCripto)?.toStringAsFixed(2)}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ): Text('No data found'),



            )

            ,











            Row(
              children: [
                ExpantionWidget(
                  title: Text('Deposit exchange rate classification'),
                  maxWidth: Get.width / 2.2,
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            children: [
                              TableCell(
                                child: Text(
                                  'exchange rate',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Amount',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  'Conversion',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Obx(
                                  () => Text(
                                    '${controller.summeryModel.value.results?.exchangeRate}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Obx(
                                  () => Text(
                                    '${controller.summeryModel.value.results?.totalTransactions}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Obx(
                                  () => Text(
                                    '${(controller.summeryModel.value.results?.totalTransactionsCripto)?.toStringAsFixed(2)}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ExpantionWidget(
                  title: Text('Category of people who send replies'),
                  maxWidth: Get.width / 2.2,
                  child: Column(children: [Text("No Data is available")]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
// import 'package:flutter/material.dart';

// class DatabaseSql extends StatefulWidget {
//   const DatabaseSql({super.key});

//   @override
//   State<DatabaseSql> createState() => _DatabaseSqlState();
// }

// class _DatabaseSqlState extends State<DatabaseSql> {
//   final _connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
//   List<TestModel> studentsInfoList = [];
//   List<TableRow> tableRowsList = [];
//   bool isLoading = false;
//   void createTableRows() {
//     // tableRowsList.clear();
//     tableRowsList.add(
//       const TableRow(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(12.0),
//             child: Text(
//               'CCode',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           Text(
//             'ShortName',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             'Name',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           Text(
//             'Phone',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//     for (var element in studentsInfoList) {
//       tableRowsList.add(
//         TableRow(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Text(
//                 element.ccode.toString(),
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Text(
//               element.sName.toString(),
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               element.name.toString(),
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               element.phone.toString(),
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     // setState(() {
//     //   isLoading = false;
//     // });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _connectToSqlServerDirectlyPlugin
//         .initializeConnection(
//       '13.251.68.128',
//       'ForNewCust',
//       'sa',
//       'reallyStrongPwd123',
//     )
//         .then((value) {
//       if (value) {
//         try {
//           _connectToSqlServerDirectlyPlugin
//               .getRowsOfQueryResult("select * from dbo.AcCompany")
//               .then((value) {
//             if (value.runtimeType == String) {
//               // onError(value.toString());
//             } else {
//               print("object");
//               log(value.toString());
//               List<Map<String, dynamic>> tempResult =
//                   value.cast<Map<String, dynamic>>();
//               for (var element in tempResult) {
//                 studentsInfoList.add(
//                   TestModel(
//                     ccode: element['CCode'],
//                     sName: element['ShortName'],
//                     name: element['Name'],
//                     address: element['Address'],
//                     phone: element['Phone'],
//                   ),
//                 );
//               }
//               createTableRows();
//             }
//           });
//           print(value);
//         } catch (error) {
//           // onError(error.toString());
//         }
//       } else {
//         // onError('Failed to Connect!');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<TestModel> studentsInfoList = [];
//     List<TableRow> tableRowsList = [];

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Connect To Sql Server Directly'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       " Sample Table",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               (!isLoading && studentsInfoList.isNotEmpty)
//                   ? Table(
//                       border: TableBorder.all(
//                         color: Colors.black,
//                         width: 1.0,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       columnWidths: const {
//                         0: FlexColumnWidth(0.3),
//                         1: FlexColumnWidth(0.4),
//                         2: FlexColumnWidth(0.3)
//                       },
//                       defaultVerticalAlignment:
//                           TableCellVerticalAlignment.middle,
//                       children: tableRowsList,
//                     )
//                   : (isLoading)
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             CircularProgressIndicator(
//                               color: Colors.black,
//                             ),
//                           ],
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text('This Table is Empty!'),
//                           ],
//                         ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TestModel {
//   final int ccode;
//   final String sName;
//   final String? name;
//   final String? address;
//   final String phone;

//   TestModel(
//       {required this.ccode,
//       required this.sName,
//       this.name,
//       this.address,
//       required this.phone});
// }

import 'dart:developer';
import 'dart:io';

import 'package:connect_to_sql_server_directly/connect_to_sql_server_directly.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class DatabaseSql extends StatefulWidget {
  const DatabaseSql({Key? key}) : super(key: key);

  @override
  State<DatabaseSql> createState() => _DatabaseSqlState();
}

class _DatabaseSqlState extends State<DatabaseSql> {
  List<TestModel> studentsInfoList = [];
  List<TableRow> tableRowsList = [];
  bool isLoading = false;
  final _connectToSqlServerDirectlyPlugin = ConnectToSqlServerDirectly();
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getStudentsTableData();
  }

  Future<List<String>> readTableNamesFromCSV(File csvFile) async {
    final lines = await csvFile.readAsLines();
    final csvList = const CsvToListConverter().convert(lines.join('\n'));

    final tableNames = <String>[];
    for (final row in csvList) {
      final tableName = row[0] as String;
      tableNames.add(tableName);
    }

    return tableNames;
  }

  void getStudentsTableData() {
    setState(() {
      isLoading = true;
    });
    studentsInfoList.clear();
    _connectToSqlServerDirectlyPlugin
        .initializeConnection(
      '13.251.68.128:1433',
      'testdbforcust',
      'sa',
      'reallyStrongPwd123',
    )
        .then((value) async {
      if (value) {
        try {
          final csvFile = File('assets/tablenames.csv');
          final tableNames = await readTableNamesFromCSV(csvFile);
          for (final tableName in tableNames) {
            final query = 'select * from dbo.$tableName';
            // final List<Map<String, dynamic>> result = await database.rawQuery(query);
            _connectToSqlServerDirectlyPlugin
                .getRowsOfQueryResult(query)
                .then((value) {
              if (value.runtimeType == String) {
                onError(value.toString());
              } else {
                log(value.toString());

                // List<Map<String, dynamic>> tempResult =
                //     value.cast<Map<String, dynamic>>();
              }
            });
            // Process the result or store it as needed
          }
        } catch (error) {
          onError(error.toString());
        }
      } else {
        onError('Failed to Connect!');
      }
    });
  }

  void onError(String message) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 6),
        padding: const EdgeInsets.all(8.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createTableRows() {
    tableRowsList.clear();
    tableRowsList.add(
      const TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'CCode',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            'ShortName',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Phone',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
    for (var element in studentsInfoList) {
      tableRowsList.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                element.ccode.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              element.sName.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              element.name.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              element.phone.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> addRowDataToTable() async {
    bool result = false;
    _connectToSqlServerDirectlyPlugin
        .initializeConnection(
      '13.251.68.128',
      // '192.168.29.44:57058',

      'ForNewCust',
      // 'db_smartkid',

      'sa',
      // 'root',

      'reallyStrongPwd123',
    )
        .then((value) {
      if (value) {
        try {
          _connectToSqlServerDirectlyPlugin
              .getStatusOfQueryResult(
                  // "Insert Into dbo.AcCompany(CCode,ShortName,Name,Address, Phone,Fax,Email,ActiveComp,AltBarcodeStartChar) Values('5','new company','Salah','calicut', '543','7','mail','false','ad')")
                  "Delete From dbo.AcCompany Where CCode = 5")
              // "INSERT INTO dbo.AcCompany (New, title, price, created_at) VALUES (1, 2, 3, 4)")
              // "Update dbo.AcCompany Set CCode = '1', Name = 'flutter'")
              .then((value) {
            if (value.runtimeType == String) {
              onError(value.toString());
            } else {
              result = value;
              if (value) {
                getStudentsTableData();
              }
            }
          });
        } catch (error) {
          onError(error.toString());
        }
      } else {
        onError('Failed to Register!');
      }
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Connect To Sql Server Directly'),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //     ElevatedButton(
      //         onPressed: () {
      //           getStudentsTableData();
      //         },
      //         child: const Text("Fetch Data")),
      //     FloatingActionButton(
      //       backgroundColor: Colors.black,
      //       onPressed: () {
      //         _nameController.clear();
      //         _weightController.clear();
      //         final formKey = GlobalKey<FormState>();
      //         showDialog(
      //           context: context,
      //           builder: (BuildContext context) {
      //             return AlertDialog(
      //               backgroundColor: Colors.white,
      //               elevation: 4.0,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(20),
      //               ),
      //               contentPadding: const EdgeInsets.all(16.0),
      //               insetPadding: const EdgeInsets.symmetric(
      //                 horizontal: 40,
      //               ),
      //               content: SizedBox(
      //                 width: MediaQuery.of(context).size.width - 40,
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     Form(
      //                       key: formKey,
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           const Expanded(
      //                             flex: 1,
      //                             child: Text(
      //                               "Name",
      //                               style: TextStyle(
      //                                 fontSize: 13,
      //                               ),
      //                             ),
      //                           ),
      //                           Expanded(
      //                             flex: 2,
      //                             child: Container(
      //                               height: 40,
      //                               padding:
      //                                   const EdgeInsets.fromLTRB(8, 0, 8, 2),
      //                               decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 boxShadow: [
      //                                   BoxShadow(
      //                                     color: Colors.blue.withOpacity(0.4),
      //                                     spreadRadius: 1,
      //                                     blurRadius: 1,
      //                                     offset: const Offset(0,
      //                                         0), // changes position of shadow
      //                                   ),
      //                                 ],
      //                                 borderRadius: BorderRadius.circular(25),
      //                               ),
      //                               child: Center(
      //                                 child: TextFormField(
      //                                   validator: (String? value) {
      //                                     if (value != null &&
      //                                         value.trim() == "") {
      //                                       return "Name can't be empty!";
      //                                     } else {
      //                                       return null;
      //                                     }
      //                                   },
      //                                   decoration: const InputDecoration(
      //                                     border: InputBorder.none,
      //                                     contentPadding: EdgeInsets.zero,
      //                                   ),
      //                                   textDirection: TextDirection.ltr,
      //                                   textAlign: TextAlign.center,
      //                                   textInputAction: TextInputAction.done,
      //                                   controller: _nameController,
      //                                   style: const TextStyle(
      //                                     fontSize: 13,
      //                                     fontWeight: FontWeight.bold,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     const SizedBox(height: 10),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         const Expanded(
      //                           flex: 1,
      //                           child: Text(
      //                             "Weight",
      //                             style: TextStyle(
      //                               fontSize: 13,
      //                             ),
      //                           ),
      //                         ),
      //                         Expanded(
      //                           flex: 2,
      //                           child: Container(
      //                             height: 40,
      //                             padding:
      //                                 const EdgeInsets.fromLTRB(8, 0, 8, 2),
      //                             decoration: BoxDecoration(
      //                               color: Colors.white,
      //                               boxShadow: [
      //                                 BoxShadow(
      //                                   color: Colors.blue.withOpacity(0.4),
      //                                   spreadRadius: 1,
      //                                   blurRadius: 1,
      //                                   offset: const Offset(
      //                                       0, 0), // changes position of shadow
      //                                 ),
      //                               ],
      //                               borderRadius: BorderRadius.circular(25),
      //                             ),
      //                             child: Center(
      //                               child: TextFormField(
      //                                 keyboardType: TextInputType.number,
      //                                 textInputAction: TextInputAction.done,
      //                                 controller: _weightController,
      //                                 inputFormatters: [
      //                                   FilteringTextInputFormatter.allow(
      //                                     RegExp(r'^[0-9]+(.)?([0-9]+)?'),
      //                                   ),
      //                                 ],
      //                                 decoration: const InputDecoration(
      //                                   border: InputBorder.none,
      //                                   contentPadding: EdgeInsets.zero,
      //                                 ),
      //                                 textDirection: TextDirection.ltr,
      //                                 textAlign: TextAlign.center,
      //                                 style: const TextStyle(
      //                                   fontSize: 13,
      //                                   fontWeight: FontWeight.bold,
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     const SizedBox(height: 20),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         InkWell(
      //                           borderRadius: BorderRadius.circular(15),
      //                           onTap: () {
      //                             if (formKey.currentState!.validate()) {
      //                               Navigator.pop(context);
      //                               addRowDataToTable();
      //                             }
      //                           },
      //                           child: Container(
      //                             padding:
      //                                 const EdgeInsets.fromLTRB(16, 8, 16, 8),
      //                             width: MediaQuery.of(context).size.width / 3,
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(15),
      //                               color: Colors.black,
      //                             ),
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               textDirection: TextDirection.rtl,
      //                               children: const [
      //                                 Text(
      //                                   "Register",
      //                                   style: TextStyle(
      //                                     fontSize: 16,
      //                                     color: Colors.white,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                         InkWell(
      //                           borderRadius: BorderRadius.circular(15),
      //                           onTap: () {
      //                             Navigator.pop(context);
      //                           },
      //                           child: Container(
      //                             padding:
      //                                 const EdgeInsets.fromLTRB(16, 8, 16, 8),
      //                             width: MediaQuery.of(context).size.width / 3,
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(15),
      //                               color: Colors.grey,
      //                             ),
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.center,
      //                               textDirection: TextDirection.rtl,
      //                               children: const [
      //                                 Text(
      //                                   "Cancel",
      //                                   style: TextStyle(
      //                                     fontSize: 16,
      //                                     color: Colors.white,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         );
      //       },
      //       child: const Icon(
      //         Icons.add,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Sample Table",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              (!isLoading && studentsInfoList.isNotEmpty)
                  ? Table(
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 1.0,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(0.3),
                        1: FlexColumnWidth(0.4),
                        2: FlexColumnWidth(0.3)
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: tableRowsList,
                    )
                  : (isLoading)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('This Table is Empty!'),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestModel {
  final int ccode;
  final String sName;
  final String? name;
  final String? address;
  final String phone;

  TestModel(
      {required this.ccode,
      required this.sName,
      this.name,
      this.address,
      required this.phone});
}

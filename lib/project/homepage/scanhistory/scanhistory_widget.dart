import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScanhistoryWidget extends StatefulWidget {
  @override
  _ScanhistoryWidgetState createState() => _ScanhistoryWidgetState();
}

class _ScanhistoryWidgetState extends State<ScanhistoryWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   _resetDataOnAppInstall();
  // }

  // Future<void> _resetDataOnAppInstall() async {
  //   await _firestore.collection('scan_history').get().then((snapshot) {
  //     for (DocumentSnapshot doc in snapshot.docs) {
  //       doc.reference.delete();
  //     }
  //   });
  //   // เพิ่มโค้ดสร้าง scan_history เพื่อทดสอบ
  //   await _firestore.collection('scan_history').add({
  //     'timestamp': DateTime.now(),
  //     'label': 'Test Label',
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF334E53),
        automaticallyImplyLeading: false,
        title: Text(
          'ประวัติการสแกน',
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 3, 20, 0),
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('เลือกวัน'),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: Container(
        color: Color(0xFF334E53),
        child: FutureBuilder<QuerySnapshot>(
          future: _firestore
              .collection('scan_history')
              .orderBy('timestamp', descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var document = documents[index];
                  // Check if the document timestamp matches the selected date
                  if (DateFormat('dd/MM/yyyy', 'th')
                          .format(document['timestamp'].toDate()) ==
                      DateFormat('dd/MM/yyyy', 'th').format(selectedDate)) {
                    return Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 1),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF29343A),
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0xFF29343A),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF4B39EF),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    SizedBox(width: 13),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            document['label'],
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy    HH:mm:ss',
                                                    'th')
                                                .format(document['timestamp']
                                                    .toDate()),
                                            style: GoogleFonts.roboto(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                          // แสดง totalAmount และ scanCount
                                          Text(
                                            'รวมเงินทั้งหมด: ${document['totalAmount']} บาท',
                                            style: GoogleFonts.roboto(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'จำนวนการนำแบงค์เข้ามาสแกน: ${document['scanCount']} ใบ',
                                            style: GoogleFonts.roboto(
                                              fontSize: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Return an empty container for items with different dates
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Function to open date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Use dark theme for date picker
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // You can add additional logic here if needed
      });
    }
  }
}

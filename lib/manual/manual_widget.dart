import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'manual_model.dart';

export 'manual_model.dart';

class ManualWidget extends StatefulWidget {
  const ManualWidget({Key? key}) : super(key: key);

  @override
  _ManualWidgetState createState() => _ManualWidgetState();
}

class _ManualWidgetState extends State<ManualWidget> {
  late ManualModel _model;
  final CollectionReference _careCollection =
      FirebaseFirestore.instance.collection('manual');
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> careItems = [];
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManualModel());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Color(0xFF334E53),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'คู่มือ',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Urbanist',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/bank-app-bcb6e.appspot.com/o/manual.png?alt=media&token=263937b8-5a0c-4fbf-b2bb-ff7dfbc15cae',
                  width: double.infinity,
                  height: 240.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('manual')
                        .doc('NcEytPFHtQbnQ6oCjHvB')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // หรือ Widget ที่คุณต้องการแสดงในระหว่างโหลดข้อมูล
                      } else if (snapshot.hasError) {
                        return Text('Error loading data');
                      } else {
                        String textFromFirestore =
                            snapshot.data?.get('title') ?? '';
                        return Text(
                          textFromFirestore,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF15161E),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('manual')
                        .doc('NcEytPFHtQbnQ6oCjHvB')
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // หรือ Widget ที่คุณต้องการแสดงในระหว่างโหลดข้อมูล
                      } else if (snapshot.hasError) {
                        return Text('Error loading data');
                      } else {
                        String textFromFirestore =
                            snapshot.data?.get('Description') ?? '';
                        return Text(
                          textFromFirestore,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF606A85),
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF29343A),
                              size: 20.0,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 8.0, 0.0, 8.0),
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('manual')
                                      .doc('NcEytPFHtQbnQ6oCjHvB')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // หรือ Widget ที่คุณต้องการแสดงในระหว่างโหลดข้อมูล
                                    } else if (snapshot.hasError) {
                                      return Text('Error loading data');
                                    } else {
                                      String textFromFirestore =
                                          snapshot.data?.get('section1') ?? '';
                                      return Text(
                                        textFromFirestore,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF29343A),
                              size: 20.0,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 8.0, 0.0, 8.0),
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('manual')
                                      .doc('NcEytPFHtQbnQ6oCjHvB')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // หรือ Widget ที่คุณต้องการแสดงในระหว่างโหลดข้อมูล
                                    } else if (snapshot.hasError) {
                                      return Text('Error loading data');
                                    } else {
                                      String textFromFirestore =
                                          snapshot.data?.get('section2') ?? '';
                                      return Text(
                                        textFromFirestore,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF29343A),
                              size: 20.0,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 8.0, 0.0, 8.0),
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('manual')
                                      .doc('NcEytPFHtQbnQ6oCjHvB')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // หรือ Widget ที่คุณต้องการแสดงในระหว่างโหลดข้อมูล
                                    } else if (snapshot.hasError) {
                                      return Text('Error loading data');
                                    } else {
                                      String textFromFirestore =
                                          snapshot.data?.get('section3') ?? '';
                                      return Text(
                                        textFromFirestore,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Color(0xFF29343A),
                              size: 20.0,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 8.0, 0.0, 8.0),
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('manual')
                                      .doc('NcEytPFHtQbnQ6oCjHvB')
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(); // หรือ Widget ที่คุณต้องการแสดงในระหว่างโหลดข้อมูล
                                    } else if (snapshot.hasError) {
                                      return Text('Error loading data');
                                    } else {
                                      String textFromFirestore =
                                          snapshot.data?.get('section4') ?? '';
                                      return Text(
                                        textFromFirestore,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF15161E),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

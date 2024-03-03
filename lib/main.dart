import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBml2UwqaVFN7X2oBSKO6FIiYVPE1TACVc",
        authDomain: "incom-web-test.firebaseapp.com",
        projectId: "incom-web-test",
        storageBucket: "incom-web-test.appspot.com",
        messagingSenderId: "585782157776",
        appId: "1:585782157776:web:f48824a1bcbaea1d4e59d5"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController grade = TextEditingController();
  bool submit = false;
  @override
  Widget build(BuildContext context) {
    return !submit
        ? Scaffold(
            backgroundColor: Colors.pink[50],
            body: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'INCOM\n방명록',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 70),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        width: MediaQuery.sizeOf(context).width - 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '이름',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(controller: name),
                            const SizedBox(height: 20),
                            const Text(
                              '학번(ex.12xxxxxx)',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(controller: grade),
                            const SizedBox(height: 20),
                            const Text(
                              '전화번호',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(controller: number),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          if ((name.text != '') &&
                              (grade.text != '') &&
                              (number.text != '')) {
                            DocumentReference doc = FirebaseFirestore.instance
                                .doc('users/${grade.text}');

                            doc.set({
                              'name': name.text,
                              'number': number.text,
                              // 추가하려는 필드를 여기에 작성하세요.
                            }).then((void _) {
                            }).catchError((error) {
                              print('Failed to update document: $error');
                            });
                            name.clear();
                            grade.clear();
                            number.clear();
                            submit = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(90)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('제출하기',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('제출완료'),
            ),
          );
  }
}

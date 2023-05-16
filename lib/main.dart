import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // extends 확장하다
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () async {
            // async : 비동기, await : 기다려(내가 누를 때까지 기다림`)
            var dt = await showDatePicker(
                // 어싱크 어웨이트
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023, 3, 2),
                lastDate: DateTime(2023, 12, 31));
            String date = dt.toString().split(' ')[0].replaceAll('-', '');
            String site =
                'https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&ATPT_OFCDC_SC_CODE=J10&SD_SCHUL_CODE=7530167&MLSV_YMD=$date';
            var response =
                await http.get(Uri.parse(site)); // 인터넷 주소형식으로 바꾼걸 통신으로 바꿔와!
            if (response.statusCode == 200) {
              var data = jsonDecode(response.body);
              print(data['mealServiceDietInfo'][1]['row'][0]['DDISH_NM']);
            } else {
              print('error');
            }
          },
          icon: const Icon(Icons.add)),
    );
  }
}

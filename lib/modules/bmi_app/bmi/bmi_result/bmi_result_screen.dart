import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {

  final bool isMale;
  final int age;
  final int weight;
  final int height;
  final int result;

  BMIResultScreen({
    required this.isMale,
    required this.age,
    required this.weight,
    required this.height,
    required this.result
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'BMI Result',
        ),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender: ${isMale ? 'Male' : 'Female'}',
          ),
          Text(
            'Age: $age',
          ),
          Text(
            'Weight: $weight',
          ),
          Text(
              'Height: $height',
          ),
          Text(
            'Result: $result',
          ),
        ],
      )),
    );
  }
}

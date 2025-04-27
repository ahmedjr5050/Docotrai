import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  String _bmiResultText = '';
  String _bmiValue = ''; // الرقم بس

  void _calculateBmi() {
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _bmiResultText = 'يرجى إدخال قيم صحيحة للطول والوزن';
        _bmiValue = '';
      });
      return;
    }

    final bmi = weight / ((height / 100) * (height / 100));
    final bmiStr = bmi.toStringAsFixed(2);

    setState(() {
      _bmiValue = bmiStr;
      _bmiResultText = 'مؤشر كتلة الجسم (BMI) الخاص بك هو: $bmiStr';
    });
  }

  void _copyResult() {
    if (_bmiValue.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _bmiValue));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تم نسخ القيمة: $_bmiValue')));
    }
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'الطول (سم)',
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'الوزن (كجم)',
                prefixIcon: Icon(Icons.fitness_center),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBmi, child: Text('احسب')),
            SizedBox(height: 20),
            if (_bmiResultText.isNotEmpty) ...[
              Text(
                _bmiResultText,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: _copyResult,
                icon: Icon(Icons.copy),
                label: Text('نسخ القيمة فقط'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

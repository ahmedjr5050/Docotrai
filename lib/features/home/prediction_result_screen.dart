import 'package:flutter/material.dart';

class PredictionResultScreen extends StatelessWidget {
  final String diseaseName;

  const PredictionResultScreen({super.key, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    // النصائح الغذائية لكل مرض
    final Map<String, List<String>> dietaryTips = {
      'Anemia': [
        'تناول الأطعمة الغنية بالحديد مثل اللحوم الحمراء، الكبد، والفاصوليا.',
        'شرب عصير البرتقال لزيادة امتصاص الحديد.',
        'تجنب شرب الشاي أو القهوة مع الوجبات.',
      ],
      'Goiter': [
        'زيادة تناول الأطعمة الغنية باليود مثل الأسماك البحرية.',
        'تناول الأطعمة الغنية بالزنك مثل اللحوم والمكسرات.',
        'تجنب تناول الأطعمة التي تحتوي على مواد مناهضة للغدة الدرقية مثل الملفوف والقرنبيط.',
      ],
      'Kwashiorkor': [
        'زيادة تناول البروتين مثل اللحوم، الأسماك، والبيض.',
        'تناول الأطعمة الغنية بالكربوهيدرات مثل الأرز، البطاطا، والخضروات.',
        'التأكد من تناول كمية كافية من الفيتامينات والمعادن.',
      ],
      'Marasmus': [
        'زيادة تناول الأطعمة ذات السعرات الحرارية العالية مثل الزيوت، المكسرات، واللبن كامل الدسم.',
        'تناول وجبات صغيرة ومتكررة طوال اليوم.',
        'شرب كميات كبيرة من السوائل لتجنب الجفاف.',
      ],
      'Obesity': [
        'تناول كميات صغيرة من الطعام بشكل منتظم.',
        'زيادة تناول الأطعمة الغنية بالألياف مثل الخضروات والفواكه.',
        'ممارسة الرياضة بانتظام وتجنب الأطعمة الغنية بالدهون.',
      ],
      'Scurvy': [
        'تناول الأطعمة الغنية بفيتامين سي مثل البرتقال، الفراولة، والفلفل الأحمر.',
        'زيادة استهلاك الأطعمة الطازجة بدلاً من الأطعمة المعلبة.',
        'شرب عصير الليمون أو تناول أقراص فيتامين سي إذا لزم الأمر.',
      ],
    };

    // نصائح الطعام لكل مرض
    final tips = dietaryTips[diseaseName] ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Prediction Result")),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Diagnosis Result:",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  diseaseName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                if (tips.isNotEmpty) ...[
                  const Text(
                    "Dietary Tips:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(40.0),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      for (var i = 0; i < tips.length; i++)
                        TableRow(
                          children: [
                            Text('${i + 1}.', style: TextStyle(fontSize: 16)),
                            Text(tips[i], style: TextStyle(fontSize: 16)),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

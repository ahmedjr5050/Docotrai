import 'package:flutter/material.dart';

class SymptomsPage extends StatelessWidget {
  const SymptomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> symptomsList = [
      'نزيف اللثة',
      'صعوبة في التنفس',
      'تشقق الجلد',
      'صعوبة في البلع',
      'الدوخة',
      'جفاف الجلد',
      'التعب',
      'بحة في الصوت',
      'ألم في المفاصل',
      'فقدان العضلات',
      'ضعف العضلات',
      'تورم في الرقبة',
      'شحوب الجلد',
      'فقدان شديد في الوزن',
      'تورم الساقين',
      'زيادة الوزن',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('حدد الأعراض')),
      body: ListView.builder(
        itemCount: symptomsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(symptomsList[index]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context, index); // رجّع الـ index المختار
            },
          );
        },
      ),
    );
  }
}

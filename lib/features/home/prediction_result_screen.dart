import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutritionforlife/core/services/getit_services.dart';
import 'package:nutritionforlife/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nutritionforlife/features/auth/presention/cubit/signin_cubit/sign_in_cubit.dart';

class PredictionResultScreen extends StatefulWidget {
  final String diseaseName;

  const PredictionResultScreen({super.key, required this.diseaseName});

  @override
  State<PredictionResultScreen> createState() => _PredictionResultScreenState();
}

class _PredictionResultScreenState extends State<PredictionResultScreen> {
  bool showTips = false;
  bool showCauses = false;
  bool showRemedies = false;
  @override
  Widget build(BuildContext context) {
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
    final Map<String, List<String>> diseaseComplications = {
      'Anemia': [
        'التعب والإرهاق المستمر.',
        'مشاكل في القلب مثل تضخم القلب أو فشل القلب.',
        'صعوبة في التركيز وضعف الأداء العقلي.',
      ],
      'Goiter': [
        'صعوبة في التنفس أو البلع بسبب تضخم الغدة.',
        'خلل في إنتاج الهرمونات (قصور أو فرط نشاط الغدة).',
        'تكون عقيدات في الغدة قد تحتاج إلى جراحة.',
      ],
      'Kwashiorkor': [
        'تأخر النمو العقلي والجسدي عند الأطفال.',
        'ضعف الجهاز المناعي وزيادة خطر العدوى.',
        'تورم في الجسم ومشاكل في الكبد.',
      ],
      'Marasmus': [
        'فقدان شديد للوزن والعضلات.',
        'ضعف شديد في المناعة.',
        'تأخر النمو والتطور عند الأطفال.',
      ],
      'Obesity': [
        'زيادة خطر الإصابة بأمراض القلب والسكري.',
        'ارتفاع ضغط الدم ومشاكل المفاصل.',
        'مشاكل نفسية مثل الاكتئاب والقلق.',
      ],
      'Scurvy': [
        'نزيف اللثة وتساقط الأسنان.',
        'ضعف التئام الجروح.',
        'آلام المفاصل وفقر الدم.',
      ],
    };

    final Map<String, List<String>> diseaseCauses = {
      'Anemia': [
        'نقص الحديد في النظام الغذائي.',
        'فقدان الدم بسبب النزيف أو الحيض الغزير.',
        'ضعف امتصاص الحديد من الجهاز الهضمي.',
      ],
      'Goiter': [
        'نقص اليود في النظام الغذائي.',
        'اضطرابات في عمل الغدة الدرقية.',
        'تناول بعض الأطعمة التي تؤثر على الغدة مثل الملفوف والقرنبيط بكثرة.',
      ],
      'Kwashiorkor': [
        'نقص حاد في تناول البروتين.',
        'سوء التغذية المزمن خاصة عند الأطفال.',
        'أمراض تسبب صعوبة في امتصاص العناصر الغذائية.',
      ],
      'Marasmus': [
        'نقص عام في السعرات الحرارية والبروتين.',
        'الفقر وسوء الحالة الاقتصادية والمعيشية.',
        'أمراض مزمنة تؤثر على امتصاص الغذاء.',
      ],
      'Obesity': [
        'تناول كميات كبيرة من الطعام دون نشاط بدني كافٍ.',
        'العوامل الوراثية والهرمونية.',
        'التوتر والضغط النفسي المؤدي للأكل العاطفي.',
      ],
      'Scurvy': [
        'نقص حاد في فيتامين سي.',
        'عدم تناول الفواكه والخضروات الطازجة لفترات طويلة.',
        'سوء التغذية بشكل عام.',
      ],
    };

    final tips = dietaryTips[widget.diseaseName] ?? [];
    final causes = diseaseCauses[widget.diseaseName] ?? [];
    final complications = diseaseComplications[widget.diseaseName] ?? [];
    return BlocProvider(
      create: (context) => SignInCubit(getIt<AuthRepoImpl>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Prediction Result"),
              backgroundColor: const Color(0xFF6CD8D1),
              centerTitle: true,
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              actions: [
                IconButton(
                  tooltip: "Logout",
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<SignInCubit>().signOut(context);
                  },
                ),
              ],
            ),
            body: Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Diagnosis Result:",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.diseaseName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6CD8D1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showTips = !showTips;
                                });
                              },
                              child: Text(
                                showTips ? "Hide Tips" : "Dietary Tips",
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFC107),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showCauses = !showCauses;
                                });
                              },
                              child: Text(
                                showCauses ? "Hide Causes" : "Symptoms Causes",
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                        const SizedBox(height: 20),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              showRemedies = !showRemedies;
                            });
                          },
                          child: const Text(
                            "Complications of the disease",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          crossFadeState:
                              showTips
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          firstChild: const SizedBox(),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                tips
                                    .map(
                                      (tip) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text("• $tip"),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          crossFadeState:
                              showCauses
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          firstChild: const SizedBox(),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                causes
                                    .map(
                                      (cause) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text("• $cause"),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          crossFadeState:
                              showRemedies
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          firstChild: const SizedBox(),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                complications
                                    .map(
                                      (cause) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Text("• $cause"),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
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
            ),
          );
        },
      ),
    );
  }
}

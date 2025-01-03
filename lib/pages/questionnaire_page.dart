import 'package:flutter/material.dart';
import 'package:pseudo_coder/model/question_model.dart';
import 'package:pseudo_coder/pages/review_page.dart';
import 'package:pseudo_coder/utilities/my_elevated_button.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _currentIndex = 0;
  List<Question> _questions = [];
  List<TextEditingController> _controllers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final String jsonString = await DefaultAssetBundle.of(context)
          .loadString('lib/assets/questions.json');
      final QuestionData questionData = QuestionData.fromJson(jsonString);

      setState(() {
        _questions = questionData.questions;
        _controllers = List.generate(
            _questions.length, (index) => TextEditingController());
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error while loading questions: $e");
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void goToPrevious() {
    setState(() {
      _currentIndex--;
    });
  }

  void goToNext() {
    setState(() {
      _currentIndex++;
    });
  }

  void reviewPseudoCode() {
    if (_questions.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewPage(
            questions: _questions,
            pseudoCodes: _controllers.map((e) => e.text).toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pseudo Coder"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade100,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        onPressed: reviewPseudoCode,
                        child: const Text("Review"),
                      ),
                    ),
                    Text(
                      "Question ${_currentIndex + 1} of ${_questions.length}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      _questions[_currentIndex].question,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      "Enter your pseudo-code:",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: TextField(
                        maxLines: 18,
                        controller: _controllers[_currentIndex],
                        decoration: InputDecoration(
                          hintText: "Enter your pseudo-code here...",
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepPurple.shade300,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentIndex > 0)
                          MyElevatedButton(
                            onPressed: goToPrevious,
                            buttonText: "Previous",
                          ),
                        if (_currentIndex == 0 ||
                            _currentIndex < _questions.length - 1)
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: MyElevatedButton(
                                onPressed: goToNext,
                                buttonText: "Next",
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

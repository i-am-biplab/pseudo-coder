import 'package:flutter/material.dart';
import 'package:pseudo_coder/model/question_model.dart';
import 'package:pseudo_coder/utilities/my_elevated_button.dart';

class ReviewPage extends StatelessWidget {
  final List<Question> questions;
  final List<String> pseudoCodes;

  const ReviewPage({
    super.key,
    required this.questions,
    required this.pseudoCodes,
  });

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congratulations!"),
          content: const Text("Your Pseudo-Code submitted successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Submissions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}:',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(questions[index].question),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Your Pseudo-code:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          pseudoCodes[index],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: MyElevatedButton(
                onPressed: () => showDialogBox(context),
                buttonText: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

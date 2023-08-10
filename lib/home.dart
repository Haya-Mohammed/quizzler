import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzler/true_false/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];

  checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (correctAnswer == userAnswer) {
      scoreKeeper.add(
        const Icon(Icons.check, color: Colors.green),
      );
    } else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
    }
    if (quizBrain.isFinished()) {
      Timer(const Duration(seconds: 1), () {
        Alert(
          context: context,
          title: 'Finished',
          desc: 'You\'re done',
        ).show();
        setState(() {
          quizBrain.reset();
          scoreKeeper.clear();
        });
      });
    } else {
      setState(() {
        quizBrain.nextQuestion();
      });
    }
  }

  int? _choice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  checkAnswer(true);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  //   shape: MaterialStateProperty.all(),
                ),
                child: const Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  checkAnswer(false);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                  //   shape: MaterialStateProperty.all(),
                ),
                child: const Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: scoreKeeper,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

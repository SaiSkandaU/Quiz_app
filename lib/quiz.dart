import 'package:flutter/material.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _QuestionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _QuestionIndex = 0;
      _totalScore = 0;
    });
  }

  void _AnswerQuestion(String ans, String chosenAns) {
    if (ans == chosenAnswer) {
      _totalScore += 1;
    }
    setState(() {
      _qsnIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
          child: _qsnIndex < qsns.length
              ? QuizPanel(
            ansQsn: _ansQsn,
            qsnIndex: _qsnIndex,
            qsns: qsns,
          )
              : Result(_totalScore, _resetQuiz),
        ),
      ),
    );
  }
}
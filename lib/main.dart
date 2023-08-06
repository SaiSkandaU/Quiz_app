import 'package:flutter/material.dart';

void main() {
  runApp(QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizzlerScreen(),
    );
  }
}

class QuizzlerScreen extends StatefulWidget {
  @override
  _QuizzlerScreenState createState() => _QuizzlerScreenState();
}

class _QuizzlerScreenState extends State<QuizzlerScreen> {
  int questionIndex = 0;
  int score = 0;
  bool showResult = false;

  List<Question> questions = [
    Question('Jana Gana Mana is National anthem of India', true),
    Question('Atomic number of Lithium is 17', false),
    Question('Humans have four chambered heart ', true),
    Question('Dr. Babu RajendraPrasad was the first president of India ', true),
    Question('Bengaluru is capital city of Karnataka', true)
  ];

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questions[questionIndex].answer;
    if (userAnswer == correctAnswer) {
      setState(() {
        score++;
      });
    }

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      setState(() {
        showResult = true;
      });
    }
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzler App'),
      ),
      body: showResult ? ResultPage(score: score, totalQuestions: questions.length, onPlayAgain: resetQuiz) : QuizPage(questions: questions, questionIndex: questionIndex, onAnswerSelected: checkAnswer),
    );
  }
}

class Question {
  String questionText;
  bool answer;

  Question(this.questionText, this.answer);
}

class QuizPage extends StatelessWidget {
  final List<Question> questions;
  final int questionIndex;
  final Function(bool) onAnswerSelected;

  QuizPage({required this.questions, required this.questionIndex, required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questions[questionIndex].questionText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => onAnswerSelected(true),
                child: Text('True'),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: () => onAnswerSelected(false),
                child: Text('False'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onPlayAgain;

  ResultPage(
      {required this.score, required this.totalQuestions, required this.onPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: onPlayAgain,
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
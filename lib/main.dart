import 'package:flutter/material.dart';

void main() => runApp(TestQuiz());

class TestQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THIS IS MY QUESTION TRY TO ANSWER IT',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  List<Question> _questions = [
    Question('Question 1: Are people perfect?', false),
    Question('Question 2: Do people give up without fighting problems?', false),
    Question('Question 3: Is computer science an interesting department that requires a lot of effort?', true),
  ];

  void _checkAnswer(String userAnswer) {
    bool correctAnswer = _questions[_currentQuestionIndex].answer;

    if (userAnswer == correctAnswer.toString()) {
      setState(() {
        _score++;
      });
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Quiz completed, show the result
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('You have completed the quiz'),
            content: Text('Your Score: $_score'),
            actions: [
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                  });
                },
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestQuiz App'),
      ),
      body: Container(
        color: Colors.blue, // Change the background color to your desired interactive color
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  _questions[_currentQuestionIndex].question,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: 'Arial', // Change the font family to your desired font
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size.fromWidth(120.0)), // Adjust the width as needed
                backgroundColor: MaterialStateProperty.all(Colors.white), // Change the button color to your desired color
                foregroundColor: MaterialStateProperty.all(Colors.blue), // Change the button text color to a contrasting color
              ),
              child: Text('True'),
              onPressed: () => _checkAnswer('true'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size.fromWidth(120.0)), // Adjust the width as needed
                backgroundColor: MaterialStateProperty.all(Colors.white), // Change the button color to your desired color
                foregroundColor: MaterialStateProperty.all(Colors.blue), // Change the button text color to a contrasting color
              ),
              child: Text('False'),
              onPressed: () => _checkAnswer('false'),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final bool answer;

  Question(this.question, this.answer);
}
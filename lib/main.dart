import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}
class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(      home: QuizHomePage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.purple[900],
      ),
    );
  }
}
class QuizHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/download.jpg', // Change to your image path
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              ' ANSWER THE FOLLOWING QUESIONS, JUST CLICK START BUTTON!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(              onPressed: () {
                Navigator.push(                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );              },
              child: Text('Start Quiz'),
            ),          ],
        ),      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {  int _currentQuestionIndex = 0;
  bool _quizCompleted = false;
  List<String> _feedback = [];
  bool _questionAnswered = false;
  int _correctAnswers = 0;

  List<Map<String, dynamic>> _questions = [
  {
    'questionText': 'What is the capital of Italy?',
    'answers': ['Paris', 'Rome', 'Berlin', 'Madrid'],
    'correctAnswer': 'Rome',
  },
  {
    'questionText': 'What is the powerhouse of the cell?',
    'answers': ['Mitochondria', 'Nucleus', 'Ribosome', 'Endoplasmic reticulum'],
    'correctAnswer': 'Mitochondria',
  },
  {
    'questionText': 'Which programming language is used for Flutter development?',
    'answers': ['Dart', 'Java', 'Python', 'JavaScript'],
    'correctAnswer': 'Dart',
  },
  {
    'questionText': 'What is the main function of a database management system (DBMS)?',
    'answers': [
      'Managing and organizing data',
      'Displaying web content',
      'Running server-side scripts',
      'Creating user interfaces'
    ],
    'correctAnswer': 'Managing and organizing data',
  },
  {
    'questionText': 'What is the capital of Japan?',
    'answers': ['Beijing', 'Tokyo', 'Seoul', 'Bangkok'],
    'correctAnswer': 'Tokyo',
  },
  {
    'questionText': 'Which is the largest ocean on Earth?',
    'answers': ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
    'correctAnswer': 'Pacific Ocean',
  },
  {
    'questionText': 'What is the chemical symbol for gold?',
    'answers': ['Ag', 'Au', 'Cu', 'Fe'],
    'correctAnswer': 'Au',
  },
  {
    'questionText': 'What is the square root of 144?',
    'answers': ['12', '14', '16', '18'],
    'correctAnswer': '12',
  },
  {
    'questionText': 'In which year did World War II end?',
    'answers': ['1939', '1943', '1945', '1950'],
    'correctAnswer': '1945',
  },
  {
    'questionText': 'What is the chemical formula for water?',
    'answers': ['H2O', 'CO2', 'NaCl', 'C6H12O6'],
    'correctAnswer': 'H2O',
  },
  {
    'questionText': 'Which planet is known as the Red Planet?',
    'answers': ['Venus', 'Mars', 'Saturn', 'Jupiter'],
    'correctAnswer': 'Mars',
  },
  {
    'questionText': 'What is the largest organ in the human body?',
    'answers': ['Skin', 'Heart', 'Liver', 'Lungs'],
    'correctAnswer': 'Skin',
  },
  {
    'questionText': 'What is the chemical symbol for iron?',
    'answers': ['Ag', 'Au', 'Cu', 'Fe'],
    'correctAnswer': 'Fe',
  },
  {
    'questionText': 'How many inches are in a foot?',
    'answers': ['10', '12', '14', '16'],
    'correctAnswer': '12',
  },
  {
    'questionText': 'What is the capital of Australia?',
    'answers': ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
    'correctAnswer': 'Canberra',
  },
  {
    'questionText': 'What is the chemical formula for table salt?',
    'answers': ['H2O', 'CO2', 'NaCl', 'C6H12O6'],
    'correctAnswer': 'NaCl',
  },
];

  void _answerQuestion(String selectedAnswer) {    setState(() {
      if (_quizCompleted || _questionAnswered) {
        return;
      }
      if (selectedAnswer == _questions[_currentQuestionIndex]['correctAnswer']) {
        _feedback.add('Correct!');
        _correctAnswers++;      } else {
        _feedback.add(
            'Incorrect! Correct answer: ${_questions[_currentQuestionIndex]['correctAnswer']}');
      }
      _questionAnswered = true;
    });  }

  void _nextQuestion() {    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _feedback.clear();        _questionAnswered = false;
      } else {
        _quizCompleted = true;
      }    });
  }

  void _submitQuestion() {
    setState(() {
      _questionAnswered = true;    });
  }

  void _submitQuiz() {    setState(() {
      _quizCompleted = true;
    });  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _quizCompleted = false;
      _feedback.clear();
      _questionAnswered = false;
      _correctAnswers = 0;
    });  }

@override
  Widget build(BuildContext context) {
    return Scaffold(      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _quizCompleted          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Quiz Completed!',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Score: $_correctAnswers/${_questions.length}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                if (_incorrectlyAnsweredQuestions().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Incorrectly Answered Questions:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _incorrectlyAnsweredQuestions().map((question) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Question: ${question['questionText']}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  'Your Answer: ${question['selectedAnswer']}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Text(
                                  'Correct Answer: ${question['correctAnswer']}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),                          );
                        }).toList(),
                      ),
                    ],
                  ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _restartQuiz,
                  child: Text('Restart Quiz'),
                ),
              ],
            )
          : Container(              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    _questions[_currentQuestionIndex]['questionText'],
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 20.0),
                  ...(_questions[_currentQuestionIndex]['answers']
                          as List<String>)
                      .map((answer) {                    return ElevatedButton(
                      onPressed: () => _answerQuestion(answer),
                      child: Text(answer),
                    );
                  }).toList(),
                  SizedBox(height: 20.0),
                  Text(
                    _feedback.isNotEmpty ? _feedback.last : '',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: () {                           setState(() {
                              _currentQuestionIndex--;
                              _feedback.clear();
                              _questionAnswered = false;
                            });
},
                          child: Text('Previous'),
                        ),
                      ElevatedButton(
                        onPressed: _questionAnswered
                            ? _nextQuestion                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please select an answer.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),                             );                              },                        child: Text(_questionAnswered ? 'Next' : 'Submit'),
                      ),
                      ElevatedButton(                       onPressed: _submitQuiz,
                        child: Text('Finish'),
                      ),
                    ],                  ),
                ],
              ),            ),
    );}

  List<Map<String, dynamic>> _incorrectlyAnsweredQuestions() {
    List<Map<String, dynamic>> incorrectQuestions = [];
    for (int i = 0; i < _questions.length; i++) {      if (_feedback.length > i && !_feedback[i].startsWith('Correct')) {
        incorrectQuestions.add({
          'questionText': _questions[i]['questionText'],
          'correctAnswer': _questions[i]['correctAnswer'],
          'selectedAnswer':
              _feedback[i].replaceFirst('Incorrect! Correct answer: ', ''),
        });      }
    }
    return incorrectQuestions;
  }}
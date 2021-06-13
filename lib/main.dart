import 'package:flutter/material.dart';
import 'question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {


  List<Icon> scorekeeper = [];
  QuestionBrain instance = QuestionBrain();

  void checkAnswer(bool userAnswer){
    setState(() {

      if(instance.isFinished()){
        Alert(context: context, title: "Finished", desc: "You've reached the end.").show();
        instance.reset();
        scorekeeper = [];
      }
      else{
        bool correctAnswer = instance.getQuestionAnswer();
        if(correctAnswer == userAnswer){
          scorekeeper.add(Icon(Icons.check , color: Colors.green, ));}
        else{
          scorekeeper.add(Icon(Icons.close , color: Colors.red, ));
        }

        instance.nextQuestion();
      }


    });
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            flex: 5,
            child: Center(
              child: Text(
               instance.getQuestionText(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,

                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: (){
                  checkAnswer(true);
                },
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: (){
                  checkAnswer(false);
                },
                child: Text(
                  'False',
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: scorekeeper,
          )
        ],
      ),
    );
  }
}

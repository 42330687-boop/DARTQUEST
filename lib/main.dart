import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color backgroundColor = Color(0xFF0B1020);
const Color cardColor = Color(0xFF151D33);
const Color secondaryColor = Color(0xFF1B2742);
const Color primaryColor = Colors.deepPurpleAccent;
const Color successColor = Colors.greenAccent;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DartQuest',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: cardColor,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  const Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

class Stage {
  final String title;
  final String description;
  final IconData icon;
  final List<Question> questions;

  const Stage({
    required this.title,
    required this.description,
    required this.icon,
    required this.questions,
  });
}

final List<Stage> stages = [
  Stage(
    title: 'Dart Basics',
    description: 'Learn the basics of Dart programming',
    icon: Icons.code,
    questions: [
      Question(
        question: 'Which keyword is commonly used to declare a variable?',
        options: ['var', 'print', 'class'],
        correctAnswer: 0,
        explanation: 'var declares a variable in Dart.',
      ),
      Question(
        question: 'Which function prints text to the console?',
        options: ['show()', 'print()', 'display()'],
        correctAnswer: 1,
        explanation: 'print() displays information in the console.',
      ),
    ],
  ),
  Stage(
    title: 'Data Types',
    description: 'Understand variables and data types',
    icon: Icons.data_object,
    questions: [
      Question(
        question: 'Which data type stores whole numbers?',
        options: ['String', 'int', 'bool'],
        correctAnswer: 1,
        explanation: 'int stores whole numbers such as 10 and 25.',
      ),
      Question(
        question: 'Which data type stores true or false?',
        options: ['int', 'String', 'bool'],
        correctAnswer: 2,
        explanation: 'bool stores only true or false.',
      ),
    ],
  ),
  Stage(
    title: 'Operators',
    description: 'Learn mathematical operators',
    icon: Icons.calculate,
    questions: [
      Question(
        question: 'What is the result of 10 + 5?',
        options: ['15', '5', '50'],
        correctAnswer: 0,
        explanation: 'The + operator adds two numbers.',
      ),
      Question(
        question: 'Which operator checks equality?',
        options: ['=', '==', '!='],
        correctAnswer: 1,
        explanation: '== compares two values to check if they are equal.',
      ),
    ],
  ),
  Stage(
    title: 'Conditions',
    description: 'Make decisions using if and else',
    icon: Icons.alt_route,
    questions: [
      Question(
        question: 'Which statement is used for a condition?',
        options: ['if', 'print', 'var'],
        correctAnswer: 0,
        explanation: 'if executes code when a condition is true.',
      ),
      Question(
        question: 'What does 5 > 3 return?',
        options: ['false', '5', 'true'],
        correctAnswer: 2,
        explanation: '5 is greater than 3, so the result is true.',
      ),
    ],
  ),
  Stage(
    title: 'Loops',
    description: 'Repeat code using loops',
    icon: Icons.repeat,
    questions: [
      Question(
        question: 'Which loop is commonly used with a counter?',
        options: ['for', 'if', 'class'],
        correctAnswer: 0,
        explanation: 'A for loop repeats code a specific number of times.',
      ),
      Question(
        question:
            'How many times does this loop run?\n\nfor (int i = 0; i < 3; i++)',
        options: ['2 times', '3 times', '4 times'],
        correctAnswer: 1,
        explanation: 'The loop runs with values 0, 1 and 2: three times.',
      ),
    ],
  ),
  Stage(
    title: 'Functions',
    description: 'Create reusable blocks of code',
    icon: Icons.functions,
    questions: [
      Question(
        question: 'Which keyword means a function returns no value?',
        options: ['void', 'var', 'new'],
        correctAnswer: 0,
        explanation: 'void means the function does not return a value.',
      ),
      Question(
        question: 'How do you call a function named start?',
        options: ['start;', 'start()', 'function start'],
        correctAnswer: 1,
        explanation: 'A function is called using its name and parentheses.',
      ),
    ],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int xp = 0;

  final Set<int> doneStages = {};

  int get openStages => doneStages.length + 1;

  void finishStage(int index, int earnedXP) {
    setState(() {
      if (!doneStages.contains(index)) {
        doneStages.add(index);
        xp += earnedXP;
      }
    });
  }

  void startStage(int index) {
    if (index >= openStages) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          stageIndex: index,
          alreadyCompleted: doneStages.contains(index),
          onStageCompleted: (earnedXP) {
            finishStage(index, earnedXP);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int currentLevel = (xp ~/ 30) + 1;

    double progress = doneStages.length / stages.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DartQuest',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              children: [
                const Icon(Icons.stars, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  '$xp XP',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, Player! 👋',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ready to become a Dart master?',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF302060), Color(0xFF1B2742)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR PROGRESS',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Level $currentLevel - Beginner',
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Learning progress'),
                        Text('${doneStages.length}/${stages.length}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 9,
                        backgroundColor: Colors.white24,
                        color: successColor,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '⭐ $xp XP',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Learning Path',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stage = stages[index];

                    bool isCompleted = doneStages.contains(index);
                    bool isUnlocked = index < openStages;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: isUnlocked ? () => startStage(index) : null,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCompleted
                                  ? successColor
                                  : Colors.white10,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(40),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  stage.icon,
                                  color: isUnlocked
                                      ? primaryColor
                                      : Colors.white38,
                                  size: 27,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Stage ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      stage.title,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      stage.description,
                                      style: const TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isCompleted
                                    ? Icons.check_circle
                                    : isUnlocked
                                    ? Icons.lock_open
                                    : Icons.lock,
                                color: isCompleted
                                    ? successColor
                                    : isUnlocked
                                    ? Colors.white70
                                    : Colors.white38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: doneStages.length == stages.length
                      ? null
                      : () => startStage(doneStages.length),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    doneStages.length == stages.length
                        ? 'ALL STAGES COMPLETED'
                        : 'CONTINUE LEARNING',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final int stageIndex;
  final bool alreadyCompleted;
  final Function(int) onStageCompleted;

  const QuizScreen({
    super.key,
    required this.stageIndex,
    required this.alreadyCompleted,
    required this.onStageCompleted,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;

  int? answer;

  int stageXP = 0;

  bool finished = false;

  Question get question => stages[widget.stageIndex].questions[currentIndex];

  void checkAnswer(int index) {
    setState(() {
      answer = index;

      if (index == question.correctAnswer) {
        stageXP += 10;
      }
    });
  }

  void resetAnswer() {
    setState(() {
      answer = null;
    });
  }

  void next() {
    final lastIndex = stages[widget.stageIndex].questions.length - 1;

    if (currentIndex < lastIndex) {
      setState(() {
        currentIndex++;
        answer = null;
      });
    } else {
      setState(() {
        finished = true;
      });

      if (!widget.alreadyCompleted) {
        widget.onStageCompleted(stageXP);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final stage = stages[widget.stageIndex];

    final bool isCorrect = answer == question.correctAnswer;

    final int totalQuestions = stage.questions.length;

    if (finished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Stage Completed'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, size: 100, color: Colors.amber),
                const SizedBox(height: 20),
                const Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  stage.title,
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
                const SizedBox(height: 25),
                Text(
                  widget.alreadyCompleted
                      ? 'Stage completed again!'
                      : 'You earned $stageXP XP!',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'You answered $totalQuestions questions.',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'BACK TO LEARNING PATH',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Stage ${widget.stageIndex + 1}')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              stage.title.toUpperCase(),
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${currentIndex + 1}/$totalQuestions',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  '⭐ $stageXP XP',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (currentIndex + 1) / totalQuestions,
                minHeight: 8,
                backgroundColor: Colors.white24,
                color: successColor,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CHALLENGE',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Choose your answer:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            ...List.generate(question.options.length, (index) {
              Color buttonColor = secondaryColor;

              if (answer != null) {
                if (index == question.correctAnswer) {
                  buttonColor = Colors.green.shade800;
                } else if (index == answer) {
                  buttonColor = Colors.red.shade800;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: answer == null ? () => checkAnswer(index) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      disabledBackgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color:
                              answer != null && index == question.correctAnswer
                              ? successColor
                              : Colors.white10,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        if (answer != null && index == question.correctAnswer)
                          const Icon(Icons.check_circle, color: successColor),
                        if (answer == index && !isCorrect)
                          const Icon(Icons.cancel, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              );
            }),
            if (answer != null) ...[
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isCorrect
                      ? Colors.green.withAlpha(35)
                      : Colors.red.withAlpha(35),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isCorrect ? successColor : Colors.redAccent,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCorrect
                          ? 'Correct! +10 XP 🎉'
                          : 'Not quite! Try again.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? successColor : Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      question.explanation,
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isCorrect ? next : resetAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    isCorrect
                        ? currentIndex == totalQuestions - 1
                              ? 'FINISH STAGE'
                              : 'NEXT QUESTION'
                        : 'TRY AGAIN',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

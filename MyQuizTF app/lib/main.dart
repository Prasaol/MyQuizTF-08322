import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //TODO: 6.ปรับปรุง UI ตามชอบ โดยนักเรียนอาจเปลี่ยน icon ให้เป็นรูปอื่นนอกจาก check/close ด้วยก็ได้
        backgroundColor: Colors.black,
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  //create an empty list
  //TODO: 1.ปรับปรุงค่าใน scoreKeeper ให้เริ่มต้นเป็นลิสต์ว่าง
  List<Icon> scoreKeeper = [
  ];

  //TODO: 4.ปรับปรุงคำถามและคำตอบที่สอดคล้องกัน โดยให้มีคำถาม-คำตอบอย่างน้อย 5 ข้อ (ไม่รวมข้อสุดท้ายที่ให้กดปุ่มใดๆ) อาจเป็นคำถามใหม่ทั้งหมดก็ได้
  List<String> questions = [
    'เรื่องราวมันเริ่มเมื่อตอนที่พบเครื่องมือเอเลี่ยนประหลาด มันเกาะมือเขาด้วยแรงลึกลับเปลี่ยนแปลงเสียจนเกินคาด \n \n บทเพลงนี่อยู่ในการ์ตูน BEN 10',
    'หนึ่งในวัดชื่อดังของประเทศไทยมีชื่อว่า \n \n "วัดได้ถ้าใจถึง" ',
    'มะยัง ภันเต วิสุง วิสุง รักขะณัตถายะ, ติสะระเณนะ สะหะ ปัญจะ สีลานิ ยาจามะ \n'
        'ทุติยัมปิ มะยัง ภันเต วิสุง วิสุง รักขะณัตถายะ, ติสะระเณนะ สะหะ ปัญจะ สีลานิ ยาจามะ \n'
        'ตะติยัมปิ มะยัง ภันเต วิสุง วิสุง รักขะณัตถายะ, ติสะระเณนะ สะหะ ปัญจะ สีลานิ ยาจามะ \n'
    '\n บทสวดดังกล่าวมีชื่อว่า "สมาทานศีล 5"',
    'หากยิงกระสุนขึ้นฟ้าด้วยความเร็ว 120 m/s ทำมุม 45 องศากับแนวระดับตอน 12:00น ของวันที่ไม่มีเมฆปกคลุม กระสุนจะตกถึงพื้นเวลาเท่าใด \n \n คำถามดังกล่าวเป็นข้อสอบภาษาไทย',
    'หนึ่งในเพลงประจำของมีม GIGACHAD คือ "Can you feel my heart" ของวง Bring Me the Horizon',
    "กดปลุ่มใดๆ เพื่อเริ่มใหม่"
  ];
  List<bool> answers = [true, false, false, true, true, true];
  int questionNumber = 0; //What question are we on?
  int correct = 0;

  void checkQ(bstatus) {
    bool correctAnswer = answers[questionNumber];
    if (correctAnswer == bstatus) { //กรณีที่ตอบถูก
      setState(() {
        //เมื่อกดปุ่ม True เพิ่มข้อมูลเข้าไปในลิสต์ scoreKeeper โดยใช้ add method
        correct++;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        //ตรวจสอบว่าข้อคำถามจะไม่เกิน index
        if (questionNumber < questions.length - 1) {
          questionNumber++;
        } else {
          //TODO: 2.กรณีที่ถ้าคำถามหมดแล้ว ให้เริ่มต้นใหม่ โดยกลับไปที่คำถามเดิม เคลียร์ scoreKeeper และเคลียร์ค่าต่างๆที่เกี่ยวข้อง
          questionNumber = 0;
          scoreKeeper = [];
          correct = 0;
        }
      });
    } else {
      setState(() {
        //TODO: 3.เขียนชุดคำสั่งในกรณีที่ตอบผิด (correctAnswer ไม่เท่ากับ bstatus) แสดง wrong icon + move to next
        scoreKeeper.add(
            Icon(Icons.close, color: Colors.red,)
        );
        if (questionNumber < questions.length - 1) {
          questionNumber++;
        }
        else{
          questionNumber = 0;
          scoreKeeper = [];
          correct = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //TODO: 5.เพิ่ม widget สำหรับแสดงผลคะแนนที่ได้ โดยเริ่มต้นคะแนนเป็น 0 ทั้งนี้ กำหนดให้ตอบถูกต้องในแต่ละข้อจะได้ 1 คะแนน (นักเรียนอาจต้องเขียนโปรแกรมในส่วนอื่นด้วย เพื่อสามารถแสดงผลคะแนนที่ถูกต้อง)
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '${questions[questionNumber]} \n \n คุณทำถูกไปทั้งหมด $correct / 5 ข้อ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal[900],
                ),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkQ(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              // color: Colors.red,
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkQ(false);
              },
            ),
          ),
        ),
        //แสดงผล icon สำหรับ scoreKeeper
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

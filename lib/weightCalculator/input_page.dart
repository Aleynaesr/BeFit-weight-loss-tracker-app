import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weight_loss_tracker/weightCalculator/reuseable_card.dart';
import 'package:weight_loss_tracker/weightCalculator/util/constants.dart';
import 'result_page.dart';
import  'calculator.dart';


enum Gender{male, female}


class InputPage extends StatefulWidget {
  const InputPage({Key key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender activeGender = Gender.male;
  int height = 150;
  int weight = 50;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Body Mass Index Calculator", style: TextStyle(color:Colors.black,
            ),),
          elevation: 0.50,
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      colour: activeGender == Gender.male? kActiveCardColor:kInActiveCardColor,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.mars,size: 50, color: Colors.white,),
                            SizedBox(
                              height: 10,
                            ),
                            Text('MALE', style: kLabelTextStyle,)
                          ]
                      ),
                      onPress: (){
                        setState(() {
                          activeGender = Gender.male;
                        });
                      },

                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: activeGender == Gender.female? kActiveCardColor:kInActiveCardColor,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.venus,size: 50, color: Colors.white,),
                            SizedBox(
                              height: 10,
                            ),
                            Text('FEMALE', style: kLabelTextStyle,)
                          ]
                      ),
                      onPress: (){
                        setState(() {
                          activeGender = Gender.female;
                        });

                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text('cm', style: kLabelTextStyle,),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: kBottomContainerColor,
                        activeTrackColor: Colors.white,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
                        trackHeight: 1,
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 100,
                        max: 220,
                        onChanged: (double value){
                          setState(() {
                            height = value.toInt();
                          });
                        },
                      ),
                    ),
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                  ],
                ),
                onPress: (){},
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('WEIGHT',
                            style: kLabelTextStyle,),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            weight.toString(),
                            style: kNumberTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              RoundIconButton(
                                  icon: Icon(FontAwesomeIcons.minus, color: Colors.white,),
                                  onTap: (){
                                    setState(() {
                                      weight--;
                                    });
                                  }
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RoundIconButton(
                                  icon: Icon(FontAwesomeIcons.plus, color: Colors.white,),
                                  onTap: (){
                                    setState(() {
                                      weight++;
                                    });
                                  }
                              ),

                            ],
                          )
                        ],
                      ),
                      onPress: (){},
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      colour: kActiveCardColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('AGE',
                            style: kLabelTextStyle,),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            age.toString(),
                            style: kNumberTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              RoundIconButton(
                                  icon: Icon(FontAwesomeIcons.minus, color: Colors.white,),
                                  onTap: (){
                                    setState(() {
                                      age--;
                                    });
                                  }
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RoundIconButton(
                                  icon: Icon(FontAwesomeIcons.plus, color: Colors.white,),
                                  onTap: (){
                                    setState(() {
                                      age++;
                                    });
                                  }
                              ),

                            ],
                          )
                        ],
                      ),
                      onPress: (){},
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: ()
              {
                Calculate bmiCalculate = new Calculate(height: height, weight: weight);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultPage(
                            bmiResult: bmiCalculate.calculateBMI(),
                            result: bmiCalculate.getResults(),
                            review: bmiCalculate.getReview())
                    )
                );
              },
              child: Container(
                width: double.infinity,
                height: kBottomContainerHeight,
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(bottom: 5),
                color: kBottomContainerColor,
                child: Center(

                  child: Text('Calculate',
                    style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,
                        fontSize: 25),),
                ),
              ),
            )
          ],
        )
    );
  }
}



class RoundIconButton extends StatelessWidget {

  RoundIconButton({ this.icon,   this.onTap});

  final Icon icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: icon,
      shape: CircleBorder(),
      fillColor: kButtonColor,
      onPressed: ()
      {
        onTap();
      },
      constraints: BoxConstraints.tightFor(
        width: 38,
        height: 38,
      ),
      elevation: 7,
    );
  }
}

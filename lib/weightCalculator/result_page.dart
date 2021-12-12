import 'package:flutter/material.dart';
import 'package:weight_loss_tracker/weightCalculator/reuseable_card.dart';
import 'package:weight_loss_tracker/weightCalculator/util/constants.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    this.bmiResult,
    this.result,
    this.review,
  });

  final String bmiResult;
  final String result;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text('Your Results',style: TextStyle(color:Colors.black,
           )),
        elevation: 0.50,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: ReusableCard(
                onPress: () {},
                colour: kActiveCardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      result.toString(),
                      style: kResultTextStyle,
                    ),
                    Text(
                      bmiResult,
                      style: kBMITextStyle,
                    ),
                    Text(
                      review,
                      style: kBodyTextStyle,
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: kBottomContainerHeight,
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.only(bottom: 5),
              color: kBottomContainerColor,
              child: Center(
                child: Text(
                  'RE-Calculate',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color:Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

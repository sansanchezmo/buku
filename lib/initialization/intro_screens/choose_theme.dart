import 'package:buku/themes/current_theme.dart';
import 'package:buku/widget/gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseTheme extends StatefulWidget{

  _ChooseThemeState createState() => _ChooseThemeState();

}

class _ChooseThemeState extends State<ChooseTheme>{
  String selectedRadio;
  @override
  void initState() {
    super.initState();
    selectedRadio = 'orange';
  }

  setSelectedRadio(String radio){
    setState(() {
      selectedRadio = radio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: CurrentTheme.primaryGradientColor,
      ),
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          /*Image(
            image: AssetImage('assets/images/bukusymbol.png'),
            alignment: Alignment.topLeft,
            width: 50.0,
            height: 50.0,
          ),*/
          SizedBox(
            height: 70,
          ),
          Expanded(
            child: Container(
              //color: Colors.white,
                padding: EdgeInsets.only(top: 60, left: 30, right: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: CurrentTheme.background,
                    boxShadow: [BoxShadow(
                        color: CurrentTheme.shadow1,
                        blurRadius: 20,
                        offset: Offset(0,0)
                    ),],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      //topRight: Radius.circular(40.0),
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50,),
                    Text('Choose theme',
                    style: TextStyle(
                      color: CurrentTheme.textColor1,
                      fontSize: 40
                    ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'How would you like to see Buku interface',
                      style: TextStyle(
                        color: CurrentTheme.textColor1,
                        fontSize: 18
                      ),
                    ),
                    SizedBox(height: 100,),
                    Container( //TODO: check radio group
                      height: 200,
                      padding: EdgeInsets.only(left: 20),
                      //alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CurrentTheme.backgroundContrast,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        boxShadow: [BoxShadow(
                          color: CurrentTheme.shadow2, blurRadius: 10, spreadRadius: 10
                        )]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 'orange',
                                groupValue: selectedRadio,
                                activeColor: CurrentTheme.primaryColor,
                                autofocus: true,
                                onChanged: (val){
                                  CurrentTheme.setTheme(val);
                                  setSelectedRadio(val);
                                },
                              ),
                              GestureDetector(
                                  onTap: (){
                                    CurrentTheme.setTheme('orange');
                                    setSelectedRadio('orange');
                                  },
                                  child: Text(
                                    'Orange',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: CurrentTheme.textColor2
                                    ),
                                  )
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'dark',
                                groupValue: selectedRadio,
                                activeColor: CurrentTheme.primaryColor,
                                onChanged: (val){
                                  CurrentTheme.setTheme(val);
                                  setSelectedRadio(val);
                                },
                              ),
                              GestureDetector(
                                onTap: (){
                                  CurrentTheme.setTheme('dark');
                                  setSelectedRadio('dark');
                                },
                                  child: Text(
                                    'Dark',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: CurrentTheme.textColor2
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
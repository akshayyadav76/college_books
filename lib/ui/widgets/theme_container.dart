




import 'package:college_books/data/provider/theme_provider.dart';
import 'package:college_books/ui/theme/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeContainer extends StatelessWidget {
  final colorName;
  final Color color;


  const ThemeContainer({this.colorName,this.color});
  @override
  Widget build(BuildContext context) {
    final themeProvider= Provider.of<ThemeProvider>(context,listen: false);
    return GestureDetector(
      onTap: (){
        if("Dark"== colorName){
      themeProvider.setTheme(ThemeConst.darkTheme,colorName);
      print("dark");
        }else if("Light"== colorName){
          themeProvider.setTheme(ThemeConst.lightTheme,colorName);
        }
      },
      child: Column(
        children:[
           Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: [ BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),],
                      color: color
                    ),
                  ),
                  Text(colorName)
                  ]
      ),
    );
  }
}
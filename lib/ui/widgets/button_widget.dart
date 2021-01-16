import 'package:college_books/constant/globals.dart';
import 'package:flutter/material.dart';
import '../theme/extention.dart';




class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function onTap;
  final String icon;

  ButtonWidget({this.title, this.hasBorder, this.onTap,this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
                  color: Theme.of(context).accentColor,
                  width: 1.0,
                )
             // : Border.fromBorderSide(BorderSide.none),
        ),
        child: Row(
          children: [
           icon ==null ?SizedBox.shrink(): Image.asset(icon,width: 50,height: 45,),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 20.0.h,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: hasBorder ? Theme.of(context).accentColor : Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0.sp,
                      ),
                    ),
                  ),
                ),
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

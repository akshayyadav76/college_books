import 'package:college_books/constant/globals.dart';
import 'package:flutter/material.dart';




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
          color: hasBorder ? Global.white : Global.mediumBlue,
          borderRadius: BorderRadius.circular(20),
          border: hasBorder
              ? Border.all(
                  color: Global.mediumBlue,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: Row(
          children: [
           icon ==null ?SizedBox.shrink(): Image.asset(icon,width: 50,height: 45,),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 45.0,
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: hasBorder ? Global.mediumBlue : Global.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
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

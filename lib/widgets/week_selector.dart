import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_web_dashboard/cubits/states.dart';
import 'package:pizza_web_dashboard/cubits/ui/cubit_week_selector.dart';

class WeekSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitWeekSelector, WeekSelectorGenericState>(
      builder: (context, state) => (state is WeekSelectorGenericState)
          ? Container(
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     border: Border(
              //         bottom: BorderSide(
              //   color: Colors.grey[400]!,
              //   width: 0.3,
              // ))),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: state.isBeforeButtonEnabled
                      ? () => BlocProvider.of<CubitWeekSelector>(context)
                          .decrement()
                      : null,
                  icon: Icon(Icons.navigate_before_outlined,
                      color: state.isBeforeButtonEnabled
                          ? Colors.grey
                          : Colors.grey[100]),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 50,
                  //color: Colors.red,
                  child: Center(
                    child: Text(state.text,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                  ),
                ),
                IconButton(
                  onPressed: state.isNextButtonEnabled
                      ? () => BlocProvider.of<CubitWeekSelector>(context)
                          .increment()
                      : null,
                  icon: Icon(Icons.navigate_next_outlined,
                      color: state.isNextButtonEnabled
                          ? Colors.grey
                          : Colors.grey[100]),
                )
              ],
            ))
          : Container(), //Center(child: Text(ErrorMessages.errorGeneric)),
    );
  }
}

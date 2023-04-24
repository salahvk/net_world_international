import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:net_world_international/application/loginBloc/login_bloc.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text('Log Out ?',
                style: getRegularStyle(color: Colors.black, fontSize: 15)),
            const SizedBox(height: 8.0),
            Text('Are you sure you want to log out?',
                style: getLightStyle(color: Colormanager.mainTextColor)),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                            color: Colormanager.primary, width: .5),
                      ),
                      backgroundColor: const Color(0xffEFF7FF),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colormanager.textColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // Dismiss the dialog with a false value
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0), // Set your desired border radius value here
                    )),
                    onPressed: () async {
                      await Hive.box("token").clear();

                      BlocProvider.of<LoginBloc>(context).add(
                        NavigateToHomeScreenEvent(),
                      );
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

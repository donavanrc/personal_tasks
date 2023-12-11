import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.black54,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Loading",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
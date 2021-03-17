import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Text(
                "Multilevel marketing (MLM) is a strategy that some direct sales companies use to encourage existing distributors to recruit new distributors. In MLM schemes, there can be hundreds or thousands of members worldwide, but relatively few earn meaningful incomes from their efforts, indicating a possible pyramid scheme."),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infinite_horizons/presentation/molecules/molecules.dart';
import 'package:infinite_horizons/presentation/pages/pages.dart';

void backToHomePopup(BuildContext context) {
  openAlertDialog(
    context,
    const SizedBox(
      height: 150,
      child: PageEnclosureMolecule(
        title: 'Exit Session',
        subTitle: 'Navigate back to Home Page?',
        expendChild: false,
        child: SizedBox(),
      ),
    ),
    onConfirm: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    },
  );
}

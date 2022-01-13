import 'dart:math';

import 'package:finances/models/category.dart';
import 'package:flutter/material.dart';

TextButton getIcon(Category category) {
    return TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
              backgroundColor: category.id > 12 ? Colors.primaries[Random().nextInt(12)] :
                Colors.primaries[category.id],
              shape: const CircleBorder(),
            ),
            child: Icon(
              IconData(category.icon, fontFamily: 'MaterialIcons'),
              color: Colors.white,
              size: 30,
            ));
  }
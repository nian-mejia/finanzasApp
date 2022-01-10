import 'dart:math';

import 'package:finances/models/category.dart';
import 'package:flutter/material.dart';

TextButton getIcon(List<Category> categories, int index) {
    return TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: index > 12 ? Colors.primaries[Random().nextInt(12)] :
                      Colors.primaries[index],
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    IconData(categories[index].icon, fontFamily: 'MaterialIcons'),
                    color: Colors.white,
                    size: 30,
                  ));
  }
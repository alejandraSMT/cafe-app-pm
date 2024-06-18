import 'package:flutter/material.dart';

class Options{
  final String title;
  final IconData icon;
  final String? route;

  Options({
    required this.title,
    required this.icon,
    this.route
  });
}
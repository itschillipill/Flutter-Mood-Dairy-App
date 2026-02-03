import 'dart:async' show runZonedGuarded;

import 'package:flutter/material.dart';

import 'presentation/app.dart';

void main() => runZonedGuarded(
      () => runApp(const App()),
      (error, stack) {
        // handle error
      },
    );

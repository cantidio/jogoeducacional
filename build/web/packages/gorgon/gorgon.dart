/**
 * Copyright (C) 2013 Cantidio Fontes
 * For conditions of distribution and use, see copyright notice in LICENSE.txt
 *
 * This library contains a set of classes that let you create a 2d game.
 */
library gorgon;
import 'dart:core';
import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'dart:web_audio';

// Graphic module
part 'src/graphic/point2d.dart';
part 'src/graphic/display.dart';
part 'src/graphic/font_alignment.dart';
part 'src/graphic/font.dart';
part 'src/graphic/mirroring.dart';
part 'src/graphic/color.dart';
part 'src/graphic/sprite.dart';
part 'src/graphic/spritepack.dart';
part 'src/graphic/frame.dart';
part 'src/graphic/animation.dart';
part 'src/graphic/animationpack.dart';
part 'src/graphic/animator.dart';

// Audio module
part 'src/audio/audio_instance.dart';
part 'src/audio/sound.dart';
part 'src/audio/audio_channel.dart';
part 'src/audio/audio_system.dart';

// Input module
part 'src/input/keyboard.dart';
part 'src/input/mouse.dart';

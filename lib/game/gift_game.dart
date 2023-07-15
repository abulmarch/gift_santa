import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:gift_santa/components/background_components.dart';
import 'package:gift_santa/components/santa_components.dart';
import 'package:gift_santa/constants/global.dart';
import 'package:gift_santa/inputs/joystick.dart';

import '../components/gift_component.dart';

class GiftGrabGame extends FlameGame with HasDraggables, HasCollisionDetection {
  int score = 0;
  @override
  Future onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(SantaComponent(joystick: joystick));
    add(joystick);
    add(GiftComponent());

    FlameAudio.audioCache.loadAll([Globals.itemGrabSound]);
  }
}

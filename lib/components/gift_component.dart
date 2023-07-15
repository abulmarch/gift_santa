import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:gift_santa/components/santa_components.dart';
import 'package:gift_santa/constants/global.dart';
import 'package:gift_santa/game/gift_game.dart';

class GiftComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double spriteHeight = 150;
  final Random random = Random();
  @override
  Future onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.giftsprite);
    height = width = spriteHeight;
    position = Vector2(x, y);
    anchor = Anchor.center;

    //add circlehitbox to let know collision taken place
    gameRef.add(CircleHitbox());
  }

  //collision method
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is SantaComponent) {
      //playe audio
      FlameAudio.play(Globals.itemGrabSound);

      //remove gift component from game
      removeFromParent();

      //update score
      gameRef.score += 1;

      //add new gift component
      add(GiftComponent());
    }
  }

  //gift at random position
  Vector2 getRandomPosition() {
    double x = random.nextInt(gameRef.size.x.toInt()).toDouble();
    double y = random.nextInt(gameRef.size.y.toInt()).toDouble();
    return Vector2(x, y);
  }
}

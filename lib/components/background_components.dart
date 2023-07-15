import 'package:flame/components.dart';
import 'package:gift_santa/constants/global.dart';
import 'package:gift_santa/game/gift_game.dart';

class BackgroundComponent extends SpriteComponent
    with HasGameRef<GiftGrabGame> {
  @override
  Future onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.backgroundsprite);
    size = gameRef.size;
  }
}

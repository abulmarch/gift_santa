import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gift_santa/constants/global.dart';
import 'package:gift_santa/game/gift_game.dart';

//movements of santa
enum MovementState {
  idle,
  slideleft,
  slideright,
}

class SantaComponent extends SpriteGroupComponent<MovementState>
    with HasGameRef<GiftGrabGame> {
  final double spriteHeight = 150;
  final double speed = 500;

  //boundary for movement of santa
  late double rightbound;
  late double leftbound;
  late double upbound;
  late double downbound;

  //pass joystick to santa
  JoystickComponent joystick;
  SantaComponent({required this.joystick});

  @override
  Future onLoad() async {
    await super.onLoad();

    Sprite santaIdle = await gameRef.loadSprite(Globals.santaIdlesprite);
    Sprite santaSlideLeft = await gameRef.loadSprite(Globals.santaLeftsprite);
    Sprite santaSlideRight = await gameRef.loadSprite(Globals.santaRightsprite);

    //defining sprit eproperty
    sprites = {
      MovementState.idle: santaIdle,
      MovementState.slideleft: santaSlideLeft,
      MovementState.slideright: santaSlideRight,
    };

    //defining bounds for santa

    rightbound = gameRef.size.x - 45;
    leftbound = 45;
    upbound = 55;
    downbound = gameRef.size.y - 85;

    //current position of santa, inbuilt sprite
    current = MovementState.idle;

    position = gameRef.size / 2;
    height = spriteHeight;
    width = spriteHeight * 1.42;
    anchor = Anchor.center;

    //add circlehitbox to let know collision taken place
    add(CircleHitbox());
  }

  //any update of movement through this function
  @override
  void update(dt) {
    super.update(dt);

    if (joystick.direction == JoystickDirection.idle) {
      current = MovementState.idle;
      return;
    }

    if (x >= rightbound) {
      x = rightbound - 1;
    }
    if (x >= leftbound) {
      x = leftbound + 1;
    }
    if (y <= upbound) {
      y = upbound + 1;
    }
    if (y >= downbound) {
      y = downbound - 1;
    }
    //check direction of santa
    bool movingLeft = joystick.relativeDelta[0] < 0;
    if (movingLeft) {
      current = MovementState.slideleft;
    } else {
      current = MovementState.slideright;
    }

    //update position
    position.add(joystick.relativeDelta * speed * dt);
  }
}

import 'dart:html';
import 'dart:math' show Random;
import 'engine/engine.dart';
import 'dot.dart';

void main() {
  final GameEngine engine = new GameEngine(querySelector("#dart_canvas"));
  engine.setInfoBox(querySelector("#fps"));
  engine.registerDrawableEntities(generateDrawables(engine.width, engine.height));
  engine.run();
}

List<Dot> generateDrawables(final int width, final int height) {
  final List<Dot> dots = new List<Dot>();
  final indexGen = new Random();
  for (int i = 0; i < 400; i++) {
    dots.add(new Dot(indexGen.nextDouble() * width, 
                     indexGen.nextDouble() * height,
                     indexGen.nextDouble() * 5));
  }
  return dots;
}
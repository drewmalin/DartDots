import 'dart:html';
import 'dart:math';
import 'entity/entity.dart';

class Dot implements DrawableEntity, ClickableEntity {
  double _x;
  double _y;
  double _r;
  String _color;
  bool _state;
  final double _speed = .5;
  Random _indexGen;
  
  Dot(final double x, final double y, final double r) {
    _x = x;
    _y = y;
    _r = r;
    _color = "red";
    _indexGen = new Random();
    _state = true;
  }
  
  @override draw(final CanvasRenderingContext2D context) {
    context..lineWidth = 0.5
           ..fillStyle = _color
           ..strokeStyle = _color;
    
    context..beginPath()
           ..arc(_x, _y, _r, 0, PI * 2, false)
           ..fill();
  }
  
  @override update() {
    _x += (_indexGen.nextDouble() * _speed) - (_speed / 2);
    _y += (_indexGen.nextDouble() * _speed) - (_speed / 2);
  }
  
  @override isClicked(final int x, final int y) {
    int space = 10;
    if (x >= (_x-space) && x <= (_x+space)) {
      if (y >= (_y-space) && y <= (_y+space)) {
        return true;
      }
    }
    return false;
  }
  
  @override onClick() {
    if (_state) {
      _color = "blue";
      _state = false;
    } else {
      _color = "red";
      _state = true;
    }
  }
}
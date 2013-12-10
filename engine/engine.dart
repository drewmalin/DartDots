library engine;

import 'dart:html';
import '../entity/entity.dart';

class GameEngine {
  CanvasRenderingContext2D _context;
  Element _fpsTextBox;
  List<DrawableEntity> _drawables;
  int _width;
  int _height;
  int _fps;
  int _lastRenderTime;
  
  GameEngine(final CanvasElement canvas) {
    _init(canvas);
    _registerKeyListeners(canvas);
  }
  
  void _init(final CanvasElement canvas) {
    _context = canvas.context2D;
    _width = canvas.parent.client.width;
    _height = canvas.parent.client.height;
    _fps = _lastRenderTime = 0;
    _drawables = new List<DrawableEntity>();
  }
  
  void _registerKeyListeners(final CanvasElement canvas) {
    canvas.addEventListener('click', _onClick, false);
  }
  
  void _onClick(MouseEvent e) {
    for (final ClickableEntity de in _drawables) {
      if (de.isClicked(e.offset.x, e.offset.y)) {
        de.onClick();
      }
    }
  }
  
  void registerDrawableEntities(List<DrawableEntity> drawables) {
    _drawables.addAll(drawables);
  }
  
  void _draw(num _) {
    _calculateFPS();
    _drawBackground();
    _drawDrawables();
    _requestRedraw();
    _updateDrawables();
  }
  
  void _drawBackground() {
    _context.clearRect(0, 0, _width, _height);
    _fpsTextBox.text = "FPS: $_fps";
  }
  
  void _drawDrawables() {
    for (final DrawableEntity de in _drawables) {
      de.draw(_context);
    }
  }
  
  void _updateDrawables() {
    for (final DrawableEntity de in _drawables) {
      de.update();
    }
  }
  
  void _requestRedraw() {
    window.requestAnimationFrame(_draw);
  }
  
  void run() {
    _requestRedraw();
  }
  
  void setInfoBox(final Element infoBox) {
    _fpsTextBox = infoBox;
  }
  
  void _calculateFPS() {
    int currentTime = new DateTime.now().millisecondsSinceEpoch;
    if (_lastRenderTime != 0) {
      _fps = (1000 ~/ (currentTime - _lastRenderTime));
    }
    _lastRenderTime = currentTime;
  }
  
  int get width => _width;
  int get height => _height;
}
// Drawbot Logo

// A bare bones logo like thing for drawing turtle trails. Maybe they'd be fun to have the Drawbot draw.


Turtle mainTurtle;

void setup()
{
	size(800, 400);
	frameRate(10);
	mainTurtle = new Turtle();
	mainTurtle.moveTo(width * .5, height * .5);
	drawOnce();
}

void draw()
{
	if(mousePressed){
		drawOnce();
	}
}

void drawOnce()
{
	//zigZag(mainTurtle, 15, 8, radians(45));
	//mainTurtle.rotateBy(5 * (frameCount % 4));
	background(230);
	
	float boxW=100;
	float boxH=100;
	float boxX=(width-boxW)/2;
	float boxY=(height-boxH)/2;
	float rows = 4;
	float cols = 4;
	float w = boxW/cols;
	float h = boxH/rows;
	

	mainTurtle.setVisible(true);
	for(int r=0; r<rows; r++){
		for(int c=0; c<cols; c++){	
			block(mainTurtle, boxX + (c*w), boxY + (r*h), w, h, (c+r)%2, random(.05, .7));
		}
	}

	mainTurtle.moveTo(width * .5, height * .5);
	mainTurtle.rotateTo(radians(270));
	float delta = random(-.5, .5);
	for (int i = 0; i < 100; i++){
		delta += random(-.1, .1);
		if (delta < -1){
			delta += .2;
		}
		if (delta > 1){
			delta -= .2;
		}
		//! HIDING MAIN LINE
		mainTurtle.setVisible(false);
		mainTurtle.forwardLine(10);
		mainTurtle.rotateBy(delta);
		mainTurtle.setVisible(true);
		Turtle zigTurtle = mainTurtle.clone();
		int dir=1;
		if(i%2==0) dir = -1;
		zigZag(zigTurtle, 4, 6, zigTurtle.a + (radians(90) * dir));
	}
}

void zigZag(Turtle _turtle, float _segmentCount, float _segLength, float _segAngle)
{
	// _mainTurtle.rotateTo(_startAngle);
	_turtle.rotateBy(_segAngle);
	_turtle.forwardLine(_segLength * .5);
	int dir = 1;
	for (int i = 0; i < _segmentCount; i++) {
		dir = (i % 2 == 0) ? 1 : -1;
		_turtle.rotateBy(_segAngle * 2 * dir);
		_turtle.forwardLine(_segLength);
		
	}
	_turtle.rotateBy(_segAngle * -dir);
	_turtle.forwardLine(_segLength * .5);
}

void block(Turtle _turtle, float _x, float _y, float _width, float _height, int _dir, float _density)
{
	//space the lines out based on the density 1 being very very full/close together
	_density = clamp(abs(_density), 0.01, 1);
	float spacing = 0; //space between lines
	//*
	if(_dir == 0){
		//horizontal
		spacing = _height / (_height*_density);
		_turtle.rotateToDeg(0);
		for(int line = 0; line < _height/spacing; line++){
			_turtle.moveTo(_x, _y + (line*spacing));
			_turtle.forwardLine(_width);
		}
	}else{
		//vertical
		spacing = _width / (_width*_density);
		_turtle.rotateToDeg(90);
		for(int line = 0; line < _width/spacing; line++){
			_turtle.moveTo(_x + (line * spacing), _y);
			_turtle.forwardLine(_height);
		}
	}
	//*/

}

float clamp(float _val, float _min, float _max)
{
	if(_val < _min){
		return _min;
	}else if(_val > _max){
		return _max;
	}
	return _val;
}
// Drawbot Logo

// A bare bones logo like thing for drawing turtle trails. Maybe they'd be fun to have the Drawbot draw.


Turtle mainTurtle;

void setup()
{
	size(625, 350);
	frameRate(10);
	mainTurtle = new Turtle();
	mainTurtle.moveTo(width * .5, height * .5);

}

void draw()
{
	/*
	mainTurtle.forwardLine(100);
	mainTurtle.rotateBy(5);
	mainTurtle.forwardLine(10);
	mainTurtle.rotateBy(180);
	*/

	zigZag(mainTurtle, 15, 8, radians(45));
	mainTurtle.rotateBy(5 * (frameCount % 4));

	
}

void zigZag(Turtle _mainTurtle, float _segmentCount, float _segLength, float _segAngle)
{
	// _mainTurtle.rotateTo(_startAngle);
	_mainTurtle.rotateBy(_segAngle);
	_mainTurtle.forwardLine(_segLength * .5);
	int dir = 1;
	for (int i = 0; i < _segmentCount; i++) {
		dir = (i % 2 == 0) ? 1 : -1;
		_mainTurtle.rotateBy(_segAngle * 2 * dir);
		_mainTurtle.forwardLine(_segLength);
	}
	_mainTurtle.rotateBy(_segAngle * -dir);
	_mainTurtle.forwardLine(_segLength * .5);
}
// Drawbot Logo

// A bare bones logo like thing for drawing turtle trails. Maybe they'd be fun to have the Drawbot draw.


Turtle mainTurtle;
int currLoop;
void setup()
{
	size(625, 350);
	frameRate(10);
	mainTurtle = new Turtle();
	mainTurtle.moveTo(width * .5, height * .5);
	currLoop=0;
}

void draw()
{
	/*
	mainTurtle.forwardLine(100);
	mainTurtle.rotateBy(5);
	mainTurtle.forwardLine(10);
	mainTurtle.rotateBy(180);
	*/

	zigZag(mainTurtle.a, 5, 18, 90);
	mainTurtle.rotateBy(5 * (currLoop%4));
	currLoop++;
}

void zigZag(float _startAngle, float _segmentCount, float _segLength, float _segAngle)
{
	mainTurtle.rotateTo(_startAngle);
	mainTurtle.rotateBy(_segAngle);
	mainTurtle.forwardLine(_segLength*.5);
	int dir = 1;
	for(int i=0; i<_segmentCount; i++){
		dir = (i%2==0) ? 1 : -1;
		mainTurtle.rotateBy( _segAngle * 2 * dir );
		mainTurtle.forwardLine(_segLength);
	}
	mainTurtle.rotateBy(_segAngle * -dir);
	mainTurtle.forwardLine(_segLength*.5);
}
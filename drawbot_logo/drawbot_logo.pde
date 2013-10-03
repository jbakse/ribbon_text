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
	mainTurtle.forwardLine(100);
	mainTurtle.rotateBy(5);
	mainTurtle.forwardLine(10);
	mainTurtle.rotateBy(180);
}
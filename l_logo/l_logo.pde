// Drawbot Logo

// A bare bones logo like thing for drawing turtle trails. Maybe they'd be fun to have the Drawbot draw.


L_Set lSet;

Turtle mainTurtle;

float unitSize=20;

void setup()
{
	size(800, 400);
	frameRate(10);
	mainTurtle = new Turtle();
	mainTurtle.moveTo(width * .5, height * .5);
	drawOnce();

	lSet = new L_Set();


	L_Symbol a = new L_Symbol();
	a.name = "a";
	a.callback = new L_Callback(){
		public void call(Turtle t) {
			spiralClockwise(t);
		}
	};

	L_Symbol b = new L_Symbol();
	b.name = "b";
	b.callback = new L_Callback(){
		public void call(Turtle t) {
			spiralClockwise(t);
		}
	};

 	L_Rule rule1 = new L_Rule();
 	rule1.search.add(a.clone());
 	rule1.replace.add(a.clone());
 	rule1.replace.add(b.clone());


 	L_Rule rule2 = new L_Rule();
 	rule2.search.add(b.clone());
 	rule2.replace.add(a.clone());
 	

 	lSet.symbols.add(a.clone());
	lSet.symbols.add(b.clone());
	lSet.rules.add(rule1);
	lSet.rules.add(rule2);

	for (int i = 0; i < 4; i++){
		println(lSet);
		lSet.step();
	}
}

void draw()
{
	if(mousePressed){
		drawOnce();
	}
}

void drawOnce()
{	
	figureS(mainTurtle);
	//*
	loopdy(mainTurtle);
	leftL(mainTurtle);
	//mainTurtle.rotateTo(radians(random(0, 180)));
	//mainTurtle.forwardLine(unitSize);
	diamondSmall(mainTurtle);
	
	spiralClockwise(mainTurtle);
	rightL(mainTurtle);
	diamondLarge(mainTurtle);
	spiralCounterClockwise(mainTurtle);

	rightL(mainTurtle);
	rightL(mainTurtle);
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


//SIMPLE COMMANDS
void spiralClockwise(Turtle _turtle)
{
	spiral(_turtle, 1);
}
void spiralCounterClockwise(Turtle _turtle)
{
	spiral(_turtle, -1);
}

void diamondSmall(Turtle _turtle)
{
	diamond(_turtle, .5);
}

void diamondLarge(Turtle _turtle)
{
	diamond(_turtle, 1);
}

void rightL(Turtle _turtle)
{
	_turtle.forwardLine(unitSize*.5);
	_turtle.rotateBy(radians(90));
	_turtle.forwardLine(unitSize*.5);
}

void leftL(Turtle _turtle)
{
	_turtle.forwardLine(unitSize*.5);
	_turtle.rotateBy(radians(-90));
	_turtle.forwardLine(unitSize*.5);
}

void loopdy(Turtle _turtle)
{
	_turtle.forwardLine(unitSize*.2);
	float steps = 12;
	for(float i=0; i<360; i+=360/steps){
		_turtle.rotateBy(radians(360/steps));
		_turtle.forwardLine(unitSize*.5);
	}
	_turtle.forwardLine(unitSize*.2);
}

void figureS(Turtle _turtle){
	float curSin = 0;
	float steps = 12;
	for(int i=0; i<steps; i++){
		_turtle.rotateBy(sin(curSin));
		_turtle.forwardLine(unitSize*.3);
		curSin +=.5;
	}
}

//COMMANDS
void spiral(Turtle _turtle, int dir)
{
	float spiralSize = 37;
	for(int i=0; i<spiralSize; i++){
		_turtle.rotateBy(radians(i*1.2)*dir);
		_turtle.forwardLine(unitSize*.5);
	}
}
void diamond(Turtle _turtle, float _size)
{
	_turtle.rotateBy(radians(-45));
	_turtle.forwardLine(unitSize*_size);
	for(int i = 0; i<3; i++){
		_turtle.rotateBy(radians(90));
		_turtle.forwardLine(unitSize*_size);
	}
	//move to the other side of the diamond
	for(int i = 0; i<2; i++){
		_turtle.rotateBy(radians(90));
		_turtle.forward(unitSize*_size);
	}
	//rotate back the right direction
	_turtle.rotateBy(radians(-45));
}
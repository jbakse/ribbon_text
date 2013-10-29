import processing.pdf.*;

// Drawbot Logo

// A bare bones logo like thing for drawing turtle trails. Maybe they'd be fun to have the Drawbot draw.


L_Set lSet;

Turtle mainTurtle;

float unitSize = 20;

void setup()
{
    size(800, 800);
    frameRate(10);
   
    mainTurtle = new Turtle();
    mainTurtle.moveTo(width * .5, height * .5);
    // drawOnce();

    lSet = new L_Set();


    L_Symbol f = new L_Symbol();
    f.name = "f";
    f.callback = new L_Callback()
    {
        public void call(Turtle t)
        {
            forward(t);
        }
    };

    L_Symbol l = new L_Symbol();
    l.name = "l";
    l.callback = new L_Callback()
    {
        public void call(Turtle t)
        {
            left(t);
        }
    };

    L_Symbol r = new L_Symbol();
    r.name = "r";
    r.callback = new L_Callback()
    {
        public void call(Turtle t)
        {
            right(t);
        }
    };



    L_Rule rule1 = new L_Rule();
    rule1.search.add(f.clone());
    rule1.search.add(f.clone());
    rule1.replace.add(l.clone());
    rule1.replace.add(f.clone());
    rule1.replace.add(f.clone());
    rule1.replace.add(f.clone());
    lSet.rules.add(rule1);

    L_Rule rule2 = new L_Rule();
    rule2.search.add(l.clone());
    rule2.search.add(f.clone());
    rule2.replace.add(r.clone());
    rule2.replace.add(l.clone());
    lSet.rules.add(rule2);


    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());
    lSet.symbols.add(f.clone());






    lSet.step();
    drawOnce();
}

void draw()
{


}
void mousePressed()
{
    lSet.step();
    drawOnce();
}

void keyPressed(){
     beginRecord(PDF, "turtle.pdf"); 
     drawOnce();
     endRecord();
}

void drawOnce()
{
	background(255);
	scale(.5);

	mainTurtle.moveTo(width*.5, height*.5);
	mainTurtle.rotateTo(0);
	
    lSet.run();
    rect(10, 10, 10, 10);
}

float clamp(float _val, float _min, float _max)
{
    if (_val < _min)
    {
        return _min;
    }
    else if (_val > _max)
    {
        return _max;
    }
    return _val;
}


void forward(Turtle _turtle)
{
    _turtle.forwardLine(5);
}

void left(Turtle _turtle)
{
    _turtle.rotateBy(10);
}


void right(Turtle _turtle)
{
    _turtle.rotateBy(10);
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
    _turtle.forwardLine(unitSize * .5);
    _turtle.rotateBy(radians(30));
    _turtle.forwardLine(unitSize * .5);
}

void leftL(Turtle _turtle)
{
    _turtle.forwardLine(unitSize * .5);
    _turtle.rotateBy(radians(-30));
    _turtle.forwardLine(unitSize * .5);
}

void loopdy(Turtle _turtle)
{
    _turtle.forwardLine(unitSize * .2);
    float steps = 12;
    for (float i = 0; i < 360; i += 360 / steps)
    {
        _turtle.rotateBy(radians(360 / steps));
        _turtle.forwardLine(unitSize * .5);
    }
    _turtle.forwardLine(unitSize * .2);
}

void figureS(Turtle _turtle)
{
    float curSin = 0;
    float steps = 12;
    for (int i = 0; i < steps; i++)
    {
        _turtle.rotateBy(sin(curSin));
        _turtle.forwardLine(unitSize * .3);
        curSin += .5;
    }
}

//COMMANDS
void spiral(Turtle _turtle, int dir)
{
    float spiralSize = 37;
    for (int i = 0; i < spiralSize; i++)
    {
        _turtle.rotateBy(radians(i * 1.2) * dir);
        _turtle.forwardLine(unitSize * .5);
    }
}
void diamond(Turtle _turtle, float _size)
{
    _turtle.rotateBy(radians(-45));
    _turtle.forwardLine(unitSize * _size);
    for (int i = 0; i < 3; i++)
    {
        _turtle.rotateBy(radians(90));
        _turtle.forwardLine(unitSize * _size);
    }
    //move to the other side of the diamond
    for (int i = 0; i < 2; i++)
    {
        _turtle.rotateBy(radians(90));
        _turtle.forward(unitSize * _size);
    }
    //rotate back the right direction
    _turtle.rotateBy(radians(-45));
}
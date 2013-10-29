import processing.pdf.*;
Turtle mainTurtle;
void setup()
{
    size(1000, 1000);

    mainTurtle = new Turtle();
    mainTurtle.moveTo(width * .5, height * .5);
    noLoop();
    beginRecord(PDF, "turtle.pdf");
    play1();
    endRecord();
}

void draw()
{
}
void play1()
{
	int dir = 1;
    for (float a = 0;  a < 1; a += .0001)
    {
    	if (dir == 1) {
    		dir = -1;
    	} else {
    		dir = 1;
    	}
    	
    	mainTurtle.rotateBy(sin(a*6.25*10) + .01);
    	mainTurtle.forwardLine(4);

    	float bMax = 3;
        for (float b = 0;  b < bMax; b++)
        {
            mainTurtle.forwardLine(2);
            mainTurtle.rotateBy((6.282 / bMax));
        }

    }
}
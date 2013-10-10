ArrayList<Point> points;
Point sample;
void setup()
{
    size(500, 500);
    stroke(255, 255, 255, 50);

    reset();
}

void mousePressed() {
	reset();
}

void reset()
{
    background(0);

    points = new ArrayList<Point>();
    float pCount = random(3, 4);
    for (int i = 0; i < pCount; i++)
    {
    	float x = random(width);
    	float y = random(height);
    	float spread = 20;
        points.add(new Point(x, y));
        points.add(new Point(x + spread, y + spread));

    }

    // points.add(new Point(250, 10));
    // points.add(new Point(10, 490));
    // points.add(new Point(490, 490));

    sample = new Point(random(width), random(height));
}

void draw()
{
    for (int i = 0; i < 1000; i++)
    {
        point(sample.x, sample.y);
        Point p = points.get((int)random(points.size()));
        sample.x = (sample.x + p.x) * .5;
        sample.y = (sample.y + p.y) * .5;
    }
}


class Point
{
    public float x;
    public float y;

    Point (float _x, float _y)
    {
        x = _x;
        y = _y;
    }
}
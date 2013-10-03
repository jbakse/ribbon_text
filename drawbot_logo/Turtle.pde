public class Turtle
{
	float x;
	float y;
	float a;

	public void Turtle()
	{
		x = 0;
		y = 0;
		a = 0;
	}

	public void moveTo(float _x, float _y)
	{
		x = _x;
		y = _y;
	}

	public void moveBy(float _x, float _y)
	{
		x += _x;
		y += _y;
	}

	public void lineTo(float _x, float _y)
	{
		line(x, y, _x, _y);
		x = _x;
		y = _y;
	}

	public void lineBy(float _x, float _y)
	{
		line(x, y, x + _x, y + _y);
		x += _x;
		y += _y;
	}

	public void rotateTo(float _a)
	{
		a = _a;
	}

	public void rotateBy(float _a)
	{
		a += _a;
	}

	public void forward(float _distance)
	{
		x += cos(a) * _distance;
		y += sin(a) * _distance;
	}

	public void forwardLine(float _distance)
	{
		float newX = x + cos(a) * _distance;
		float newY = y + sin(a) * _distance;
		line(x, y, newX, newY);
		x = newX;
		y = newY;
	}

}
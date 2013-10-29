public class Turtle
{
	float x;
	float y;
	float a;
	boolean visible = true;

	public Turtle()
	{
		this(0.0,0.0,0.0);
	}

	public Turtle(float _x, float _y, float _a)
	{
		this(_x, _y, _a, true);
	}

	public Turtle(float _x, float _y, float _a, boolean _visible)
	{
		x = _x;
		y = _y;
		a = _a;
		visible = _visible;
	}

	public void moveTo(float _x, float _y)
	{
		x = _x;
		y = _y;
	}

	public void setVisible(boolean _visible){
		visible = _visible;
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

	public void rotateToDeg(float _aDeg)
	{
		a = radians(_aDeg);
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
		if(visible){
			line(x, y, newX, newY);
		}
		x = newX;
		y = newY;
	}

	public Turtle clone()
	{
		return new Turtle(x, y, a, visible);
	}

}
import processing.pdf.*;

// String inputText = "It is known+that+there are an-infinite number+of+worlds,<simply because-there is an infinite amount of space-for-them-to be in.>However, not every one of them is inhabited. Therefore, there must be a finite number of inhabited worlds. Any finite number divided by infinity is as near to nothing as makes no odds, so the average population of all the planets in the Universe can be said to be zero. From this it follows that the population of the whole Universe is also zero, and that any people you may meet from time to time are merely the products of a deranged imagination.";

String inputText = "[It is known+that+there are an<infinite+number of+worlds>simply because+there is-an infinite-amount-of-space+for+them+to+be+in][However+not<every one of them>is inhabited]";

// String inputText = "[a";


float gridHeight = 16;
float gridWidth = 8;


PShape down_full;
PShape end;
PShape turn_end;
PShape up_full_front;
PShape start;
PShape turn_start;
PShape up_half;
PShape down_half;
PShape straight;
PShape up_full;


void setup()
{
	size(1000, 300);

	//draw grid
	background(125);
	stroke(135);
	for (int x = 0; x < width; x += gridWidth) {
		line(x, 0, x, height);
	}
	for (int y = 0; y < height; y += gridHeight) {
		line(0, y, width, y);
	}

	stroke(145);
	for (int x = 0; x < width; x += gridWidth * 10) {
		line(x, 0, x, height);
	}
	for (int y = 0; y < height; y += gridHeight * 10) {
		line(0, y, width, y);
	}

	//set drawing colors
	fill(0);
	noFill();
	stroke(0);


	// load images
	String tileSet = "ribbons/geometric/";
	down_full = loadShape(tileSet + "down_full.svg");
	end = loadShape(tileSet + "end.svg");
	turn_end = loadShape(tileSet + "turn_end.svg");
	up_full_front = loadShape(tileSet + "up_full_front.svg");
	start = loadShape(tileSet + "start.svg");
	turn_start = loadShape(tileSet + "turn_start.svg");
	up_half = loadShape(tileSet + "up_half.svg");
	down_half = loadShape(tileSet + "down_half.svg");
	straight = loadShape(tileSet + "straight.svg");
	up_full = loadShape(tileSet + "up_full.svg");



	//process content
	inputText = inputText.toLowerCase();
	ArrayList<String> inputTokens = tokenize(inputText);

	//render ribbon
	beginRecord(PDF, "output.pdf");
	int direction = 1;
	pushMatrix();
	translate(gridWidth * 10, gridHeight * 2);
	//ellipse(0, 0, 10, 10);

	for (String token : inputTokens) {
		//ellipse(0, 0, 4, 4);
		println("Token : " + token);

		if (("").equals(token)) {
			//nothing
		}
		else if (("+").equals(token)) {
			if (direction == 1) {
				shape(down_full, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, gridHeight);
			}
			else {
				shape(up_full, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, gridHeight);
			}
			translate(gridWidth * 2 * direction, 0);
		}
		else if (("-").equals(token)) {
			if (direction == 1) {
				shape(up_full, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, -gridHeight);
			}
			else {
				shape(up_full, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, -gridHeight);
			}
			translate(gridWidth * 2 * direction, 0);
		}
		else if (("<").equals(token)) {
			shape(turn_end, 0 , 0, gridWidth * 2, gridHeight);
			translate(0, gridHeight);
			translate(-gridWidth * 2, 0);
			direction = -1;
		}
		else if ((">").equals(token)) {
			shape(turn_start, 0 , 0, gridWidth * 2, gridHeight);
			translate(0, gridHeight);
			translate(gridWidth * 2, 0);
			direction = +1;
		}
		else if (("[").equals(token)) {
			shape(start, 0 , 0, gridWidth * 2, gridHeight);
			translate(gridWidth * 2 * direction, 0);
		}
		else if (("]").equals(token)) {
			shape(end, 0 , 0, gridWidth * 2, gridHeight);
			translate(gridWidth * 4 * direction, 0);
		}

		else {
			while (token.length() < 2) {
				token += " ";
			}

			if (direction == -1) {
				translate(-gridWidth * (token.length() - 4), 0);
			}
			else {
				translate(gridWidth * -2, 0);
			}
			for (int i = 0; i < token.length(); i++) {

				String c = Character.toString(token.charAt(i));
				if (i > 1 && i < token.length() - 2) {
					shape(straight, 0, 0, gridWidth, gridHeight);
				}
				text(c, 1, gridHeight - 4);
				translate(gridWidth, 0);
			}
			if (direction == -1) {
				translate(-gridWidth * (token.length()), 0);
			}
			else {
				translate(gridWidth * -2, 0);
			}
		}
	}
	popMatrix();
	endRecord();

}

ArrayList<String> tokenize(String _text)
{
	ArrayList<String> tokens = new ArrayList<String>();
	String currentWord = "";
	for (int i = 0; i < _text.length(); i++) {
		String c = Character.toString(inputText.charAt(i));
		if (("+-<>[]").contains(c)) {
			tokens.add(currentWord);
			currentWord = "";
			tokens.add(c);
		}
		else if (("abcdefghijklmnopqrstuvwxyz ").contains(c)) {
			currentWord += c;
		}
	}
	tokens.add(currentWord);
	return tokens;
}

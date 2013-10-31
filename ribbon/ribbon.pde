import processing.pdf.*;

// String inputText = "It is known+that+there are an-infinite number+of+worlds,<simply because-there is an infinite amount of space-for-them-to be in.>However, not every one of them is inhabited. Therefore, there must be a finite number of inhabited worlds. Any finite number divided by infinity is as near to nothing as makes no odds, so the average population of all the planets in the Universe can be said to be zero. From this it follows that the population of the whole Universe is also zero, and that any people you may meet from time to time are merely the products of a deranged imagination.";

// String inputText = "[It is known  +  that  +  there are an<infinite+  +  +  +number of+worlds>simply because+there is-an infinite-amount-of-space+for+them+to+be+in][However+not<every one of them>is inhabited]";

String inputText = "[abcde-0abcde-1abcde  -2  abcde+0abcde+1abcde  +2 abcde<  abcd+0abcd+1  abcd+2abcd  -0abcd-1  abcd  -2abcd  [";


float gridHeight = 16;
float gridWidth = 8;


HashMap<String, PShape> letters = new HashMap<String, PShape>();

PShape down_full_front;
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
	float windowScale = 20;
	size((int)(60 * windowScale), (int)(25 * windowScale));
	gridWidth = windowScale * .5;
	gridHeight = windowScale;



	//set drawing colors
	fill(0);
	noFill();
	stroke(0);


	// load images
	String tileSet = "ribbons/pirate/";
	down_full_front = loadShape(tileSet + "down_full_front.svg");
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


	String font = "fonts/mono_stroked/";
	String chars = "abcdefghijklmnopqrstuvwxyz0123456789";
	for (int i = 0; i < chars.length(); i++) {
		String c = Character.toString(chars.charAt(i));

		letters.put(c, loadShape(font + "char_" + c + ".svg"));
	}
	letters.put(",", loadShape(font + "char_comma.svg"));
	letters.put("!", loadShape(font + "char_exclamation.svg"));
	letters.put(".", loadShape(font + "char_period.svg"));
	letters.put("?", loadShape(font + "char_question.svg"));

	letters.put("'", loadShape(font + "char_apostrophe.svg"));
	letters.put("_", loadShape(font + "char_dash.svg"));
	letters.put("\"", loadShape(font + "char_doublequote.svg"));
	letters.put(";", loadShape(font + "char_semicolon.svg"));
	letters.put("'", loadShape(font + "char_singlequote.svg"));
	letters.put("~", loadShape(font + "char_tilde.svg"));






	//render ribbon
	render();
}

void draw()
{
	if (frameCount % 90 == 0) {
		render();
	}
}

void mousePressed()
{
	render();
}

void drawBackground()
{
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
}

void render()
{
	drawBackground();

	//process content
	String lines[] = loadStrings("input.txt");

	for (int i = 0; i < lines.length; i++) {

		int x = int(lines[i].substring(0, 3));
		int y = int(lines[i].substring(3, 6));
		// println("pos " + x + " '" + lines[i].substring(0, 2) + "' "  + y + " '" + lines[i].substring(2, 4) +"' ");
		inputText = lines[i].substring(6).toLowerCase();
		ArrayList<String> inputTokens = tokenize(inputText);





		//beginRecord(PDF, "output.pdf");
		{
			pushMatrix();
			translate(gridWidth * x, gridHeight * y * .5);
			drawRibbon(inputTokens);
			popMatrix();
		}
		//endRecord();
	}

}


void drawRibbon(ArrayList<String>  inputTokens)
{
	fill(255, 0, 0);
	stroke(0, 255, 0);

	int direction = 1;


	//ellipse(0, 0, 10, 10);
	int pos = 0;
	for (String token : inputTokens) {
		//ellipse(0, 0, 4, 4);
	

		if (("").equals(token)) {
			
			//nothing
		}
		else if (("+").equals(token) || ("+0").equals(token)) { // half step
			if (direction == 1) {
				shape(down_half, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, gridHeight * .5);
				translate(gridWidth * 5 * direction, 0);
			}
			else {
				translate(0, gridHeight * .5);
				translate(gridWidth * 1 * direction, 0);
				shape(up_half, 0 , 0, gridWidth * 2, gridHeight);
				translate(gridWidth * 2 * direction, 0);
			}
		}
		else if (("+1").equals(token)) { // full step normal
			if (direction == 1) {
				shape(down_full, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, gridHeight);
			}
			else {
				translate(0, gridHeight);
				shape(up_full, 0 , 0, gridWidth * 2, gridHeight);
			}
			translate(gridWidth * 2 * direction, 0);
		}
		else if (("+2").equals(token)) { // full step front
			if (direction == 1) {
				shape(down_full_front, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, gridHeight);
			}
			else {
				translate(0, gridHeight);
				shape(up_full_front, 0 , 0, gridWidth * 2, gridHeight);
			}
			translate(gridWidth * 2 * direction, 0);
		}
		else if (("-0").equals(token)) {
			if (direction == 1) {
				shape(up_half, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, -gridHeight * .5);
				translate(gridWidth * 5 * direction, 0);
			}
			else {
				translate(gridWidth * 3 * direction, 0);
				translate(0, -gridHeight * .5);
				shape(down_half, 0 , 0, gridWidth * 2, gridHeight);
				translate(gridWidth * 2 * direction, 0);
			}

		}
		else if (("-1").equals(token)) {
			if (direction == 1) {
				shape(up_full, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, -gridHeight);
				translate(gridWidth * 2 * direction, 0);
			}
			else {
				translate(0, -gridHeight);
				shape(down_full, 0 , 0, gridWidth * 2, gridHeight);
			}
		}
		else if (("-2").equals(token)) {
			if (direction == 1) {
				shape(up_full_front, 0 , 0, gridWidth * 2, gridHeight);
				translate(0, -gridHeight);
				translate(gridWidth * 2 * direction, 0);
			}
			else {
				translate(0, -gridHeight);
				shape(down_full_front, 0 , 0, gridWidth * 2, gridHeight);
				translate(gridWidth * 2 * direction, 0);
			}
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
			translate(gridWidth * 8 * direction, 0);
			if (pos == 0) {
                translate(gridWidth * -8 * direction, 0);
                direction = -1;
			}
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
					//println("draw straight");
					shape(straight, 0, 0, gridWidth, gridHeight);
				}
				//text(c, 1, gridHeight - 4);
				if (letters.containsKey(c)) {
					pushMatrix();
					//scale(.7); translate(0, gridHeight * .25);
					translate(0, .5 * gridHeight); scale(.75); translate(0, -.5 * gridHeight);
					shape(letters.get(c), 0, 0, gridWidth, gridHeight);
					popMatrix();
				}
				translate(gridWidth, 0);
			}
			if (direction == -1) {
				translate(-gridWidth * (token.length()), 0);
			}
			else {
				translate(gridWidth * -2, 0);
			}
		}
		pos++;
	}

}

ArrayList<String> tokenize(String _text)
{
	ArrayList<String> tokens = new ArrayList<String>();
	String currentWord = "";
	for (int i = 0; i < _text.length(); i++) {
		String c = Character.toString(inputText.charAt(i));
		if (("+-<>[]").contains(c)) {
			if (!currentWord.equals("")) {
				tokens.add(currentWord);
			}
			currentWord = "";
			if (i < _text.length() - 1) {
				String next = Character.toString(inputText.charAt(i + 1));
				if (("0123456789").contains(next)) {
					c += next;
					i += 1;
				}
			}
			println("add " + c);
			tokens.add(c);
		}
		else if (("abcdefghijklmnopqrstuvwxyz .,!'\"_;~?0123456789").contains(c)) {
			currentWord += c;
		}
	}
	tokens.add(currentWord);
	return tokens;
}
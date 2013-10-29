String inputText = "It is-known that there-are-an infinite-number of worlds, simply because there is an infinite amount of space for them to be in. However, not every one of them is inhabited. Therefore, there must be a finite number of inhabited worlds. Any finite number divided by infinity is as near to nothing as makes no odds, so the average population of all the planets in the Universe can be said to be zero. From this it follows that the population of the whole Universe is also zero, and that any people you may meet from time to time are merely the products of a deranged imagination.";

float gridHeight = 14;
float gridWidth = 14;


void setup()
{
	size(1000, 300);
	noFill();
	background(0);
	stroke(255);

	translate(gridWidth * 5, gridHeight * 5);

	inputText = inputText.toLowerCase();

	for(int i = 0; i < inputText.length(); i++) {
		String c = Character.toString(inputText.charAt(i));
		if ((" +").contains(c)) {
			drawTurnBL();
			translate(0, gridHeight);
			drawTurnTR();
			translate(gridWidth, 0);
		} else if (("-").contains(c)) {
			drawTurnTL();
			translate(0, -gridHeight);
			drawTurnBR();
			translate(gridWidth, 0);
		} else if (("abcdefghijklmnopqrstuvwxyz").contains(c)) {
			drawCharacter(c);
			translate(gridWidth, 0);
		}
	}
}

//turns TL, TR, BL, BR

void drawTurnTL() {
	rect(0, 0, gridWidth, gridHeight);
}

void drawTurnTR() {
	rect(0, 0, gridWidth, gridHeight);
}

void drawTurnBL() {
	rect(0, 0, gridWidth, gridHeight);
}
void drawTurnBR() {
	rect(0, 0, gridWidth, gridHeight);
}


void drawCharacter(String c){
	text(c, 2, gridHeight - 2);
	rect(0, 0, gridWidth, gridHeight);
}
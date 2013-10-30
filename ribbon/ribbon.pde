import processing.pdf.*;

// String inputText = "It is known+that+there are an-infinite number+of+worlds,<simply because-there is an infinite amount of space-for-them-to be in.>However, not every one of them is inhabited. Therefore, there must be a finite number of inhabited worlds. Any finite number divided by infinity is as near to nothing as makes no odds, so the average population of all the planets in the Universe can be said to be zero. From this it follows that the population of the whole Universe is also zero, and that any people you may meet from time to time are merely the products of a deranged imagination.";

String inputText = "[It is known+that+there are an<infinite+number of+worlds>simply because+there is-an infinite-amount-of-space+for+them+to+be+in][However+not<every one of them>is inhabited]";

// String inputText = "[a";


float gridHeight = 16;
float gridWidth = 8;


PShape ribbon_N;
PShape ribbon_BL;
PShape ribbon_BR; 
PShape ribbon_TL;
PShape ribbon_TR;
PShape ribbonline_BL;
PShape ribbonline_BR;
PShape ribbonline_TL;
PShape ribbonline_TR;
PShape ribbonend_L;
PShape ribbonend_R;

void setup()
{
    size(1000, 300);

    //draw grid
    background(125);
    stroke(135);
    for (int x = 0; x < width; x += gridWidth)
    {
        line(x, 0, x, height);
    }
    for (int y = 0; y < height; y += gridHeight)
    {
        line(0, y, width, y);
    }

    stroke(145);
    for (int x = 0; x < width; x += gridWidth * 10)
    {
        line(x, 0, x, height);
    }
    for (int y = 0; y < height; y += gridHeight * 10)
    {
        line(0, y, width, y);
    }

    //set drawing colors
    fill(0);
    noFill();
    stroke(0);


    // load image
    ribbon_BL = loadShape("ribbon_BL.svg");
    ribbon_BR = loadShape("ribbon_BR.svg");
    ribbon_N = loadShape("ribbon_N.svg");
    ribbon_TL = loadShape("ribbon_TL.svg");
    ribbon_TR = loadShape("ribbon_TR.svg");
    ribbonline_BL = loadShape("ribbonline_BL.svg");
    ribbonline_BR = loadShape("ribbonline_BR.svg");
    ribbonline_TL = loadShape("ribbonline_TL.svg");
    ribbonline_TR = loadShape("ribbonline_TR.svg");

    ribbonend_L = loadShape("ribbonend_L.svg");
    ribbonend_R = loadShape("ribbonend_R.svg");


    //process content
    inputText = inputText.toLowerCase();
    ArrayList<String> inputTokens = tokenize(inputText);

    //render ribbon
    beginRecord(PDF, "output.pdf");
    int direction = 1;
    pushMatrix();
    translate(gridWidth * 10, gridHeight * 2);
    //ellipse(0, 0, 10, 10);

    for (String token : inputTokens)
    {
        //ellipse(0, 0, 4, 4);
        println("Token : " + token);

        if (("").equals(token)) {
            //nothing
        }
        else if (("+").equals(token))
        {
            if (direction  == 1)
            {
                drawTurnBL();
                translate(0, gridHeight);
                drawTurnTR();
            }
            else
            {
                drawTurnBR();
                translate(0, gridHeight);
                drawTurnTL();
            }


            translate(gridWidth * 2 * direction, 0);
        }
        else if (("-").equals(token))
        {
            if (direction  == 1)
            {
                drawTurnTL();
                translate(0, -gridHeight);
                drawTurnBR();
            }
            else
            {
                drawTurnTR();
                translate(0, -gridHeight);
                drawTurnBL();
            }
            translate(gridWidth * 2 * direction, 0);
        }
        else if (("<").equals(token))
        {
            shape(ribbonline_BL, 0 , 0, gridWidth * 2, gridHeight);
            translate(0, gridHeight);
            shape(ribbonline_TL, 0 , 0, gridWidth * 2, gridHeight);
            translate(-gridWidth * 2, 0);
            direction = -1;
        }
        else if ((">").equals(token))
        {
            shape(ribbonline_BR, 0 , 0, gridWidth * 2, gridHeight);
            translate(0, gridHeight);
            shape(ribbonline_TR, 0 , 0, gridWidth * 2, gridHeight);
            translate(gridWidth * 2, 0);
            direction = +1;
        }
        else if (("[").equals(token))
        {
            shape(ribbonend_R, 0 , 0, gridWidth * 2, gridHeight);
            translate(gridWidth * 2 * direction, 0);
        }
         else if (("]").equals(token))
        {
            shape(ribbonend_L, 0 , 0, gridWidth * 2, gridHeight);
            translate(gridWidth * 4 * direction, 0);
        }

        else
        {
            while (token.length()< 2) {
                   token += " ";
                }

            if (direction == -1)
            {
                translate(-gridWidth * (token.length() - 4), 0);
            }
            else
            {
                translate(gridWidth * -2, 0);
            }
            for (int i = 0; i < token.length(); i++)
            {

                String c = Character.toString(token.charAt(i));
                if (i > 1 && i < token.length() - 2)
                {
                    shape(ribbon_N, 0, 0, gridWidth, gridHeight);
                }
                drawCharacter(c);
                translate(gridWidth, 0);
            }
            if (direction == -1)
            {
                translate(-gridWidth * (token.length()), 0);
            }
            else 
            {
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
    for (int i = 0; i < _text.length(); i++)
    {
        String c = Character.toString(inputText.charAt(i));
        if (("+-<>[]").contains(c))
        {
            tokens.add(currentWord);
            currentWord = "";
            tokens.add(c);
        }
        else if (("abcdefghijklmnopqrstuvwxyz ").contains(c))
        {
            currentWord += c;
        }
    }
    tokens.add(currentWord);

    return tokens;

}

//turns TL, TR, BL, BR

void drawTurnTL()
{
    shape(ribbon_TL, 0 , 0, gridWidth * 2, gridHeight);
}

void drawTurnTR()
{
    shape(ribbon_TR, 0 , 0, gridWidth * 2, gridHeight);
}

void drawTurnBL()
{
    shape(ribbon_BL, 0 , 0, gridWidth * 2, gridHeight);
}
void drawTurnBR()
{
    shape(ribbon_BR, 0 , 0, gridWidth * 2, gridHeight);
}


void drawCharacter(String c)
{

    text(c, 1, gridHeight - 4);
    //    rect(0, 0, gridWidth, gridHeight);
    // shape(ribbon_N, 0, 0, gridWidth, gridHeight);
}
public class L_Set
{
    ArrayList<L_Symbol> symbols;
    ArrayList<L_Rule> rules;

    L_Set()
    {
    	symbols = new ArrayList<L_Symbol>();
    	rules = new ArrayList<L_Rule>();
    }
    public void step()
    {	
    	for (L_Symbol symbol : symbols){
    		symbol.touched = false;
    	}
        for (L_Rule rule : rules)
        {
            while(testRule(rule) == true);
        }
    }

    public void run(){
    	for (L_Symbol symbol : symbols){
    		symbol.callback.call(mainTurtle);
    	}
    }

    public boolean testRule(L_Rule rule)
    {
    	// println("testRule");
        for (int s = 0; s < symbols.size(); s++)
        {

            for (int rs = 0; rs < rule.search.size(); rs++)
            {
            	// println(s + ", " + rs + " " + symbols.get(s + rs).touched);
                if (s + rs > symbols.size() -1 || symbols.get(s + rs).touched == true || symbols.get(s + rs).name != rule.search.get(rs).name)
                {
                    //doesn't match
                    break;
                }
                else if (rs == rule.search.size() - 1)
                {
                    //match
                    applyRuleAtPosition(rule, s);
                    // return true;
                }
            }
        }
        return false;
    }

    public void applyRuleAtPosition(L_Rule rule, int pos)
    {
        for (int i = 0; i < rule.search.size(); i++)
        {
            symbols.remove(pos);
        }
        for (int i = 0; i < rule.replace.size(); i++)
        {
            symbols.add(pos+i, rule.replace.get(i).clone());
            symbols.get(pos+i).touched = true;
        }
    }

   	String toString()
    {
    	String s = "";
        for (L_Symbol symbol : symbols)
        {
            s += symbol.name + " ";
        }
        return s;
    }

}

public class L_Rule
{
    ArrayList<L_Symbol> search;
    ArrayList<L_Symbol> replace;
    L_Rule()
    {
        search = new ArrayList<L_Symbol>();
        replace = new ArrayList<L_Symbol>();

    }
}

public class L_Symbol implements Cloneable
{
    String name;
    boolean touched;
    L_Callback callback;

    public L_Symbol clone()
    {

        L_Symbol s = new L_Symbol();
        s.name = name;
        s.callback = callback;
        return s;
    }

}

interface L_Callback
{
    public void call(Turtle t);
}
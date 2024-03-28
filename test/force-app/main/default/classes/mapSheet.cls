public class mapSheet {
    public static void point1()
    {
        list<contact> conList= [select email, firstName, lastName, id from contact];
        map<string, contact> conMap= new map<string, contact>();
        for(contact c: conList)
        {
            conMap.put(c.email, c);
        }
        for(string s: conMap.keySet())
        {
            system.debug('email= ' +s +' contact= ' + conMap.get(s));
        }
    }
    public static void point2()
    {
        list<Account> accList= [select Name, NumberOfEmployees, Industry from account];
        map<string, list<account>> accMap= new map<string, list<account>>();
        for(account a: accList)
        {

            if(accMap.containsKey(a.Industry))
            {
                accMap.put(a.Industry, (List<Account>)accMap.get(a.Industry).add(a));
            }
            else
            {
                List<Account> temp = new list<account>();
                temp.add(a);
                accMap.put(a.Industry, temp);
            }
        }
    }
    public static void point3()
    {
        list<contact> conList = [select email, firstName, lastName, id from contact WHERE firstName!=NULL];
        map<string, list<contact> > conMap = new map<string, list<contact>>();
        for(contact c: conList)
        {
            string firstLetter = c.FirstName.substring(0,1).toUpperCase();
            if(conMap.containsKey(firstLetter))
            {
                conMap.get(firstLetter).add(c);

            }
            else
            {
                list<contact> temp = new list<contact>();
                temp.add(c);
                conMap.put(firstLetter, temp);
            }
        }
        system.debug(conMap);
    }
    public static void point4()
    {
        list<opportunity> oppList = [Select Name, Id, StageName, Amount from opportunity where amount!= Null];
        map<string,decimal> oppMap = new map<String, Decimal>();
        for(opportunity o: oppList)
        {
            if(oppMap.containsKey(o.StageName))
            {
                oppMap.put(o.stageName, oppMap.get(o.stageName)+o.Amount);
            }
            else
            {
                oppMap.put(o.stageName,o.Amount);
            }
        }
        for(string s: oppMap.keySet())
        {
            system.debug('Stage Name: ' +s + ' Amount: '+ oppMap.get(s));
        }
    }
    
    
    
    public static void point5()
    {
        list<opportunity> oppList = [Select Name,LeadSource, StageName, Amount from opportunity WHERE StageName != NULL AND LeadSource != NULL];
        map<string,list<opportunity>> oppMap = new map<string, list<opportunity>>();
        for(opportunity o : oppList)
        {
            string keyValue = o.LeadSource + '-' + o.StageName;
            if(oppMap.containsKey(keyValue))
            {
                oppMap.get(keyValue).add(o);
            }
            else
            {
                list<opportunity> temp = new list<opportunity>();
                temp.add(o);
                oppMap.put(keyValue, temp);
            }
        }
        for(string s : oppMap.keySet())
        {
            system.debug('Key: ' +s + 'list-->' + oppMap.get(s));
        }
        //system.debug(oppMap);
    }
    

}
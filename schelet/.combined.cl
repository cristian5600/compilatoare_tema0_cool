class List inherits IO{

    (* TODO: store data *)
    elem : Object;
    next : List;

    init(e : Object, n : List) : List {
        {
            elem <- e;
            next <- n;
            self;
        }
    };

    extractNext() : List{
        {
        next;
        }
    };
    setNext(l:List) : List{
        {
            --out_string("am setat next??\n");
            next <- l;
        --self;
        }
    };
    getContent() : Object {
        {
        elem;
        }
    };
    add(obj : Object):SELF_TYPE {
        let null:List,
            coppy:List <- self,
            aux : List <- new List.init(obj,null)  
                in 
                {
                    --out_string(self.toString().concat("\n"));
                    coppy.setNext(self.extractNext());
                    --out_string(coppy.toString());
                    while ( not (isvoid coppy.extractNext()) ) loop
                    {
                        --out_string("intrat in while????\n");
                        coppy <- coppy.extractNext();
                        
                        
                    }
                    pool;  
                    coppy.setNext(aux);
                    self;
                }
         
    };

    toString():String {
        let coppy:List <- self.copy(),
            null:List,
            aux:Object,
            count:Int <-0,
            result:String <- "" in --self.getContent().type_name() in 
            {
                
                aux <- coppy.getContent();
                --out_string(aux.type_name());
                case aux of
                        p : Product => {result <- result.concat(p.toString());};  
                        r : Rank => {result <-    result.concat(r.toString());};        
                        s: String => { result <- "String".concat("(").concat(s).concat(")"); };  --self.type_name().concat("(").concat(name).concat(";").concat(model).concat(")")
                        o : Object  => { out_string(o.type_name()).out_string("wtf \n"); ""; };
                esac;
                -- if ( not (isvoid coppy.extractNext()) ) then
                --     coppy <- coppy.extractNext() 
                -- else 0 fi;

                while ( not (isvoid coppy.extractNext()) ) loop
                {
                    coppy <- coppy.extractNext();
                    --out_string("AM INTRAT in lista\n");
                    aux <- coppy.getContent();
                    case aux of
                        p : Product => {result <-(result.concat(p.toString()));};
                        r : Rank => {result <-   (result.concat(r.toString()));}; 
                        s : String  => {result.concat(s).concat(" ");};
                        o : Object  => { abort(); ""; };
                    esac;
                    
                    
                    
                   
                }
                pool;
                --out_string(result);
                --result.concat(")");

                result;
            }

    };

    merge(other : List):SELF_TYPE {
        self (* TODO *)
    };

    filterBy():SELF_TYPE {
        self (* TODO *)
    };

    sortBy():SELF_TYPE {
        self (* TODO *)
    };
};

class Main inherits IO{
    lists : List <- new List;
    looping : Bool <- true;
    somestr : String;
    null : Product;

    main():Object {
        while looping loop {
            somestr <- in_string();
            if(somestr = "test") then
            {
                if (isvoid null) then
                {
                let null : List,
                    elem:List <- new List in{
                        elem.init((new Product).init("a","b",3),null);
                        elem.add((new Soda).init("c","d",67));
                        elem.add((new Coffee).init("e","f",632));
                        elem.add((new Laptop).init("g","h",4545));
                        elem.add((new Router).init("cads","dsd",2167));
                        elem.add((new Rank).init("marinescu")); --SELF_TYPE necesitate la init
                        elem.add((new Corporal).init("ciobotaru"));
                        
                        out_string("\n"
                        .concat("[")
                        .concat(elem.toString())
                        .concat("]\n"));

                };

                out_string("---");
                out_string("---");


                }
                else 0
                fi;               
            }
            else 0 fi;
            if(somestr = "load") then{
                let input:String <- "",
                    input_list:List in
                    {   
                    while looping loop {
                        input <- in_string();
                        --(new Token).getTokenList("stringulmeu");
                        --out_string("ceva".substr(1,1));
                        if((new Token).whereSpace("as a") < 100) then
                            out_int((new Token).whereSpace("sdaa ezo lbat asta"))
                        else 0 fi;
                        looping = false;
                        out_string(
                            ((new Token).getTokenList("am rezolvat chestia asta yess"))
                            .getContent().type_name());
                        let mylist:List,
                            token:Token <- new Token in{
                            mylist <- token.getTokenList("am rezolvat chestia asta yess");
                            out_string(mylist.toString());
                        };
                        --(new Token).getTokenList("am rezolvat chestia asta yess");
                    }
                    pool; 
                    
                    
                    };
            
            }
            else 0 fi; 
            } pool
    };
};

(*******************************
 *** Classes Product-related ***
 *******************************)
class Product {
    name : String;
    model : String;
    price : Int;

    init(n : String, m: String, p : Int):SELF_TYPE {{
        name <- n;
        model <- m;
        price <- p;
        self;
    }};

    getprice():Int{ price * 119 / 100 };

    toString():String {
        --self.type_name().concat("(").concat(name).concat(";").concat(model).concat(";").concat((new A2I).i2a_aux(price).concat(")"))
        self.type_name().concat("(").concat(name).concat(";").concat(model).concat(")")
    };
};

class Edible inherits Product {
    -- VAT tax is lower for foods
    getprice():Int { price * 109 / 100 };
};

class Soda inherits Edible {
    -- sugar tax is 20 bani
    getprice():Int {price * 109 / 100 + 20};
};

class Coffee inherits Edible {
    -- this is technically poison for ants
    getprice():Int {price * 119 / 100};
};

class Laptop inherits Product {
    -- operating system cost included
    getprice():Int {price * 119 / 100 + 499};
};

class Router inherits Product {};

(****************************
 *** Classes Rank-related ***
 ****************************)
class Rank {
    name : String;

    init(n : String):SELF_TYPE {
        {
        name <- n;
        self;
        }
    };

    toString():String {
        -- Hint: what are the default methods of Object?
        
        (self.type_name().concat("(").concat(name).concat(")"))

    };
};

class Private inherits Rank {};

class Corporal inherits Private {};

class Sergent inherits Corporal {};

class Officer inherits Sergent {};

Class Token inherits IO{
    -- mystring:String <-"";

    -- init(str:String):SELF_TYPE{
    -- {
    --     mystring <- str;
    --     self;
    -- }
    -- };
    whereSpace(str:String):Int{
        
            let 
            i:Int<-0,
            l:Int<-0,
            result:Int<-0
            in
            {
                --out_string("am intrat in hasSpace");
                while (i<str.length()) loop{
                    --out_string("\n sunt in while 1 ");
                    if(str.substr(i,1) = " ") then
                        {
                        result <- i;
                        i<-str.length();
                        --out_string("\n sunt in if 234");
                        }
                    else 0 fi;
                    i<-i+1;

                }pool;
                result;
            }
            
        
    };
    getTokenList(str:String):List{
        let 
            coppy:String<-str.copy(),
            aux:String,
            null:List,
            list:List,
            i:Int<-0,
            len:Int
            in
            {
                while ( 0 < whereSpace(coppy) ) loop{ --"am rezolvat chestia asta"
                    

                    --out_string("coppy:").out_string(coppy).out_string("\n");

                    len <- whereSpace(coppy); 
                    
                    --out_string(" a \n");
                    aux <- coppy.substr(0,len);
                    
                    i <- len;

                    coppy <- coppy.substr(i+1,coppy.length()-i-1);
                    
                    -- out_string(" b \n");
                    
                    -- out_string("\naux=");
                    -- out_string(aux);
                    -- out_string("\nlen=");
                    -- out_int(len);
                    -- out_string("\ni=");
                    -- out_int(i);
                    -- out_string("\n\n");
                    
                    if(isvoid list) then 
                        {
                            list <- (new List).init(aux,null) ; 
                            --out_string("\nam initializat lista cu aux:").out_string(aux);
                        }
                        else {
                            list.add(aux);
                            --out_string("\nam adaugat in lista aux:").out_string(aux);
                        } fi;
                    
                } pool;
                
                if ( 0 < coppy.length() ) then {
                    --ut_string("aux:").out_string(coppy).out_string("\n");
                    if(isvoid list) then 
                        {
                            list <- (new List).init(coppy,null) ; 
                            --out_string("\nam initializat lista cu aux:").out_string(coppy);
                        }
                        else {
                            list.add(coppy);
                            --out_string("\nam adaugat in lista aux:").out_string(coppy);
                        } fi;
                } else 0 fi;
                --out_string(list.toString());
                --out_string("\ntype of content of list is ").out_string(list.getContent().type_name()).out_string("\n");
                list;
            }
    };

};

(* Think of these as abstract classes *)
class Comparator {
    compareTo(o1 : Object, o2 : Object):Int {0};
};

class Filter {
    filter(o : Object):Bool {true};
};

(* TODO: implement specified comparators and filters*)

class A2I {

     c2i(char : String) : Int {
    if char = "0" then 0 else
    if char = "1" then 1 else
    if char = "2" then 2 else
        if char = "3" then 3 else
        if char = "4" then 4 else
        if char = "5" then 5 else
        if char = "6" then 6 else
        if char = "7" then 7 else
        if char = "8" then 8 else
        if char = "9" then 9 else
        { abort(); 0; }  -- the 0 is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(*
   i2c is the inverse of c2i.
*)
     i2c(i : Int) : String {
    if i = 0 then "0" else
    if i = 1 then "1" else
    if i = 2 then "2" else
    if i = 3 then "3" else
    if i = 4 then "4" else
    if i = 5 then "5" else
    if i = 6 then "6" else
    if i = 7 then "7" else
    if i = 8 then "8" else
    if i = 9 then "9" else
    { abort(); ""; }  -- the "" is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(*
   a2i converts an ASCII string into an integer.  The empty string
is converted to 0.  Signed and unsigned strings are handled.  The
method aborts if the string does not represent an integer.  Very
long strings of digits produce strange answers because of arithmetic 
overflow.

*)
     a2i(s : String) : Int {
        if s.length() = 0 then 0 else
    if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
        if s.substr(0,1) = "+" then a2i_aux(s.substr(1,s.length()-1)) else
           a2i_aux(s)
        fi fi fi
     };

(*
  a2i_aux converts the usigned portion of the string.  As a programming
example, this method is written iteratively.
*)
     a2i_aux(s : String) : Int {
    (let int : Int <- 0 in  
           {    
               (let j : Int <- s.length() in
              (let i : Int <- 0 in
            while i < j loop
            {
                int <- int * 10 + c2i(s.substr(i,1));
                i <- i + 1;
            }
            pool
          )
           );
              int;
        }
        )
     };

(*
    i2a converts an integer to a string.  Positive and negative 
numbers are handled correctly.  
*)
    i2a(i : Int) : String {
    if i = 0 then "0" else 
        if 0 < i then i2a_aux(i) else
          "-".concat(i2a_aux(i * ~1)) 
        fi fi
    };
    
(*
    i2a_aux is an example using recursion.
*)      
    i2a_aux(i : Int) : String {
        if i = 0 then "" else 
        (let next : Int <- i / 10 in
        i2a_aux(next).concat(i2c(i - next * 10))
        )
        fi
    };

};

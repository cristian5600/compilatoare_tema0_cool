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
                        out_string("ceva");
                    }
                    pool; 
                    
                    
                    };
            
            }
            else 0 fi; 
            } pool
    };
};


class Main inherits IO{
    lists : List;
    listsLength: Int;  
    looping : Bool <- true;
    loopingLoad: Bool <- true;
    somestr : String;
    null : Product;
    aux: Object;
    auxi: Object;
    number:Int<- 12;

    main():Object {
        {
        let input:String <- "?",
                    input_list:List,
                    void:List
                     in
                    { 
                        loopingLoad <- true;  
                    while (loopingLoad) loop {
                        input <- in_string();
                        if (not (input = "END")) then 
                        {                           
                            let mylist:List,
                                token:Token <- new Token ,
                                command : List
                                in{
                                    mylist <- token.getTokenList( input );
                                    --out_string(mylist.toString());
                                    load(mylist);
                                };
                        } 
                        else { loopingLoad <- false; } fi;
                        }pool;
                        listsLength <- listsLength + 1;
                        --print(1);
                    }; 

        while looping loop {
            
            somestr <- in_string();
            if(somestr = "test") then
            {
                if (isvoid null) then
                {
                let null : List,
                    elem:List <- new List,
                    aux : Object in{
                        elem.init((new Product).init("a","b",3),null);
                        elem.add((new Soda).init("c","d",67));
                        elem.add((new Coffee).init("e","f",632));
                        elem.add((new Laptop).init("g","h",4545));
                        elem.add((new Router).init("cads","dsd",2167));
                        elem.add((new Rank).init("marinescu")); --SELF_TYPE necesitate la init
                        elem.add((new Corporal).init("ciobotaru"));
                        aux <- (new Corporal).init("ciobotaru");
                        
                        --out_string(elem.toString());

                };
                --out_string("\n---");
                out_string("---");
                }
                else 0
                fi;               
            }
            else 0 fi;

(*  *****************************************************
    *****************LOADING***************************** *
    *****************************************************  *)

            if(somestr = "load") then{  --
                let input:String <- "?",
                    input_list:List,
                    void:List
                     in
                    { 
                        loopingLoad <- true;  
                    while (loopingLoad) loop {
                        input <- in_string();
                        if (not (input = "END")) then 
                        {                           
                            let mylist:List,
                                token:Token <- new Token ,
                                command : List
                                in{
                                    mylist <- token.getTokenList( input );
                                    --out_string(mylist.toString());
                                    load(mylist);
                                };
                        } 
                        else { loopingLoad <- false; } fi;
                        }pool;
                        listsLength <- listsLength + 1;
                        --print(1);
                    }; 

            } else 0 fi; 

            if(somestr = "print")then {
                print(1);
            } else 0 fi;

            if(somestr = "print 1")then {
                print(1);
            } else 0 fi;

            } pool;

    }    
    };

    load(cmd : List) : Object {   -- cate o linie
        let 
            cpy : List <- lists,
            null : List,
            current : List,
            count:Int <- 0,
            m : Object,
            type: String,
            arg1_str:String,
            arg2_str:String,
            arg3_int:Int,
            aux:Object,
            sumProductType:Int <- 0,
            sumRankType:Int <- 0
            in{
                
                while( count < listsLength) loop{
                    --out_string(" \n AM INTRAT IN WHILE");
                    cpy   <- cpy.extractNext();
                    count <- count+1 ;
                } pool;

                aux <- cmd.getContent();

                case aux of 
                    s : String => { type <- s ;};
                    o : Object => { abort(); ""; };
                esac;

                if(type = "String") then {
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg1_str <- s ;};
                        o : Object => { abort(); "";};
                    esac;
                        if( isvoid cpy ) then{
                            cpy <- (new List).init(
                                (new List).init(arg1_str,null)
                                ,null);
                                --out_string("\nam initializat lista\n");
                                if (isvoid lists ) then {lists <- cpy;} else {
                                    lists.add((new List).init(arg1_str,null));
                                }fi;
                            } else {
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(arg1_str); };
                                    o : Object => { abort(); "";};
                                esac;
                                --out_string("\nam adaugat in lista cu .add \n");
                            } fi;
                } else 0 fi;
                
                --- PRODUCT TYPE/CHILD ??
                
                sumProductType <- 0;
                if(type = "Product") then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Edible")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Soda")    then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Laptop")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Router")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Coffee")  then { sumProductType <- sumProductType+1; } else 0 fi;
                --out_string("\n sumProductType : ").out_int(sumProductType).out_string("\n");
                if(not sumProductType = 0) then { --if it's a product of any kind
                    --out_string("\n ???????????????? \n");
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg1_str <- s ;};
                        o : Object => { abort(); "";};
                    esac;

                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg2_str <- s ;};
                        o : Object => { abort(); "";};
                    esac;

                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg3_int <- new A2I.a2i_aux(s) ;};
                        o : Object => { abort(); "";};
                    esac;
                    
                    if(type = "Product") then { auxi <- new Product.init(arg1_str,arg2_str,arg3_int);} else 0 fi;
                    if(type = "Edible")  then { auxi <- new Edible.init(arg1_str,arg2_str,arg3_int); } else 0 fi;
                    if(type = "Soda")    then { auxi <- new Soda.init  (arg1_str,arg2_str,arg3_int); } else 0 fi;
                    if(type = "Laptop")  then { auxi <- new Laptop.init(arg1_str,arg2_str,arg3_int); } else 0 fi;
                    if(type = "Router")  then { auxi <- new Router.init(arg1_str,arg2_str,arg3_int); } else 0 fi;
                    if(type = "Coffee")  then { auxi <- new Coffee.init(arg1_str,arg2_str,arg3_int); } else 0 fi;

                    if( isvoid cpy ) then{
                        cpy <- (new List).init(
                            (new List).init(auxi,null)
                            ,null);
                            --out_string("\nam initializat lista\n");
                            if (isvoid lists ) then {lists <- cpy;} else {
                                lists.add((new List).init(auxi,null));
                            }fi;
                        } else {
                            aux <- cpy.getContent();
                            case aux of 
                                l : List => { l.add(auxi); };
                                o : Object => { abort(); "";};
                            esac;
                            --out_string("\nam adaugat in lista cu .add \n");
                        } fi;
                }else 0 fi;
                                
                sumRankType <- 0;

                if(type = "Rank") then { sumRankType <- 1 ;} else 0 fi;
                if(type = "Private") then { sumRankType <- 1 ;} else 0 fi;
                if(type = "Corporal") then { sumRankType <- 1 ;} else 0 fi;
                if(type = "Sergent") then { sumRankType <- 1; } else 0 fi;
                if(type = "Officer") then { sumRankType <- 1; } else 0 fi;

                if ( sumRankType = 1 ) then {
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg1_str <- s ;};
                        o : Object => { abort(); "";};
                    esac;

                    if(type = "Rank") then {    auxi <- new Rank.init(arg1_str); } else 0 fi;
                    if(type = "Private") then { auxi <- new Private.init(arg1_str); } else 0 fi;
                    if(type = "Corporal") then {auxi <- new Corporal.init(arg1_str);} else 0 fi;
                    if(type = "Sergent") then { auxi <- new Sergent.init(arg1_str); } else 0 fi;
                    if(type = "Officer") then { auxi <- new Officer.init(arg1_str); } else 0 fi;

                    if( isvoid cpy ) then{
                        cpy <- (new List).init(
                            (new List).init(auxi,null)
                            ,null);
                            --out_string("\nam initializat lista\n");
                            if (isvoid lists ) then {lists <- cpy;} else {
                                lists.add((new List).init(auxi,null));
                            }fi;
                        } else {
                            aux <- cpy.getContent();
                            case aux of 
                                l : List => { l.add(auxi); };
                                o : Object => { abort(); "";};
                            esac;
                            --out_string("\nam adaugat in lista cu .add \n");
                        } fi;

                    
                } else 0 fi;

            }
    };
    print(index : Int) : Object {
        let cpy: List <- lists,
        aux: Object,
        count:Int <- 0
         in
        {
            --out_string( "\nse printeaza se printeaza:\n" );
            while( count < listsLength) loop {
                if ( 1 < listsLength ) then {out_int(count+1).out_string(": ");} else 0 fi;
                aux <- cpy.getContent();
                case aux of 
                    l : List => { 
                        out_string(l.toString());
                        out_string("\n");
                        l <- l.extractNext();
                    };
                    o:Object => {abort(); "";};
                esac;
                cpy <- cpy.extractNext();
                count <- count + 1; 
             } pool;
        }
    };

};

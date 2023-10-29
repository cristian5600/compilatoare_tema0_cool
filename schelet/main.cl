class Main inherits IO{
    lists : List;
    listsLength: Int;  
    looping : Bool <- true;
    loopingLoad: Bool <- true;
    somestr : String;
    null : List;
    aux: Object;
    auxi: Object;
    number:Int<- 12;
    cmd: List;
    arg1_merge:Int;
    arg2_merge:Int;

    main():Object {
        {
        let input:String <- "",    -- SE FACE UN LOAD()
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
            --cmd <- null;
            somestr <- in_string();
            

            if (not somestr = "") then { 
                cmd <- new Token.getTokenList(somestr);
                aux <- cmd.getContent();

                case aux of 
                    s : String => { somestr <- s ;};
                    o : Object => {  abort(); " ";};
                esac;
             }
             else 0 fi;
            --out_string("\n comanda este:").out_string(cmd.toString()).out_string("\n");
            
            if(somestr = "test") then
            {
                if (isvoid null) then
                {
                let null : List,
                    elem:List <- new List,
                    soda:Soda<- new Soda.init("123","1",1),
                    aux : Object in{
                        elem.init((new Product).init("1","100",100),null);
                        elem.add((new Soda).init("2","900",900));
                        elem.add((new Product).init("3","15",15));
                        elem.add((new Product).init("4","2",2));
                        elem.add( soda);

                        -- out_string(elem.toString()).out_string("\n");
                        -- out_string("\nPrice of soda: ");
                        -- out_int(soda.getprice());
                        -- out_string("\n price of soda as Product: ");
                        -- out_int((new Product).init("--","--",soda.getStartPrice()).getprice());
                        -- out_string("\n");
                        -- out_string(elem.toString()).out_string("\n");
                        -- new SamePriceFilter.filter(elem);
                        -- out_string(elem.toString()).out_string("\n");
                        -- out_int(new ProductComparator.compare((new Product).init("Abc","ads",999),
                        --                                 (new Soda).init("aaa","bbb",999)));
                        -- out_int(new RankComparator.compare(new Officer.init("a"),new Sergent.init("a")) );
                        --if( "a" < "b" ) then out_string("EOKAY") else out_string("NUEOKAY") fi;
                        out_string(elem.toString()).out_string("\n");

                        elem.sortBy(new ProductComparator,"descendent");
                        out_string(elem.toString()).out_string("\n");

                        elem.filterBy(new SamePriceFilter);
                        out_string(elem.toString()).out_string("\n");

                };
                --out_string("\n---");
                out_string("\n");
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
                                    load(mylist);
                                };
                        } 
                        else { loopingLoad <- false; } fi;
                        }pool;
                        listsLength <- listsLength + 1;
                    }; 

            } else 0 fi; 

(*  *****************************************************
    ***************  MERGE  ***************************** *
    *****************************************************
    ****************************************************
    ****************************************************  *)
            if(somestr = "merge") then {
                cmd <- cmd.extractNext();
                aux <- cmd.getContent();
                case aux of
                    s:String => { arg1_merge <- new A2I.a2i_aux(s); };
                    o:Object => {abort();" ";};
                esac;

                cmd <- cmd.extractNext();
                aux <- cmd.getContent();
                case aux of
                    s:String => { arg2_merge <- new A2I.a2i_aux(s); };
                    o:Object => {abort();" ";};
                esac;

                let cpy : List <- lists ,
                toAdd:List,
                count : Int <- 0,
                null:List
                in{
                    aux <- lists.extractRemoveElement(arg2_merge);
                    listsLength <- listsLength-1;
                    case aux of 
                        l: List => { toAdd <- l; };
                        o:Object => {abort(); " ";};
                    esac;

                    while ( count < listsLength ) loop {
                        if( count+1 = arg1_merge ) then {

                            aux <- cpy.getContent();
                            case aux of 
                                l : List => { l.merge(toAdd); };
                                o:Object => {abort(); " ";};
                            esac;
                            
                            if(not isvoid lists.extractNext()) then --daca este doar un element nu mai trebuie facut nimic
                            {
                                aux <- lists.extractRemoveElement(arg1_merge);
                                case aux of 
                                    l : List => {  lists.add(l) ;};
                                    o:Object => {abort(); " ";};
                                esac;
                            }
                            else 0 fi;

                        }else{
                            cpy <- cpy.extractNext();
                        } fi;

                        count <- count + 1 ;
                    }pool;
                };
            } else 0 fi;

(*  *****************************************************
    ***************  FilterBy  ***************************** *
    ***************************************************** 
    ****************************************************
    **************************************************** *)

            if(somestr = "filterBy")then {
                let index:Int,
                option:String,
                count:Int<-1,
                cpy:List <- lists 
                in{
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent();
                    case aux of 
                        s :String => { index <- new A2I.a2i_aux(s); };
                        o :Object => {abort();"";};
                    esac;

                    
                    while(count < index) loop{
                        cpy <- cpy.extractNext();
                        count <- count+1;
                    }pool;

                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent();
                    case aux of 
                        s :String => { option <- s ;};
                        o :Object => {abort();"";};
                    esac;
                    if(option="ProductFilter") then {
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { l.filterBy(new ProductFilter);}; --new ProductFilter.filter(l); };
                            o:Object => {abort();};
                        esac;
                    }else 0 fi;
                    if(option="RankFilter") then {
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { l.filterBy(new RankFilter); };
                            o:Object => {abort();};
                        esac;
                    }else 0 fi;
                    if(option="SamePriceFilter") then {
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { l.filterBy(new SamePriceFilter); };
                            o:Object => {abort();};
                        esac;
                    }else 0 fi;

                };
            
            } else 0 fi;

(*  *****************************************************
    ***************  SortBy  ***************************** *
    ***************************************************** 
    ****************************************************
    **************************************************** *)
            if(somestr = "sortBy")then {
                let index : Int,
                aux : Object,
                cpy : List <- lists,
                count : Int<-0,
                option1 : String,
                option2 : String
                in{
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent();
                    case aux of
                        s : String => { index <- new A2I.a2i_aux(s); };
                        o : Object => {abort();};
                    esac;
                    if ( listsLength < index ) then abort() else 0 fi;

                    count <- 1;
                    while( count < index) loop {
                        cpy <- cpy.extractNext();
                        count <- count + 1;
                    } pool;



                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent();
                    case aux of
                        s : String => { option1 <- s ;};
                        o : Object => { abort(); };
                    esac;
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent();
                    case aux of
                        s : String => { option2 <- s ;};
                        o : Object => {abort();};
                    esac;

                    

                    if(option1 = "PriceComparator") then{
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { l.sortBy(new ProductComparator,option2);};
                            o:Object => {abort();};
                        esac;

                    }else 0 fi;
                    if(option1 = "RankComparator") then{
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { l.sortBy(new RankComparator,option2);};
                            o:Object => {abort();};
                        esac;

                    }else 0 fi;
                    if(option1 = "AlphabeticComparator") then{
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { l.sortBy(new AlphabeticComparator,option2);};
                            o:Object => {abort();};
                        esac;

                    }else 0 fi;

                };
            } else 0 fi;

(*  *****************************************************
    ***************  PRINT  ***************************** *
    *****************************************************
    ****************************************************
    ****************************************************  *)

            if(somestr = "print")then {

                cmd <- cmd.extractNext();
                
                if(isvoid cmd) then { print(0); } else {
                    aux <- cmd.getContent();
                    case aux of
                        s : String => { print( new A2I.a2i_aux(s) ); };
                        o : Object => { abort(); " " ;};
                    esac;
                }fi;
            } else 0 fi;

            --out_string("s-a terminat bucla \n");
            } pool;

    }    
    };

    load(cmd : List) : Object {   -- cate o linie
        let 
            cpy : List <- lists,
            null : List,
            count:Int <- 0,
            type: String,
            arg1_str:String,
            arg2_str:String,
            arg3_int:Int,
            arg4_bool:Bool,
            aux:Object,
            sumProductType:Int <- 0,
            sumRankType:Int <- 0
            in{
                
                while( count < listsLength) loop{
                    cpy   <- cpy.extractNext();
                    count <- count+1 ;
                } pool;

                aux <- cmd.getContent();
                case aux of 
                    s : String => { type <- s ;};
                    o : Object => { abort(); ""; };
                esac;
                if(type = "IO") then {
                    cmd <- cmd.extractNext();
                        if( isvoid cpy ) then{
                            cpy <- (new List).init(
                                (new List).init(new IO,null)
                                ,null);
                                --out_string("\nam initializat lista\n");
                                if (isvoid lists ) then {lists <- cpy;} else {
                                    lists.add((new List).init(new IO,null));
                                }fi;
                            } else {
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(new IO); };
                                    o : Object => { abort(); "";};
                                esac;
                                --out_string("\nam adaugat in lista cu .add \n");
                            } fi;
                } else 0 fi;
                if(type = "Bool") then {
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg4_bool <- if(s = "true") then true else false fi ;};
                        o : Object => { abort(); "";};
                    esac;
                        if( isvoid cpy ) then{
                            cpy <- (new List).init(
                                (new List).init(arg4_bool,null)
                                ,null);
                                --out_string("\nam initializat lista\n");
                                if (isvoid lists ) then {lists <- cpy;} else {
                                    lists.add((new List).init(arg4_bool,null));
                                }fi;
                            } else {
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(arg4_bool); };
                                    o : Object => { abort(); "";};
                                esac;
                                --out_string("\nam adaugat in lista cu .add \n");
                            } fi;
                } else 0 fi;
                if(type = "Int") then {
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg3_int <- new A2I.a2i_aux(s) ;};
                        o : Object => { abort(); "";};
                    esac;
                        if( isvoid cpy ) then{
                            cpy <- (new List).init(
                                (new List).init(arg3_int,null)
                                ,null);
                                if (isvoid lists ) then {lists <- cpy;} else {
                                    lists.add((new List).init(arg3_int,null));
                                }fi;
                            } else {
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(arg3_int); };
                                    o : Object => { abort(); "";};
                                esac;
                            } fi;
                } else 0 fi;

                if(type = "String") then {
                    cmd <- cmd.extractNext();
                    aux <- cmd.getContent(); 
                    case aux of
                        s : String => { arg1_str <- s ;};
                        o : Object => { abort(); "";};
                    esac;
                        if( isvoid cpy ) then{
                            cpy <- (new List).init((new List).init(arg1_str,null),null);
                                if (isvoid lists ) then {lists <- cpy;} 
                                else {
                                    lists.add((new List).init(arg1_str,null));
                                }fi;
                            } 
                            else {
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(arg1_str); };
                                    o : Object => { abort(); "";};
                                esac;

                            } fi;
                } else 0 fi;

                sumProductType <- 0;
                if(type = "Product") then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Edible")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Soda")    then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Laptop")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Router")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(type = "Coffee")  then { sumProductType <- sumProductType+1; } else 0 fi;
                if(not sumProductType = 0) then { --if it's a product of any kind
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
                            if (isvoid lists ) then {lists <- cpy;} else {
                                lists.add((new List).init(auxi,null));
                            }fi;
                        } else {
                            aux <- cpy.getContent();
                            case aux of 
                                l : List => { l.add(auxi); };
                                o : Object => { abort(); "";};
                            esac;
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
                        cpy <- (new List).init((new List).init(auxi,null),null);
                            if (isvoid lists ) then {lists <- cpy;} else {
                                lists.add((new List).init(auxi,null));
                            }fi;

                        } else {
                            aux <- cpy.getContent();
                            case aux of 
                                l : List => { l.add(auxi); };
                                o : Object => { abort(); "";};
                            esac;

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
            if( index = 0 )then {
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
            } else 0 fi;

            if(listsLength+1 < index) then {abort();"";} else 0 fi;
            count <- 1;

            if( 0 < index) then {
                while( count < index) loop {
                    cpy <- cpy.extractNext();
                    count <- count + 1;
                } pool;
                aux <- cpy.getContent();

                case aux of 
                    l : List => { 
                        out_string(l.toString());
                        out_string("\n");
                        l <- l.extractNext();
                    };
                    o:Object => {abort(); "";};
                esac;
            }else 0 fi;
        }
    };

};

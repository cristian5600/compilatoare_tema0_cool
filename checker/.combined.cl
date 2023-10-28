(*  
    ProductFilter - elimin ̆a din list ̆a obiecte ce nu mostenesc Product
    RankFilter - elimin ̆a din list ̆a obiecte ce nu mos,tenesc Rank
*)
class ProductFilter inherits IO{
    filterList(list : List):Object{
        let index:Int<- 1,  
        cpy:List <- list,
        last:List,
        aux :Object,
        looping:Bool <- true,
        foundBad:Bool <- false,
        null:List

        in {
            while( not isvoid cpy ) loop{

                aux <- cpy.getContent();
                
                case aux of
                    p:Product => { 
                        if(foundBad = false) then {index<-index+1;} else 0 fi;
                        foundBad <- false;
                        last <- cpy;
                        cpy <- cpy.extractNext(); 
                    };
                    o:Object => { 
                        --out_string("help");
                        
                        foundBad <- true;
                        list.extractRemoveElement(index);

                        if(isvoid last) then { 
                            aux <- list.getContent();
                            case aux of
                                e : Empty => { cpy <- null; };
                                o : Object => { cpy<- list; };
                            esac;

                            
                            foundBad <- false; 
                        } else { cpy<-last; }fi;

                    };
                esac;
                if(10 < index) then {abort();"";} else 0 fi;
            }pool;
        }
    };
};


class RankFilter inherits IO{
    filterList(list : List):Object{
        let index:Int<- 1,  
        cpy:List <- list,
        last:List,
        aux :Object,
        looping:Bool <- true,
        foundBad:Bool <- false,
        null : List

        in {
            while( not isvoid cpy ) loop{

                aux <- cpy.getContent();
                
                case aux of
                    r:Rank => { 
                        if(foundBad = false) then {index<-index+1;} else 0 fi;
                        foundBad <- false;
                        last <- cpy;
                        cpy <- cpy.extractNext(); 
                    };
                    o:Object => { 
                        
                        foundBad <- true;
                        list.extractRemoveElement(index);

                        --if(isvoid last) then { cpy<list; foundBad <- false; } else { cpy<-last; }fi;
                        if(isvoid last) then { 
                            aux <- list.getContent();
                            case aux of
                                e : Empty => {  cpy <- null; };
                                o : Object => { cpy<- list; };
                            esac;

                            
                            foundBad <- false; 
                        } else { cpy<-last; }fi;

                    };
                esac;
                --if(10 < index) then {abort();"";} else 0 fi;
            }pool;
        }
    };
};class List inherits IO{

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
    setContent(o:Object):Object{
        elem <-o
    };
    add(obj : Object):SELF_TYPE {
        let null:List,
            coppy:List <- self,
            aux : List <- new List.init(obj,null)  
                in 
                {
                    coppy.setNext(self.extractNext());
                    while ( not (isvoid coppy.extractNext()) ) loop
                    {
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
            result:String <- "[ " in --self.getContent().type_name() in 
            {
                
                aux <- coppy.getContent();
                --out_string(aux.type_name());
                case aux of
                        p : Product => {result <- result.concat(p.toString());};  
                        r : Rank => {   result <- result.concat(r.toString());};        
                        s : String => {  result <- result.concat("String").concat("(").concat(s).concat(")"); };  --self.type_name().concat("(").concat(name).concat(";").concat(model).concat(")")
                        e : Empty => { 1=1; };
                        o : Object  => { abort(); "";};
                esac;
                while ( not (isvoid coppy.extractNext()) ) loop
                {
                    coppy <- coppy.extractNext();
                    --out_string("AM INTRAT in lista\n");
                    aux <- coppy.getContent();
                    case aux of
                        p : Product => {result <-(result.concat(", ").concat(p .toString()));};
                        p1 : Edible => {result <-(result.concat(", ").concat(p1.toString()));};
                        p2 : Soda => {result <-  (result.concat(", ").concat(p2.toString()));};
                        p3: Coffee => {result <- (result.concat(", ").concat(p3.toString()));};
                        p4 : Laptop => {result <-(result.concat(", ").concat(p4.toString()));};
                        p5 : Router => {result <-(result.concat(", ").concat(p5.toString()));};

                        r : Rank => {   result <-(     result.concat(", ").concat(r .toString()));};
                        r1 : Private => {   result <- (result.concat(", ").concat(r1.toString()));}; 
                        r2 : Corporal => {   result <-(result.concat(", ").concat(r2.toString()));}; 
                        r3: Sergent => {   result <-  (result.concat(", ").concat(r3.toString()));}; 
                        r4 : Officer => {   result <- (result.concat(", ").concat(r4.toString()));}; 

                        i : Int => { result <- result.concat(", Int").concat("(").concat(new A2I.i2a_aux(i)).concat(")"); };
                        s : String  => { result <- result.concat(", String").concat("(").concat(s).concat(")");};
                        b : Bool => { result <- result.concat(", Bool").concat("(").concat(
                            if(b = true) then "true" else "false" fi
                        ).concat(")"); };
                        io : IO => { result <- result.concat(", IO").concat("(").concat(")"); };
                        o : Object  => { abort(); ""; };
                    esac;
                }
                pool;
                --out_string(result);
                --result.concat(")");
                result <- result.concat(" ]");
                result;
            }

    };
    
    merge(other : List):SELF_TYPE {
    {
        --out_string("\nAM INTRAT IN MERGE\n");
        let count:Int ,
        cpy:List <- self,
        cpy2:List <- self
        in{
            while( not isvoid cpy.extractNext() ) loop{
                cpy <- cpy.extractNext();
                --out_string("infit?\n");

            } pool;
            --cpy.setNext(other);
            --out_string("inainte: ").out_string(cpy2.toString());

            if( not isvoid other ) then{
                cpy.setNext(other);
            } 
            else {abort();"";} fi;

            --out_string("dupa ").out_string(cpy2.toString());
        };

        -- if( not isvoid other ) then{
        -- setNext(other);
        -- } else {abort();"";} fi;
        --out_string("\nAM iesit din MERGE\n");
        self;
    }
    };



    extractRemoveElement(index : Int):Object{
    {
        --out_string("\nAM INTRAT IN extractRemoveElement \n");
        let aux:Object,
        auxList:List,
        cpy:List <- self,
        lastElement :List,
        null : List,
        count:Int <- 1 ,
        result: Object 

        in{
            while(not isvoid cpy) loop{   

                if( count = index ) then { 
                    result <- cpy.getContent();

                    if(not isvoid lastElement) then {
                         lastElement.setNext( cpy.extractNext() ); 
                    } else 0 fi;
                    cpy <- null;
                } 
                else {
                    lastElement <- cpy;
                    cpy <- cpy.extractNext();
                } fi;  

                if(index = 1) then {
                    -- out_string("CEVA DUBIOS\n ");


                    result <- self.getContent();
                    auxList <- self;
                    auxList <- auxList.extractNext();
                    aux <- auxList;
                    if (isvoid aux ) then 
                    { 
                        self.setNext(null);
                        self.setContent(new Empty);
                    }
                    else  
                    {
                        self.setNext(auxList.extractNext());
                        self.setContent(auxList.getContent());
                    } fi;


                    
                    cpy <- null;
                } else 0 fi;

                count <- count+1;
            }pool;

            -- if(not isvoid lastElement) then { lastElement.setNext(null); } else 0 fi;
            if(isvoid result) then {out_string("\n NU E VOIE SA EXTRAGI VOID!!!!!!!!!!!!! \n");} else 0 fi;
            
            result;
        };
    }
    };

    filterBy():SELF_TYPE {
        self (* TODO *)
    };

    sortBy():SELF_TYPE {
        self (* TODO *)
    };
};

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
        let input:String <- "?",    -- SE FACE UN LOAD()
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
                    aux : Object in{
                        elem.init((new Rank).init("marinescu"),null);
                        elem.add((new Soda).init("c","d",67));
                        elem.add((new Coffee).init("e","f",632));
                        elem.add((new Laptop).init("g","h",4545));
                        elem.add((new Router).init("cads","dsd",2167));
                        elem.add((new Rank).init("marinescu")); --SELF_TYPE necesitate la init
                        elem.add((new Corporal).init("marinescu"));
                        elem.add((new Sergent).init("wwcu"));
                        elem.add((new Coffee).init("e","f",632));
                        elem.add((new Sergent).init("wwcu"));
                        elem.add((new Coffee).init("e","f",632));
                        elem.add((new Sergent).init("wwcu"));
                        elem.add(2);
                        elem.add((new Coffee).init("e","f",632));
                        elem.add((new Sergent).init("wwcu"));
                        out_string(elem.toString()).out_string("\n");
                        new RankFilter.filterList(elem);
                        --elem.extractRemoveElement(1);

                        out_string(elem.toString());
                        

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
(*  *****************************************************
    ***************  MERGE  ***************************** *
    *****************************************************  *)
            if(somestr = "merge") then {
                --out_string("\n SE FACE MERGE ");
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

                            --cpy.getContent().merge(toAdd);
                            aux <- cpy.getContent();
                            case aux of 
                                l : List => { l.merge(toAdd); };
                                o:Object => {abort(); " ";};
                            esac;
                            -- if (arg1_merge = 1) then{
                            --     if(isnull lists.extractNext() ) then{
                            --        1=1; 


                            --     } else 0 fi;
                            -- }else 0 fi;

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
    *****************************************************  *)

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
                            l:List => { new ProductFilter.filterList(l); };
                            o:Object => {abort();};
                        esac;
                    }else 0 fi;
                    if(option="RankFilter") then {
                        aux <- cpy.getContent();
                        case aux of
                            l:List => { new RankFilter.filterList(l); };
                            o:Object => {abort();};
                        esac;
                    }else 0 fi;

                };
            
            } else 0 fi;

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
            current : List,
            count:Int <- 0,
            m : Object,
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
                    --out_string(" \n AM INTRAT IN WHILE");
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
                    -- aux <- cmd.getContent(); 
                    -- case aux of
                    --     s : String => { arg4_bool <- if(s = "true") then true else false fi ;};
                    --     o : Object => { abort(); "";};
                    -- esac;
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
                                --out_string("\nam initializat lista\n");
                                if (isvoid lists ) then {lists <- cpy;} else {
                                    lists.add((new List).init(arg3_int,null));
                                }fi;
                            } else {
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(arg3_int); };
                                    o : Object => { abort(); "";};
                                esac;
                                --out_string("\nam adaugat in lista cu .add \n");
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

                --if ( 1 < listsLength ) then {out_int(count).out_string(": ");} else 0 fi;

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
        (self.type_name()).concat("(").concat(name).concat(";").concat(model).concat(")")
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

class Empty {
    toString():String{
        ""
    };
};
Class Token inherits IO{

    whereSpace(str:String):Int{
        
            let 
            i:Int<-0,
            l:Int<-0,
            result:Int<-0
            in
            {
                while (i<str.length()) loop{
                    if(str.substr(i,1) = " ") then
                        {
                        result <- i;
                        i<-str.length();
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

                    len <- whereSpace(coppy); 

                    aux <- coppy.substr(0,len);
                    
                    i <- len;

                    coppy <- coppy.substr(i+1,coppy.length()-i-1);
                    
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
                    --out_string("aux:").out_string(coppy).out_string("\n");
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

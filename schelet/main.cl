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
                        
                        out_string(elem.toString());
                        
                        

                };

                out_string("\n---");
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
                            --loopingLoad <- false;
                            let mylist:List,
                                token:Token <- new Token ,
                                command : List
                                in{

                                mylist <- token.getTokenList( input );
                                --command<- token.getTokenList( input );
                                -- mylist.add(new Product.init("sdf ","afds", 1312));

                                -- if(isvoid lists) then{
                                --     lists <- new List.init(mylist, void);
                                -- } else { lists.add(mylist) ;} fi ;
                                load(mylist);
                                
                                -- out_string("\n");
                                -- out_string(mylist.toString());
                                };
                        } 
                        else { loopingLoad <- false; } fi;
                        }pool;

                        listsLength <- listsLength + 1;

                        print(1);
                    }; 
                    
                    
                    
                    
            
            } else 0 fi; 

            -- if ( somestr = "print" ) then {
            --     out_string("\n PRINTING: \n");
            --     aux <- lists.getContent();
            --     case aux of 
            --         l : List => { out_string(l.toString()) ;};
            --         o : Object  => { abort(); "";};
            --     esac;
            -- } else 0 fi;
            

            } pool
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
            aux:Object
            in{
                
                while( count < listsLength) loop{
                    out_string(" \n AM INTRAT IN WHILE");
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
                                out_string("\nam initializat lista\n");

                                if (isvoid lists ) then {lists <- cpy;} else {
                                    lists.add((new List).init(arg1_str,null));
                                }fi;
                                

                            } else {
                                -- cpy<-cpy.getContent(); --- TODO
                                aux <- cpy.getContent();
                                case aux of 
                                    l : List => { l.add(arg1_str); };
                                    o : Object => { abort(); "";};
                                esac;

                                out_string("\nam adaugat in lista cu .add \n");
                                -- cpy.add(arg1_str);
                            } fi;
                            -- cpy <- cpy.extractNext();
                } else 0 fi;

            }
    };
    print(index : Int) : Object {
        let cpy: List <- lists,
        aux: Object,
        count:Int <- 0
         in
        {
            out_string( "\nse printeaza se printeaza:\n" );
            while( count < listsLength) loop {

                aux <- cpy.getContent();
                case aux of 
                    l : List => { 
                        out_string(l.toString());
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

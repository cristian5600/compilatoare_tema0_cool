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
        next
    };

    setNext(l:List) : List{
        next <- l
    };
    getContent() : Object {
        elem
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
            result:String <- "[ " in 
            {
                aux <- coppy.getContent();
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
                result <- result.concat(" ]");
                result;
            }

    };
    
    merge(other : List):SELF_TYPE {
    {
        let count:Int ,
        cpy:List <- self,
        cpy2:List <- self
        in{
            while( not isvoid cpy.extractNext() ) loop{
                cpy <- cpy.extractNext();
            }pool;

            if( not isvoid other ) then{
                cpy.setNext(other);
            }else {abort();"";} fi;

        };
        self;
    }
    };



    extractRemoveElement(index : Int):Object{
    {
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
            if(isvoid result) then {out_string("\n NU E VOIE SA EXTRAGI VOID!!!!!!!!!!!!! \n");} else 0 fi;
            result;
        };
    }
    };

    sortBy(cmp:Comparator, option:String):SELF_TYPE {
        let aux:Object ,
        cpy:List,
        temp:List,
        min:List,
        r:List,
        cmp_result:Int
        in{
            cpy <- self;
            temp <-cpy;
            while (not isvoid temp) loop{
                min <- temp;
                r <- temp.extractNext();
                while( not isvoid r) loop{
                    cmp_result <- cmp.compare(min.getContent(),r.getContent());
                    if(option = "descendent") then cmp_result<-cmp_result*(1-2) else 0 fi;

                    if ( 0 < cmp_result )then {
                        min <- r;
                    }  else 0 fi;

                    r <- r.extractNext();
                }pool;
                
                aux <- temp.getContent();
                temp.setContent(min.getContent());
                min.setContent(aux);
                temp <- temp.extractNext();

                
            }pool;
            self;
        }
    };
};


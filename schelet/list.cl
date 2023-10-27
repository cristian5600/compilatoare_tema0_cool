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
            result:String <- "[ " in --self.getContent().type_name() in 
            {
                
                aux <- coppy.getContent();
                --out_string(aux.type_name());
                case aux of
                        p : Product => {result <- result.concat(p.toString());};  
                        r : Rank => {   result <- result.concat(r.toString());};        
                        s: String => {  result <- result.concat("String").concat("(").concat(s).concat(")"); };  --self.type_name().concat("(").concat(name).concat(";").concat(model).concat(")")
                        o : Object  => { abort(); "";};
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
                        r : Rank => {   result <-(result.concat(r.toString()));}; 
                        s : String  => { result <- result.concat(", String").concat("(").concat(s).concat(")");};
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
        self (* TODO *)
    };

    filterBy():SELF_TYPE {
        self (* TODO *)
    };

    sortBy():SELF_TYPE {
        self (* TODO *)
    };
};


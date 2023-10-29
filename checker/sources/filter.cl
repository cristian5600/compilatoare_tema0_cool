class Filter inherits IO{
    filter(o : Object):Bool {true}; -- returnes true if it filtered something out
};

class ProductFilter inherits Filter{
    filter(o : Object):Bool{
        let index:Int<- 1,  
        cpy:List,
        list:List,
        last:List,
        aux :Object,
        looping:Bool <- true,
        result:Bool <- false,
        foundBad:Bool <- false,
        null:List

        in {
            case o of
                l:List => {cpy <- l;list <- l;};
                o:Object =>{abort();"";};
            esac;

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
                        result <- false;
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
            result;
        }
    };
};

class RankFilter inherits Filter{
    filter(o : Object):Bool{
        let index:Int<- 1,  
        cpy:List,
        list:List,
        last:List,
        aux :Object,
        result:Bool<-true,
        foundBad:Bool <- false,
        null : List
        in {
            case o of
                l:List => {cpy <- l;list <- l;};
                o:Object =>{abort();"";};
            esac;

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
                        result <- false;
                        foundBad <- true;
                        list.extractRemoveElement(index);
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
            }pool;

            result;
        }
    };
};
class SamePriceFilter inherits Filter{
    filter(o : Object):Bool{
        let index:Int<- 1,  
        cpy:List,
        list:List,
        last:List,
        aux :Object,
        result:Bool<-true,
        foundBad:Bool <- false,
        null : List,
        priceAsProduct:Int,
        price:Int
        in {
            case o of
                l:List => {cpy <- l;new ProductFilter.filter(l);list<-l;};
                o:Object =>{abort();"";};
            esac;
            
            while( not isvoid cpy ) loop{
                aux <- cpy.getContent();
                case aux of 
                    p : Product => { price <- p.getprice(); 
                                    priceAsProduct <- (new Product).init("-","-",p.getStartPrice()).getprice();};
                    e : Edible =>  { price <- e.getprice(); 
                                    priceAsProduct <- (new Product).init("-","-",e.getStartPrice()).getprice(); };
                    s: Soda    =>  { price <- s.getprice(); 
                                    priceAsProduct <- (new Product).init("-","-",s.getStartPrice()).getprice(); };
                    c : Coffee =>  { price <- c.getprice(); 
                                    priceAsProduct <- (new Product).init("-","-",c.getStartPrice()).getprice(); };
                    l : Laptop =>  { price <- l.getprice(); 
                                    priceAsProduct <- (new Product).init("-","-",l.getStartPrice()).getprice(); };
                    r : Router =>  { price <- r.getprice(); 
                                    priceAsProduct <- (new Product).init("-","-",r.getStartPrice()).getprice(); };
                    o : Object => {abort(); "";};
                esac;

                if(price = priceAsProduct) then{
                    if(foundBad = false) then {index<-index+1;} else 0 fi;
                        foundBad <- false;
                        last <- cpy;
                        cpy <- cpy.extractNext(); 
                }else{
                    result <- false;
                     foundBad <- true;
                        list.extractRemoveElement(index);
                        if(isvoid last) then { 
                            aux <- list.getContent();
                            case aux of
                                e : Empty => {  cpy <- null; };
                                o : Object => { cpy<- list; };
                            esac;
                            foundBad <- false; 
                        } else { cpy<-last; }fi;
                } fi; 
            }pool;
            result;
        }
    };
};
    

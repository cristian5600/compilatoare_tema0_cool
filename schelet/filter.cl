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
};

class SamePriceFilter inherits IO{
    filterList(list : List):Object{
        let index:Int<- 1,  
        cpy:List <- list,
        last:List,
        aux :Object,
        looping:Bool <- true,
        foundBad:Bool <- false,
        null : List,
        priceAsProduct:Int,
        price:Int
        in {
            new ProductFilter.filterList(list);
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
        }
    };
};

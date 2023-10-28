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
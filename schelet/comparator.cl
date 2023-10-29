(* Think of these as abstract classes *)
class Comparator {
    compare(o1 : Object, o2 : Object):Int {0};
};
--class RankComparator
class ProductComparator inherits Comparator{
    compare(o1: Object, o2:Object): Int{
            let aux:Object,
            price1:Int,
            price2:Int,
            result:Int<-0
            in{
                case o1 of
                    p:Product =>{ price1 <- p.getprice() ;};
                    o:Object => { abort();""; };
                esac;
                case o2 of
                    p:Product =>{ price2 <- p.getprice() ;};
                    o:Object => { abort();""; };
                esac;
                if( price1 < price2 ) then result<- (1-2) else 0 fi;
                if( price2 < price1 ) then result<-   1   else 0 fi;
                result;
            }
        };
};
(*Rank
Private
Corporal
Sergent
Officer
*)
class RankComparator inherits Comparator{
    
    compare(o1: Object, o2:Object): Int{
        let aux:Object ,
        score1:Int,
        score2:Int,
        result:Int<-0,
        str1:String,
        str2:String
        in{
            case o1 of
                r:Rank => {abort();"";};
                p:Private =>   { score1 <- 4; };
                c:Corporal =>  { score1 <- 3; };
                s: Sergent =>  { score1 <- 2; };
                off: Officer =>{ score1 <- 1; };
                o:Object => {abort();"";};
            esac;
            case o2 of
                r:Rank => {abort();"";};
                p:Private =>   { score2 <- 4; };
                c:Corporal =>  { score2 <- 3; };
                s: Sergent =>  { score2 <- 2; };
                off: Officer =>{ score2 <- 1; };
                o:Object => {abort();"";};
            esac;
            if( score1 < score2 ) then result<- 1      else 0 fi;
            if( score2 < score1 ) then result<- (1-2)           else 0 fi;
            if ( score2 = score1 ) then{
                case o1 of 
                    r: Rank => { aux <- r.getContent(); };
                    o : Object => {abort();};
                esac;
                case aux of
                    s : String => { str1 <- s; };
                    o : Object => {abort();};
                esac;


                case o2 of 
                    r: Rank => { aux <- r.getContent(); };
                    o : Object => {abort();};
                esac;
                case aux of
                    s : String => { str2 <- s; };
                    o : Object => {abort();};
                esac;

                result <- (new AlphabeticComparator.compare( str1,str2 ))*(2-1);
            } else 0 fi;
            result;
        }

    };
};

class AlphabeticComparator inherits Comparator {
    compare(o1: Object, o2:Object): Int{
        let len1:Int,
        len2:Int ,
        str1 : String,
        str2 : String,
        looping:Bool<-true,
        max:Int,
        i:Int<-0,
        result:Int <- 0
        in{
            case o1 of
                s:String => { str1 <- s; len1<-s.length(); };
                o:Object => { abort();};
            esac;
            case o2 of
                s:String => { str2 <- s; len2<-s.length(); };
                o:Object => { abort();};
            esac;
            if (len1 < len2) then max <- len1 else max <- len2 fi;


            while ( looping ) loop{
                if str1.substr(i, 1) < str2.substr(i, 1) then {
                    looping<-false;
                    result <-(1-2);
                } else 0 fi;

                if str2.substr(i, 1) < str1.substr(i, 1) then {
                    looping<-false;
                    result<- 1;
                } else 0 fi;
                i<-i+1;

                

                if (not i < max) then looping<-false else 0 fi;
            }pool;

            if (result = 0) then
            {
                if max < len1 then result <- 1 else 0 fi;
                if max < len2 then result <- (1-2) else 0 fi;
            }
            else 0 fi;

            result;
        }
    };
};








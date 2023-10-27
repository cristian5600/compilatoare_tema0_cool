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


Class Token inherits IO{
    -- mystring:String <-"";

    -- init(str:String):SELF_TYPE{
    -- {
    --     mystring <- str;
    --     self;
    -- }
    -- };
    whereSpace(str:String):Int{
        
            let 
            i:Int<-0,
            l:Int<-0,
            result:Int<-0
            in
            {
                --out_string("am intrat in hasSpace");
                while (i<str.length()) loop{
                    --out_string("\n sunt in while 1 ");
                    if(str.substr(i,1) = " ") then
                        {
                        result <- i;
                        i<-str.length();
                        --out_string("\n sunt in if 234");
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
                    

                    --out_string("coppy:").out_string(coppy).out_string("\n");

                    len <- whereSpace(coppy); 
                    
                    --out_string(" a \n");
                    aux <- coppy.substr(0,len);
                    
                    i <- len;

                    coppy <- coppy.substr(i+1,coppy.length()-i-1);
                    
                    -- out_string(" b \n");
                    
                    -- out_string("\naux=");
                    -- out_string(aux);
                    -- out_string("\nlen=");
                    -- out_int(len);
                    -- out_string("\ni=");
                    -- out_int(i);
                    -- out_string("\n\n");
                    
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
                    --ut_string("aux:").out_string(coppy).out_string("\n");
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
                --out_string(list.toString());
                --out_string("\ntype of content of list is ").out_string(list.getContent().type_name()).out_string("\n");
                list;
            }
    };

};


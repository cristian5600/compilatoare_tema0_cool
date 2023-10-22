class Main inherits IO{
    lists : List;
    looping : Bool <- true;
    somestr : String;

    main() : Object {
        {
            let p : Product <- new Product.init("nume","model",13) in{
                out_string(p.toString());
                0;
            };
            
        }
    };
};

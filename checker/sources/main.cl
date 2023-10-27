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
-- main():Object {
--         while looping loop {
--             out_string("Your name: ");
--             somestr <- in_string();
--             out_string("Hi ".concat(somestr).concat("\n"));
--         } pool
--     };

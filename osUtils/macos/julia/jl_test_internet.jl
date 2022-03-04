import ArgParse

let
    argset = ArgParse.ArgParseSettings()
    ArgParse.@add_arg_table! argset begin
        "url"
            help="The package name"
            default="www.google.com"
    end

    parsed_args = ArgParse.parse_args(ARGS, argset)
    test_url = parsed_args["url"]

    cmd = Cmd(["dig", "+time=1", "+tries=0", test_url])
    output = read(open(cmd), String)
    ok_hint = ";; ANSWER SECTION:"
    ok_flag = contains(output, ok_hint)
    ok_flag ? 
        @info("You are connected ;)") :
        @error("You are offline ;(")
    
    return nothing
end
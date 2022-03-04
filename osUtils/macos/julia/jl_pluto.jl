import ArgParse
import Pluto

## ---------------------------------------------------------
argset = ArgParse.ArgParseSettings()
ArgParse.@add_arg_table! argset begin
    "nbpath"
        help="The notebook path"
        default=""
end

parsed_args = ArgParse.parse_args(ARGS, argset)
nbpath = parsed_args["nbpath"]

# Check, install and load
using Pluto

# run
isempty(nbpath) ? Pluto.run() : Pluto.run(notebook=nbpath)
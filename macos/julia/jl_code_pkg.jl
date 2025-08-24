import Pkg
import ArgParse

## ---------------------------------------------------------
argset = ArgParse.ArgParseSettings()
ArgParse.@add_arg_table! argset begin
    "pkgdir"
        help=""
        default = pwd()
end

parsed_args = ArgParse.parse_args(ARGS, argset)
pkgdir = parsed_args["pkgdir"]

## ---------------------------------------------------------
pkgname = basename(pkgdir)
if isempty(pkgname) 
    @error("Package name not specified")
    exit()
end

if !isdir(pkgdir)
    pkgdir = joinpath(Pkg.devdir(), pkgname)
    isdir(pkgdir) && @info("Package found in dev")
end

if !isdir(pkgdir) 
    @error("Pkgdir not found", pkgdir)
    exit()
end

curr_proj = Base.current_project(pkgdir)
if isnothing(curr_proj)
    @error("Pkg project not found", pkgdir)
    exit()
end
pkgdir = dirname(curr_proj)

run(Cmd(["code", pkgdir]))
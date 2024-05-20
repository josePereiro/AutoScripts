using ArgParse
using InteractiveUtils

## ------------------------------------------------------------------------------------------------------------------
function _parse_args()
    s = ArgParseSettings()
    @add_arg_table! s begin
        "--root", "-r"
            help = "root folder for the project"
            arg_type = String
            default = pwd()
    end
    return parse_args(s)
end

## ------------------------------------------------------------------------------------------------------------------
let
    # Set up src and dest
    args = _parse_args()
    root = abspath(args["root"])
    # root = "/Users/Pereiro/University/Research/Metabolism/MaxEntEP2020/WIP/Chemostat_Tex/MaxEntEP/1.0_Introduction.tex"
    # !isdir(root) && error(root, " must exist!!!")

    mkpath(root)
    template_dir = joinpath(@__DIR__, "gen.templates")

    # Copy
    src = joinpath(template_dir, "main.tex")
    tex_file = dest = joinpath(root, "main.tex")
    isfile(dest) && error("Ovewrite is not allowed! Delete 'main.tex'")
    cp(src, dest; force = true)
    src = joinpath(template_dir, "main.bib")
    dest = joinpath(root, "main.bib")
    cp(src, dest; force = true)
    src = joinpath(template_dir, "images")
    dest = joinpath(root, "images")
    cp(src, dest; force = true)

    @info("Project generated!", root, tex_file)
end
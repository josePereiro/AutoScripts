using ArgParse

## ------------------------------------------------------------------------------------------------------------------
function _parse_args()
    s = ArgParseSettings()
        @add_arg_table! s begin
        "--proj", "-p"
            help = "the path to the project folder"
            arg_type = String
            default = pwd()
        "--dry-run", "-d"
            help = "Only verbosity, no action"
            arg_type = Bool
            default = false
    end
    return parse_args(s)
end

## ------------------------------------------------------------------------------------------------------------------
let
    EXT_TO_DELETE = [
        ".aux", ".bbl", ".blg", ".fdb_latexmk", ".fls", ".log", 
        ".out", ".synctex.gz", "__latexindent_temp.tex"
    ]

    args = _parse_args()
    projdir = args["proj"]
    dryrun = args["dry-run"]
    !isdir(projdir) && error(projdir, " not found")
    @info("Project", projdir); println()

    for file in readdir(projdir)
        file = joinpath(projdir, file)
        !isfile(file) && continue
        todel = any(endswith.([file], EXT_TO_DELETE))
        !todel && continue

        @info("Deleting", file);
        dryrun || rm(file; force = true)
    end
    
    println(); @info("Done")
end
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
        "--major", "-m"
            help = "Specified which major id to increment"
            arg_type = Int
            default = -1
        "--step", "-s"
            help = "The size of the increment"
            arg_type = Int
            default = 1
    end
    return parse_args(s)
end

function get_texfiles(projdir)
    iskkiping = ["__latexindent_temp.tex"]
    cd(projdir)
    return filter(readdir(projdir)) do file
        (file in iskkiping) && return false
        endswith(file, ".tex")
    end
end

## ------------------------------------------------------------------------------------------------------------------
let
    # args
    args = _parse_args()
    projdir = args["proj"]
    !isdir(projdir) && error(projdir, " not found!!!")
    dryrun_flag = args["dry-run"]
    major = args["major"]
    step = args["step"]
    @info("ARGS", projdir, 
        dryrun_flag, major
    ); println()
    cd(projdir)

    # read all files
    texfiles = get_texfiles(projdir)
    
    # rename
    renamed = Dict()
    for oldtexfile in texfiles
        sltm = split(oldtexfile, "_") |> first
        mstr = split(sltm, ".") |> first
        mint = tryparse(Int, mstr)
        @show mstr mint
        isnothing(mint) && continue

        mint < major && continue
        incmstr = string(mint + step)
        newtexfile = string(incmstr, oldtexfile[length(mstr) + 1:end])
        isfile(newtexfile) && continue
        
        @info("Renaming", oldtexfile, newtexfile)
        dryrun_flag || mv(oldtexfile, newtexfile; force = true)
        renamed[oldtexfile] = newtexfile
    end

    # replace in files
    println()
    texfiles = get_texfiles(projdir)
    for texfile in texfiles
        replaced = false
        filelines = readlines(texfile)
        for li in eachindex(filelines)
            fileline = filelines[li]
            for (olftexfile, newtexfile) in renamed
                
                !contains(fileline, olftexfile) && continue
                @info("Replacing", 
                    texfile, fileline, 
                    olftexfile, newtexfile
                )
                replaced = true
                filelines[li] = replace(fileline, olftexfile => newtexfile)
            end
        end
        !replaced && continue

        # write
        dryrun_flag || write(texfile, join(filelines, "\n"))
    end

    println()
    @info("DONE")
end

## ---------------------------------
let
    n = "1.2.3_file"
    m = 2
    mstr = string(m)
    nn = string(m, n[length(mstr) + 1:end])
end
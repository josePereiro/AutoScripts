using ArgParse
using InteractiveUtils

## ------------------------------------------------------------------------------------------------------------------
function _parse_args()
    s = ArgParseSettings()
    @add_arg_table! s begin
        "--src", "-s"
            help = "the main .tex source file"
            arg_type = String
            required = true
    end
    return parse_args(s)
end

## ------------------------------------------------------------------------------------------------------------------
let
    # Set up src and dest
    args = _parse_args()
    src_file = abspath(args["src"])
    # src_file = "/Users/Pereiro/University/Research/Metabolism/MaxEntEP2020/WIP/Chemostat_Tex/MaxEntEP/1.0_Introduction.tex"
    !isfile(src_file) && error(src_file, " dont found!!!")
    
    COMMENT_PREFIX = "%"

    lines = String[]
    for line in readlines(src_file)
        startswith(line, COMMENT_PREFIX) && continue
        isempty(line) && (push!(lines, "\n\n"); continue)
        contains(line, "\\begin") && (push!(lines, "\n", line); continue)
        contains(line, "\\end") && (push!(lines, line, "\n"); continue)
        push!(lines, line)
    end
    
    text = join(lines, " ")
    oldl = length(text)
    while true
        text = replace(text, " ." => ".")
        text = replace(text, "  " => " ")
        text = replace(text, " \n" => "\n")
        text = replace(text, "\n " => "\n")
        text = replace(text, ". " => ".\n")
        # text = replace(text, "\n\n" => "\n")
        
        l = length(text)
        oldl == l && break
        oldl = l
    end
    # text = replace(text, "\n" => "\n\n")

    clipboard(text)
    @info("Copied to clipboard!!!", src_file)
end
using BibTeX
using ArgParse

@error "This is not working. The 'src' and 'dest' .bib io system is missing. Fixxed at: $(@__FILE__)"
exit()

## ------------------------------------------------------------------------------------------------------------------
function parse_emptry()
    s = ArgParseSettings()
    @add_arg_table! s begin
        "--emptry", "-e"
            help = "the id of the emptry"
            arg_type = String
            required = true
    end
    parse_args(s)["emptry"]
end

## ------------------------------------------------------------------------------------------------------------------
function to_str(d, key)
    emd = d[key]
    head = string("@", emd["type"], "{", key, ",")
    body = []
    for (key, dat) in emd
        key in ["type"] && continue
        push!(body, string(key, " = {", dat, "}"))
    end
    string(head, "\n\t", join(body, ",\n\t"), "\n}")
end

## ------------------------------------------------------------------------------------------------------------------
let
    id = parse_emptry()

    SRC_BIB = "/Users/Pereiro/Documents/My Library.bib"
    # SRC_BIB = joinpath(@__DIR__, "SRC.bib")
    @assert isfile(SRC_BIB) DEST_BIB
    @info("SRC", SRC_BIB)
    DEST_BIB = "/Users/Pereiro/University/Research/Metabolism/MaxEntEP2020/WIP/Chemostat_Tex/MaxEntEP/MaxEntEP.bib"
    # DEST_BIB = joinpath(@__DIR__, "DEST.bib")
    @assert isfile(DEST_BIB) DEST_BIB
    @info("DEST", DEST_BIB)

    # read src
    SRC = read(SRC_BIB, String)
    src_preamble, src_result = parse_bibtex(SRC)
    !haskey(src_result, id) && (@error("id (\"$(id)\") misssing from \"$(SRC_BIB)\""); return)

    # read dest
    DEST = read(DEST_BIB, String)
    dest_preamble, dest_result = parse_bibtex(DEST)
    haskey(dest_result, id) && (@warn("id (\"$(id)\") already at \"$(SRC_BIB)\" (skiping)"); return)

    # Updating 
    NEW_STR = to_str(src_result, id)
    DEST *= "\n\n"
    DEST *= NEW_STR
    write(DEST_BIB, DEST)

    @info("Done!!!, emptry added!!!"); println()
    println(NEW_STR)
end
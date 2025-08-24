using FilesTreeTools

## ------------------------------------------------------------------
let 
    # Args
    ROOT = length(PARSED_ARGS) < 1 ? pwd() : abspath(first(PARSED_ARGS))
    DRY_RUN = haskey(PARSED_OPTS, "d")
    COPY_FLAG = haskey(PARSED_OPTS, "c")
    haskey(PARSED_OPTS, "f") || error("Filter [-f] not passed!!!")
    FILTER = Regex(PARSED_OPTS["f"])
    DEST_DIR = joinpath(pwd(), ".jl_collect")

    @info("OPTIONS", ROOT, DEST_DIR, FILTER, DRY_RUN, COPY_FLAG)
    println()
    
    keepout = String[".git", basename(DEST_DIR)]
    files = filterdown(ROOT; keepout) do path
        isfile(path) || return false
        m = match(FILTER, path)
        return !isnothing(m)
    end
    sort!(files; by = basename)
    println("Found: ", length(files))
    
    DRY_RUN || isdir(DEST_DIR) || mkdir(DEST_DIR)

    # Destinies rename (for duplicates)
    dests = String[]
    lastname = ""
    c = 0
    for src in files
        name = basename(src)
        if name == lastname
            c += 1
            name = string("[", c, "]", name)
        else
            lastname = name
            c = 0
        end
        dest = joinpath(DEST_DIR, name)
        push!(dests, dest)
    end

    # Copy/Print
    for (fi, (src, dest)) in enumerate(zip(files, dests))

        println("[", fi, "/", length(files), "] ", src)

        DO_ACTION = !DRY_RUN
        DO_ACTION &= COPY_FLAG
        DO_ACTION && cp(src, dest; force = true)
    end

end
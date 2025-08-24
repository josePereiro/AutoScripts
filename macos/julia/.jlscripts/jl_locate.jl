using JLAssistant
using FilesTreeTools

## ------------------------------------------------------------------
let 

    # Args
    config = JLAssistant._load_config()
    keepout = get(config, "JLLOCATE_KEEPOUTS", String[])
    ROOTS = get(config, "JLLOCATE_INCLUDES", String[])

    HOME_ROOT = homedir()
    haskey(PARSED_OPTS, "f") || error("Filter [-f] not passed!!!")
    FILTER = Regex(PARSED_OPTS["f"])
    @info("OPTIONS", HOME_ROOT, FILTER)
    println()

    lk = ReentrantLock()

    fi = 0
    for ROOT in ROOTS

        isdir(ROOT) || continue
        
        walkdown(ROOT; keepout, thfrec = 0.1) do path
            isfile(path) || return
            m = match(FILTER, path)
            isnothing(m) && return

            lock(lk) do
                fi += 1
                println("[", fi, "] ", path)
            end

        end
    end
    return nothing
end
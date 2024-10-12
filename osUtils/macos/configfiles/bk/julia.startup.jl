## --------------------------------------------------------
_isdir(p::String) = isdir(p)
_isdir(p) = false

function _locate(f::Function, root0)
    root0 = abspath(expanduser(root0))
    for (root, dirs, files) in walkdir(root0)
        for file in files
            endswith(file, ".jl") || continue
            path = joinpath(root, file)
            # println(path) # path to files
            for (li, line) in enumerate(eachline(path))
                f(line) || continue
                printstyled(line; color = :green)
                println()
                printstyled(path, ":", li; color = :blue)  
                println()
            end # for line
        end # for file
    end # walkdir
end

locate(f::Function, path::String) = _locate(f, path)

function locate(f::Function, mod0::Module)

    tolook = String[]
    for sym in names(mod0; imported = true,  all = true)
        mod = getfield(mod0, sym)
        isa(mod, Module) || continue
        pkg = pkgdir(mod)
        _isdir(pkg) || continue
        srcdir = joinpath(pkg, "src")
        push!(tolook, srcdir)
    end
    unique!(tolook)

    for path in tolook    
        _locate(f, path)
    end # for sym
end

locate(f::Function) = locate(f, Main)
locate(pt::String) = locate(pt, Main)

locate(pt::String, root0) =  locate(root0) do line
    contains(line, pt)
end
locate(pt::Regex, root0) =  locate(root0) do line
    !isnothing(match(pt, line))
end
locate(pt::Regex) = locate(pt, Main)

## --------------------------------------------------------
nothing
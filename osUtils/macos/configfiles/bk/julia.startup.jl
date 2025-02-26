## --------------------------------------------------------
using Revise

## --------------------------------------------------------
# CONFIG REGISTRY UPDATES
try
    import Pkg
    _flag = get(ENV, "JULIA_PKG_OFFLINE", "0") == "1"
    Pkg.offline(_flag)
catch ignore; 
    @error ignore
end

## --------------------------------------------------------
_isdir(p::String) = isdir(p)
_isdir(p) = false

_LOCATE_PATH0 = ["~/.julia", "~/Applications", "~/University", "~/Documents", "~/Downloads"]
_LOCATE_KEEPOUT = [".git"]
_LOCATE_THFREC = 0.4

import FilesTreeTools
function _locate(f::Function, root0; ext = ".jl", filter_ext = true)
    root0 = abspath(expanduser(root0))
    lk = ReentrantLock()
    thfrec = _LOCATE_THFREC
    keepout = _LOCATE_KEEPOUT
    FilesTreeTools.walkdown(root0; thfrec) do _path
        isfile(_path) || return :continue
        filter_ext && endswith(_path, ext) || return :continue
        # println(path) # path to files
        for (li, line) in enumerate(eachline(_path))
            f(line) || continue
            lock(lk) do
                printstyled(line; color = :green)
                println()
                printstyled(_path, ":", li; color = :blue)  
                println()
            end
        end # for line
    end
end

locate(f::Function, path::String) = _locate(f, path)
function locate(f::Function, path::Vector) 
    for path in path    
        _locate(f, path)
    end # for sym
end

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

    locate(f, tolook) 
end

locate(f::Function) = locate(f, _LOCATE_PATH0)
locate(pt::String) = locate(pt, _LOCATE_PATH0)

locate(pt::String, root0) =  locate(root0) do line
    contains(line, pt)
end
locate(pt::Regex, root0) =  locate(root0) do line
    !isnothing(match(pt, line))
end
locate(pt::Regex) = locate(pt, _LOCATE_PATH0)

## --------------------------------------------------------
nothing
import Pkg

# utils
function err_str(err; max_len = 10000)
    s = sprint(showerror, err, catch_backtrace())
    return length(s) > max_len ? s[1:max_len] * "\n[...]" : s
end

# avoid automatic precompilation
ENV["JULIA_PKG_PRECOMPILE_AUTO"] = 0 

# Registers
for url in [
        "https://github.com/FF-UH/CSC_Registry.jl"
    ]
    try

        @info("Adding registry", url)
        Pkg.Registry.add(Pkg.RegistrySpec(;url))
        println()

    catch err
        @error("Error doing: $url")
        @error(err_str(err))
        println()
    end
end


# Registered packages
let

    for pkg in [
            # ------------------------------------------------------
            # General
            
            # Tools
            "DrWatson", "ProgressMeter", "ArgParse", "LocalRegistry",

            # MultiThreadung/Processing
            "ThreadsX", 
            
            # Julia workflow
            "IJulia", "Pluto", "PlutoUI", "Revise", "PkgTemplates", "LanguageServer", 
            "OhMyREPL", "DaemonMode",

            # Images
            "Images", "ImageIO", "QuartzImageIO", "ImageMagick",

            # Plots
            "Plots", "PyPlot", "StatsPlots", "GR",

            # IO
            "FileIO", "BSON", "JSON", "SBML", "HDF5", "TOML",

            # Optimization
            "JuMP", "GLPK", "Clp", "Cbc", "Tulip", "OSQP", "Ipopt", "MadNLP.jl", "NLopt",

            # COBRA
            "COBREXA", "Escher"

        ]
        try
            @info("Adding $(pkg)")
            Pkg.add(pkg)
            Pkg.build(pkg)
            println()

        catch err
            @error("Error adding: $pkg")
            @error(err_str(err))
            println()
        end
    end
end

# Dev packages
let
    for pkg in [
            # ------------------------------------------------------
            # My packages (CSC_Registry)

            "JLAssistant", "TexAssistant", "ProjAssistant",
            "SimTools", "ImgTools",
            "ExternalCmds", "RegexTools", "PkgMassInstaller", "PkgInstaller",
            "GitWorkers", "GitLinks", 
            "SimpleLockFiles", "FilesTreeTools",
            "DataFileNames", 
            "MetLP", "MetNets", "MetEP",
        ]

        pkgdir = joinpath(Pkg.devdir(), pkg)

        try
            
            # clone if missing
            if !isdir(pkgdir)
                url = "https://github.com/josePereiro/$(pkg).jl"
                @info("Clonning", pkg, url)
                mkpath(pkgdir)
                run(`git clone $(url) $(pkgdir)`)
            end

            @info("Developing $(pkg)")
            Pkg.develop(;path=pkgdir)
            println()
            
        catch err

            @error("Error developing: $pkg")
            @error(err_str(err))
            println()

        end
    end
end

# precompile
Pkg.precompile()
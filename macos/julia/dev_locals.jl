## .-.-.-. . .. - -- - --- . .- .- - .- .- -
using ArgParse
using Pkg
using TOML
using JSON

# TODO: Move to JLAssistance

## .-.-.-. . .. - -- - --- . .- .- - .- .- -
argsets = ArgParseSettings()
@add_arg_table argsets begin
    "--pkgdir"
        help = "Path to the package directory (default: current directory)"
        arg_type = String
        default = pwd()
    "--dry-run"
        help = "Run without consequences."
        action = :store_true
end

args = parse_args(argsets)
pkgdir = args["pkgdir"]
dryrun = args["dry-run"]

## .-.-.-. . .. - -- - --- . .- .- - .- .- -
# MARK: Utils

import Pkg.activate
function Pkg.activate(f::Function, args...)
    bk = Base.active_project()
    try
        Pkg.activate(args...)
        f()
    finally
        Pkg.activate(bk)
    end
end


function foreach_proj(f::Function, root0=Pkg.devdir())
    for name in readdir(root0)
        pkg_path = joinpath(root0, name)
        isdir(pkg_path) || continue
        proj_path = joinpath(pkg_path, "Project.toml")
        isfile(proj_path) || continue
        Pkg.activate(proj_path) do
            f(Pkg.project())
        end
    end
end

function dev_projects(root0=Pkg.devdir())
    projects = Pkg.API.ProjectInfo[]
    foreach_proj(root0) do proj
        push!(projects, proj)
    end
    return projects
end

function read_config(key::String, dflt)
    # Attempt to load a clibox.json file
    # and retrieve 'key'
    # If fail, for any reason return 'dflt'
    config_path = joinpath(pwd(), "my-settings.json")
    try
        if isfile(config_path)
            config = JSON.parsefile(config_path)
            return get(config, key, dflt)
        end
    catch
        # Ignore errors and fall through
    end
    return dflt
end

## .-.-.-. . .. - -- - --- . .- .- - .- .- -
function ismatch(pt, txt::String)
    m = match(Regex(pt), txt)
    isnothing(m) && return false
    return true
end

function anymatch(pts::Vector, txt::String)
    isempty(pts) && return true
    for pt in pts
        ismatch(pt, txt) && return true
    end
    return false
end

## .-.-.-. . .. - -- - --- . .- .- - .- .- -
# MAIN
let
    # load config
    ignore_pts = read_config("dev-locals.ignore.regex.vec", [])
    @show ignore_pts



    # activate current
    isdir(pkgdir) || error("pkgdir not found")
    Pkg.activate(pkgdir)

    dev_names = [p.name for p in dev_projects()]
    for (uuid, pkgInf) in Pkg.dependencies()
        pkg_name = pkgInf.name
        any(pkg_name .== dev_names) || continue

        # Filter
        anymatch(ignore_pts, pkg_name) || continue

        println("-"^20)
        @show pkg_name
        if !dryrun
            Pkg.develop(pkg_name)
        end
    end
end


import Pkg
import Pkg: PackageSpec
import ArgParse

## ---------------------------------------------------------
argset = ArgParse.ArgParseSettings()
ArgParse.@add_arg_table! argset begin
    "pkgname"
        help="The package name"
        required=true
    "--version", "-v"
        help="The package version to add"
        default=""

end

parsed_args = ArgParse.parse_args(ARGS, argset)
pkgname = parsed_args["pkgname"]
version = parsed_args["version"]

@info("Adding package", pkgname, version)

## ---------------------------------------------------------
if isempty(version)
    Pkg.add(pkgname)
else
    version = replace(version, "v"=>"")
    version = VersionNumber(version)
    spec = PackageSpec(;name = pkgname, version)
    Pkg.add(spec)
end

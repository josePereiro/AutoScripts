import TexAssistant
let
    isempty(ARGS) && push!(ARGS, "-vcbo") # push defaults
    kwargs = TexAssistant._extract_sections_to_files_arg_parse(ARGS)
    TexAssistant.extract_sections_to_files(;kwargs...)
    return nothing
end
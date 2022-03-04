let
    import TexAssistant
    isempty(ARGS) && push!(ARGS, "-vc") # push defaults
    kwargs = TexAssistant._expand_inputs_parse_args(ARGS)
    TexAssistant.expand_inputs(;kwargs...)
    return nothing
end
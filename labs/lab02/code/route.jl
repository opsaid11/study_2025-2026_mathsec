msg = ARGS[1]
key = ARGS[2]
rows = parse(Int, ARGS[3])
cols = parse(Int, ARGS[4])

function col_order(k::AbstractString)
    idx = collect(1:length(k))
    sortperm(idx; by=i->(k[i], i))
end

function route_encrypt(s::AbstractString, k::AbstractString, r::Int, c::Int)
    t = replace(s, r"\s+" => "")
    need = r*c - length(t)
    t = need > 0 ? t * repeat("_", need) : t[1:r*c]
    M = [t[(i-1)*c + j] for i in 1:r, j in 1:c]
    ord = col_order(k)
    io = IOBuffer()
    for j in ord, i in 1:r
        print(io, M[i,j])
    end
    String(take!(io))
end

println(route_encrypt(msg, key, rows, cols))
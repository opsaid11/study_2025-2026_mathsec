text = ARGS[1]
key  = ARGS[2]
k    = parse(Int, ARGS[3])
pad  = length(ARGS) >= 4 ? ARGS[4] : "я"

function base_holes(k::Int)
    H = Tuple{Int,Int}[]
    for i in 1:k, j in 1:k
        push!(H, (i,j))
    end
    H
end

rot(n, p) = (p[2], n - p[1] + 1)

function place_block(s::AbstractString, k::Int, pad::AbstractString)
    n = 2k
    holes = base_holes(k)
    need = 4k^2 - length(s)
    u = need > 0 ? s * repeat(pad, need) : s
    G = fill(pad[1], n, n)
    t = 1
    cur = holes
    for _ in 1:4
        for (i,j) in cur
            G[i,j] = u[t]; t += 1
        end
        cur = [rot(n, p) for p in cur]
    end
    G
end

function grid_encrypt(msg::AbstractString, k::Int, pad::AbstractString, key::AbstractString)
    n = 4k^2
    io = IOBuffer()
    for a = 1:n:length(msg)
        blk = msg[a:min(a+n-1, end)]
        G = place_block(replace(blk, " "=>""), k, pad)
        ord = sortperm(collect(1:length(key)); by=i->(key[i], i))
        for j in ord, i in 1:2k
            print(io, G[i,j])
        end
    end
    String(take!(io))
end

println(grid_encrypt(text, k, pad, key))
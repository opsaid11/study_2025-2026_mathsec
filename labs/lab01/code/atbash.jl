msg = ARGS[1]
alp = length(ARGS) >= 2 ? ARGS[2] : "абвгдежзийклмнопрстуфхцчшщъыьэюя"

function build_map(alphabet)
    low = collect(alphabet)
    up  = collect(uppercase(alphabet))
    n = length(low)
    m = Dict{Char,Char}()
    for i in 1:n
        j = n - i + 1
        m[low[i]] = low[j]
        m[up[i]]  = up[j]
    end
    m
end

function atbash(msg, m)
    io = IOBuffer()
    for ch in msg
        print(io, get(m, ch, ch))
    end
    String(take!(io))
end

m = build_map(alp)
enc = atbash(msg, m)
println(enc)
println(atbash(enc, m))
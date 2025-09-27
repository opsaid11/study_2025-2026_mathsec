mode = ARGS[1]
text = ARGS[2]
key  = ARGS[3]
alp  = length(ARGS) >= 4 ? ARGS[4] : "abcdefghijklmnopqrstuvwxyz"

function maps(alp)
    lo = collect(alp); up = collect(uppercase(alp))
    D = Dict{Char,Int}(); L = Dict{Int,Char}(); U = Dict{Int,Char}()
    for i in 1:length(lo)
        D[lo[i]] = i; D[up[i]] = i
        L[i] = lo[i]; U[i] = up[i]
    end
    D, L, U, length(lo)
end

function vig(s, key, alp; enc=true)
    D, L, U, n = maps(alp)
    if isempty(key); return s; end
    kidx = [D[c] for c in collect(uppercase(key)) if haskey(D,c)]
    io = IOBuffer(); p = 1
    for ch in s
        if haskey(D,ch)
            ki = kidx[((p-1) % length(kidx)) + 1]
            si = D[ch]
            ni = enc ? (si + ki - 1) % n + 1 : (si - ki - 1) % n + 1
            print(io, ch == uppercase(ch) ? U[ni] : L[ni])
            p += 1
        else
            print(io, ch)
        end
    end
    String(take!(io))
end

println(mode == "e" ? vig(text, key, alp; enc=true) : mode == "d" ? vig(text, key, alp; enc=false) : "Wrong mode")
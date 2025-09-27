mode = ARGS[1]
msg  = ARGS[2]
key  = parse(Int, ARGS[3])

const RU = "абвгдежзийклмнопрстуфхцчшщъыьэюя"
const EN = "abcdefghijklmnopqrstuvwxyz"

function build_shift_map(alphabet, k)
    low = collect(alphabet)
    up  = collect(uppercase(alphabet))
    n = length(low)
    k = mod(k, n)
    fwd = Dict{Char,Char}()
    bwd = Dict{Char,Char}()
    for i in 1:n
        ni = (i + k - 1) % n + 1
        fwd[low[i]] = low[ni]
        fwd[up[i]]  = up[ni]
        bwd[low[ni]] = low[i]
        bwd[up[ni]]  = up[i]
    end
    fwd, bwd
end

function caesar(msg; enc, k)
    f_ru, b_ru = build_shift_map(RU, k)
    f_en, b_en = build_shift_map(EN, k)
    io = IOBuffer()
    for ch in msg
        if enc
            if haskey(f_ru, ch) print(io, f_ru[ch])
            elseif haskey(f_en, ch) print(io, f_en[ch])
            else print(io, ch) end
        else
            if haskey(b_ru, ch) print(io, b_ru[ch])
            elseif haskey(b_en, ch) print(io, b_en[ch])
            else print(io, ch) end
        end
    end
    String(take!(io))
end

if mode == "e"
    println(caesar(msg; enc=true, k=key))
elseif mode == "d"
    println(caesar(msg; enc=false, k=key))
else
    println("Wrong mode")
end
---
title: "Лабораторная работа №1 — Шифры простой замены"
author: "Степанов Иван Юрьевич"
date: 2025-09-27
lang: ru-RU
toc: true
toc-depth: 2
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float}
  - \floatplacement{figure}{H}
---

# Цель работы

Изучить шифры простой замены (Цезаря и Атбаш) и реализовать их на Julia.

# Задание

1. Реализовать шифр Цезаря с ключом *k*.
2. Реализовать шифр Атбаш.

# Краткая теория

- **Цезарь** — циклический сдвиг букв на *k* позиций по алфавиту; дешифрование — сдвиг на \(-k\).
- **Атбаш** — зеркальное отображение алфавита; сама себе обратна.

# Реализация (Julia)

## Цезарь

```julia
mode = ARGS[1]
msg  = ARGS[2]
key  = parse(Int, ARGS[3])

const RU = "абвгдежзийклмнопрстуфхцчшщъыьэюя"
const EN = "abcdefghijklmnopqrstuvwxyz"

function build_shift_map(alphabet, k)
    low = collect(alphabet); up = collect(uppercase(alphabet))
    n = length(low); k = mod(k, n)
    fwd = Dict{Char,Char}(); bwd = Dict{Char,Char}()
    for i in 1:n
        ni = (i + k - 1) % n + 1
        fwd[low[i]] = low[ni]; fwd[up[i]] = up[ni]
        bwd[low[ni]] = low[i]; bwd[up[ni]] = up[i]
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
```

**Пример:**
```
julia caesar.jl e "Привет, мир!" 5
julia caesar.jl d "<шифртекст>" 5
```

## Атбаш

```julia
msg = ARGS[1]
alp = length(ARGS) >= 2 ? ARGS[2] : "абвгдежзийклмнопрстуфхцчшщъыьэюя"

function build_map(alphabet)
    low = collect(alphabet); up = collect(uppercase(alphabet))
    n = length(low); m = Dict{Char,Char}()
    for i in 1:n
        j = n - i + 1
        m[low[i]] = low[j]; m[up[i]] = up[j]
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
```

**Пример:**
```
julia atbash.jl "Привет, мир!"
julia atbash.jl "Veni, vidi, vici." "abcdefghijklmnopqrstuvwxyz"
```

# Результаты

Получены корректные шифртексты и обратное восстановление исходных строк. Реализации поддерживают русский и английский алфавиты, сохраняют регистр, пунктуацию не изменяют.

# Выводы

Алгоритмы Цезаря и Атбаш реализованы и протестированы.

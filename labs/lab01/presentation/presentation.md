---
lang: ru-RU
title: "Шифры простой замены"
author: ["Степанов Иван Юрьевич"]
date: 2025-09-27
toc: false
slide_level: 2
aspectratio: 169
theme: metropolis
header-includes:
 - \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
---

# Цель

Изучить и реализовать на Julia шифры Цезаря и Атбаш.

# Задание

1. Шифр Цезаря с ключом *k*.  
2. Шифр Атбаш.

# Цезарь — идея

- Сдвиг букв на *k* позиций  
- Дешифрование: сдвиг на \(-k\)

# Цезарь — запуск

```
julia caesar.jl e "Привет, мир!" 5
julia caesar.jl d "<шифртекст>" 5
```

# Атбаш — идея

- Зеркальное отображение алфавита  
- Обратимость той же функцией

# Атбаш — запуск

```
julia atbash.jl "Привет, мир!"
julia atbash.jl "Veni, vidi, vici." "abcdefghijklmnopqrstuvwxyz"
```

# Выводы

Реализации корректны; примеры отработали как ожидается.

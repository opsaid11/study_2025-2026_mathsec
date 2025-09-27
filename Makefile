COURSE ?= mathsec

.PHONY: all help prepare clean

all: help

help:
	@echo Usage:
	@echo "  make prepare   - создать структуру папок (8 лаб с подпапками)"
	@echo "  make clean     - удалить созданную структуру"

# ----- Windows (cmd.exe) -----
ifeq ($(OS),Windows_NT)
SHELL := cmd
.SHELLFLAGS := /C

prepare:
	@if not exist labs mkdir labs
	@if not exist presentation mkdir presentation
	@if not exist template mkdir template
	@if not exist config mkdir config
	@mkdir labs\lab01\code
	@mkdir labs\lab01\report
	@mkdir labs\lab01\data
	@mkdir labs\lab02\code
	@mkdir labs\lab02\report
	@mkdir labs\lab02\data
	@mkdir labs\lab03\code
	@mkdir labs\lab03\report
	@mkdir labs\lab03\data
	@mkdir labs\lab04\code
	@mkdir labs\lab04\report
	@mkdir labs\lab04\data
	@mkdir labs\lab05\code
	@mkdir labs\lab05\report
	@mkdir labs\lab05\data
	@mkdir labs\lab06\code
	@mkdir labs\lab06\report
	@mkdir labs\lab06\data
	@mkdir labs\lab07\code
	@mkdir labs\lab07\report
	@mkdir labs\lab07\data
	@mkdir labs\lab08\code
	@mkdir labs\lab08\report
	@mkdir labs\lab08\data
	@echo $(COURSE)>COURSE
	@type nul > prepare
	@echo Структура создана.

clean:
	@if exist labs rmdir /s /q labs
	@if exist presentation rmdir /s /q presentation
	@if exist template rmdir /s /q template
	@if exist config rmdir /s /q config
	@if exist COURSE del COURSE
	@if exist prepare del prepare
	@echo Структура удалена.

# ----- Unix (bash/sh) -----
else

prepare:
	@mkdir -p labs/lab{01..08}/{code,report,data}
	@mkdir -p presentation template config
	@printf "%s\n" "$(COURSE)" > COURSE
	@touch prepare
	@echo "Структура создана."

clean:
	@rm -rf labs presentation template config
	@rm -f COURSE prepare
	@echo "Структура удалена."

endif
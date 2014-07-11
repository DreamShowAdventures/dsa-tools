@echo off

rem Resizes the base icon image to common sizes for iOS and Android. Useful if you don't have an SVG.
rem @author Steve Richey

echo Processing images...

haxe -main resize/Resizer.hx -neko resize/Resizer.n

set "GENIOS="
set "GENAND="
if %1==all set GENIOS=1
if %1==ios set GENIOS=1
if %1==all set GENAND=1
if %1==android set GENAND=1

if defined GENIOS (
	neko resize/Resizer.n assets/icons/icon_base.png 22 25 29 40 44 50 57 58 60 72 76 80 114 120 144 152 1024
)

if defined GENAND (
	neko resize/Resizer.n assets/icons/icon_rounding_generator.svg 48 512 2048
)

if not defined GENIOS (
	if not defined GENAND (
		neko resize/Resizer.n %*
	)
)
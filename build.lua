module = "enlp"

sourcefiledir = "src"
sourcefiles  = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlplogo.sty", "bibcheck.sty"}
installfiles = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlplogo.sty", "bibcheck.sty"}
testfiledir  = "tests"
typesetfiles = {"docs/documentation.tex"}
checkengines = {"ptex", "uptex", "luatex"}
stdengine    = "latex"
checkruns = 4
texopts = "-interaction=nonstopmode -shell-escape"
bibtexexe = "pbibtex"
makeindexexe = "mendex"
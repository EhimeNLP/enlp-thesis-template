module = "enlp"

sourcefiledir = "src"
sourcefiles  = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlplogo.sty"}
installfiles = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlplogo.sty"}
-- typesetfiles = {"documentation.tex"}  
testfiledir  = "tests"
typesetfiles = {"docs/documentation.tex"}
checkengines = {"ptex", "uptex", "luatex"}
stdengine    = "latex"
checkruns = 4
texopts = "-interaction=nonstopmode -shell-escape"
bibtexexe = "pbibtex"
makeindexexe = "mendex"
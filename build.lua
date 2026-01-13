module = "enlp"

sourcefiledir = "src"
sourcefiles  = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlplogo.sty", "bibcheck.sty"}
installfiles = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlplogo.sty", "bibcheck.sty"}
testfiledir  = "tests"
typesetfiles = {"docs/documentation.tex"}
typesetexe   = "lualatex"
checkengines = {"ptex", "uptex", "luatex"}
stdengine    = "latex"
checkruns = 4
texopts = "-interaction=nonstopmode -shell-escape"
bibtexexe = "pbibtex"
makeindexexe = "mendex"

function runtest_tasks(name, run)
  if run == 1 then
    return "bibtex " .. name
  else
    return ""
  end
end
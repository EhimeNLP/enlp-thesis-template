module = "enlp"

sourcefiledir = "src"
sourcefiles = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlp-logo.sty"}
installfiles = {"enlp.cls", "enlpbbl.sty", "enlpbbl.bst", "enlp-logo.sty"}
testfiledir = "tests"
docfiledir = "docs"
typesetfiles = {"documentation.tex"}
typesetexe = "lualatex"
checkengines = {"ptex", "uptex", "luatex"}
stdengine = "latex"
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

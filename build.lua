module = "enlp"

sourcefiledir = "src"
sourcefiles = {"*.cls", "*.sty", "*.bst", "*.bbx", "*.cbx"}
installfiles = {"*.cls", "*.sty", "*.bbx", "*.cbx"}
bstfiles = {"*.bst"}
checkfiles = bstfiles
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

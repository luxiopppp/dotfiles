local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.funcion_node
local t = ls.text_node
local c = ls.choice_node

return {
  s("doc", {
    t("\\documentclass{article}"),
    t("\n\\usepackage{asmath}"),
    t("\n\\begin{document}\n"),
    i(1),
    t("\n\\end{document}")
  })
}

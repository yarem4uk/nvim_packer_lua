local status_ok, ls = pcall(require, 'luasnip')
if not status_ok then
  return
end
-- This is a snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s

-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep


ls.add_snippets("all", {
  s("jj", fmt("({}){}", { i(1), i(0) })),
  s("mm", fmt("[{}]{}", { i(1), i(0) })),

  s({ trig = '.or', regTrig = true, hidden = true },
    fmt("|| {}", { i(0) })),

  s({ trig = '.and', regTrig = true, hidden = true },
    fmt("&& {}", { i(0) })),

  s({ trig = '(name)(%.dd)', regTrig = true, hidden = false },
    f(function(_, snip)
      -- return 'autosnippets'
      return '{ ' .. snip.captures[1] .. ' }'
    end))

  -- s("BB", fmt([[ {{ }} {} ]], {i(1), i(0)})),
}, {
  type = "autosnippets"
})

-- snippet '(\w+(\.\w+)*)(\.dd)' "interpolation" rA

ls.add_snippets("lua", {
  -- s({trig = '(%w+(%.%w+)*)(%.dd)', regTrig = true, hidden = false},
  -- s({ trig = '(name)(%.dd)', regTrig = true, hidden = false },
  --   f(function(_, snip)
  --     -- return 'autosnippets'
  --     return '{ ' .. snip.captures[1] .. ' }'
  --   end))
  -- s("name", fmt("print({}){}", { i(1), i(0) })),
})

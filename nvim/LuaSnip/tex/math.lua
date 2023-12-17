local ls = require('luasnip');
local t = ls.text_node;
local i = ls.insert_node;

return {
	ls.snippet(
		{ trig = "equation" },
		{
			t("\\begin{equation}"),
			t({"", "\\begin{aligned}"}),
			t({"", ""}), i(1),
			t({"", "\\end{aligned}"}),
			t({"", "\\end{equation}"}),
		}
	),
	ls.snippet(
		{ trig = "eqnline" },
		{
			i(1), t(" &= "), i(2), t("\\\\")
		}
	)
}

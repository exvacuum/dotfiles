local ls = require('luasnip');
local extras = require('luasnip.extras');
local t = ls.text_node;
local i = ls.insert_node;
local p = extras.partial;
local r = extras.rep;

return {
	ls.snippet(
		{ trig = "setuparticle" },
		{
			t({
				"\\documentclass[titlepage, a4paper, 11pt]{article}",
				"\\usepackage[margin=1in, headheight=1cm]{geometry}",
				"\\usepackage[style=apa, backend=biber]{biblatex}",
				"\\usepackage{fancyhdr}",
				"\\addbibresource{bibliography.bib}",
				"\\let\\oldsection\\section",
				"\\renewcommand\\section{\\clearpage\\oldsection}",
				"",
				"\\begin{document}"
			}),
			t({"", "\\title{"}), i(1, "title"), t("}"),
			t({"", "\\author{Silas Bartha\\\\Software Engineering Technology, Conestoga College\\\\Professor "}), i(2, "professor"),
			t("\\\\"), i(3,"course"),  t("}"),
			t({"", "\\date{\\today}", "\\maketitle"}),
			t({
				"",
				"\\pagestyle{fancy}",
				"\\fancyhead{}",
				"\\fancyhead[R]{"
			}), r(1), t("}"),
			t({
				"",
				"",
				"\\printbibliography",
				"\\end{document}"
			})
		}
	),
	ls.snippet(
		{trig = "beg" },
		{
			t("\\begin{"), i(1, "equation"), t("}"),
			t({"", ""}), i(2),
			t({"", "\\end{"}), r(1), t("}")
		}
	)
}


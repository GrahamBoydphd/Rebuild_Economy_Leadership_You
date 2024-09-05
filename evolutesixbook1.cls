%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evolutesix Book
% LaTeX Class
% Version 1.2 (2020-10-24)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{evolutesixbook1}[2020/02/20 Evolutesix Book Class v2.1]

% Store which book is being created for conditionally changing document layout based on the value
\newcommand{\book}[1]{\renewcommand{\book}{#1}}
\DeclareOption{graham}{\book{graham}}
\DeclareOption{robert}{\book{robert}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extbook}} % Pass through any options to the base class
%\DeclareOption{6x9paper} {\setlength\paperheight{9in} \setlength\paperwidth{6in}}
\ProcessOptions\relax % Process given options

\LoadClass{extbook} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------

% TODO remove the [demo], it's just because images are missing
%\usepackage[demo]{graphicx} % Required for including images
\usepackage{graphicx} % Required for including images
\graphicspath{{Images/}{./}} % Specifies where to look for included images (trailing slash required)

% Table packages
\usepackage{booktabs} % Required for better horizontal rules in tables
\usepackage{colortbl} % Required for changing the colour of table rules
%\usepackage{rotating} % Required for rotating tables
\usepackage{longtable} % Required for tables that span multiple pages automatically

% Graham's packages
\usepackage{layout}

\usepackage[utf8]{inputenc} % Required for inputting international characters
\usepackage[T1]{fontenc} % Output font encoding for international characters
\usepackage{csquotes}
\usepackage{CJKutf8}  %For Kanji
\usepackage{textcomp}
\usepackage{eurosym}
\let\texteuro\euro  %makes the euro character typed in give the same euro symbol as \euro
\usepackage[UKenglish]{babel}
\usepackage{hyphenat} %attempt to better hyphenate compund words using \hyp{}
\usepackage{comment}

\usepackage{etoolbox} % Required for conditional logic

\usepackage{xpatch} % Allows easy modification of macros

\usepackage{emptypage} % This package removes headers and footers on empty pages between chapters

\usepackage{wrapfig} % Allows text to wrap around figures/floats
\usepackage[wide, innercaption,ragged]{sidecap} %Caption to the inside of the figure, side by side. Caption inner edge ragged.
\sidecaptionvpos{figure}{c} % sidecap caption vertically centred.

\usepackage[hang, flushmargin]{footmisc} % Required for modifying the footers to be flush against the left margin
\expandafter\ifstrequal\expandafter{\book}{graham}{\renewcommand{\footnoterule}{\noindent\textcolor{LightGrey}{\rule{1.5cm}{1pt}}}}{} % Change the footnote rule style and width in the graham style

\usepackage{fmtcount} % Allows converting numbers to words, e.g. 2 -> two

\usepackage{changepage} % Required for temporarily indenting text blocks

\usepackage{pdfpages} % Required for adding full page images

\usepackage{makeidx}  %required to make an index automatically

%\usepackage{showidx} %shows all index entries in the right margin



%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------


\usepackage[
%	a5paper, % Paper size
	paperheight=9in, paperwidth=6in,  %15.24 x 22.86 cm
	twoside,
	outermargin=1.0cm,
	hscale=0.90,  %
	vscale=0.80,  %Take 0.87 for the final version
	bindingoffset=2.0cm,
%	headsep=15pt, %was 19.9 originally
%	footskip=15pt,  %was 27.5pt originally
	headheight=16pt,
%	nomarginpar, %in final version
	vcentering,  %likely in final version
%	bottom=1.4cm,  %include for the final version
%	showframe, % Uncomment to show the frames around the margins for debugging purposes
	showcrop %cropping marks for paper size
]{geometry}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------


\expandafter\ifstrequal\expandafter{\book}{graham}{
	\usepackage{ebgaramond} % Use EB Garamond as the serif font
}{}

\expandafter\ifstrequal\expandafter{\book}{robert}{
	\usepackage{libertinus} % Use Libertinus as the serif font
}{}

\usepackage{tgheros} % Use TeX Gyre Heros as the sans font

%----------------------------------------------------------------------------------------
%	BIBLIOGRAPHY
%----------------------------------------------------------------------------------------

\usepackage[backend=biber, 
%citestyle=numeric, 
%bibstyle=authoryear, 
bibstyle=numeric, 
citestyle=numeric-comp, %to give 1-5 ranges by Jhonny
sorting=none]{biblatex} % Use the biber backend which requires compiling with the biber engine

%------------------------------------------------

% Import the numeric style for outputting the bibliography (authoryear is used to order the components of each reference mainly so the year comes after authors)
%\makeatletter
%\input{numeric.bbx}
%\makeatother

%------------------------------------------------

% Create a new citation command to output references as superscript numbers in square brackets, @see https://tex.stackexchange.com/questions/60921/biblatex-supercite-command-with-use-of-square-brackets-like-a-reference-style-i
%\DeclareCiteCommand{\supercite}[\mkbibsuperscript]
%	{\iffieldundef{prenote}
%		{}
%		{\BibliographyWarning{Ignoring prenote argument}}%
%	\iffieldundef{postnote}
%		{}
%		{\BibliographyWarning{Ignoring postnote argument}}}
%	{\usebibmacro{citeindex}%
%		\bibopenbracket\usebibmacro{cite}\bibclosebracket}
%	{\supercitedelim}
%	{}

% Graham version to use numeric-comp 
% from https://tex.stackexchange.com/questions/114987/biblatex-supercite-with-square-brackets-and-grouped  
\DeclareCiteCommand{\supercite}[\mkbibsuperscript]
{\usebibmacro{cite:init}%
	\let\multicitedelim=\supercitedelim
	\iffieldundef{prenote}
	{}
	{\BibliographyWarning{Ignoring prenote argument}}%
	\iffieldundef{postnote}
	{}
	{\BibliographyWarning{Ignoring postnote argument}}%
	\bibopenbracket}%
{\usebibmacro{citeindex}%
	\usebibmacro{cite:comp}}
{}
{\usebibmacro{cite:dump}\bibclosebracket}

% Force standard \cite{} citations to use the supercite style
\let\cite=\supercite %removed by Jhonny


%------------------------------------------------

% Change the order of publisher and location with a comma between them
\renewbibmacro*{publisher+location+date}{%
	\printlist{publisher}%
	\setunit*{\addcomma\space}
	\printlist{location}%
	\newunit%
}

%------------------------------------------------

% Change the formatting of the volume and number
\renewbibmacro*{volume+number+eid}{%
	\textbf{\printfield{volume}}
	\setunit*{\addnbspace}
	\printfield{number}%
	\setunit{\addcomma\space}%
	\printfield{eid}%
}

%------------------------------------------------

% Remove brackets around the year
\xpatchbibmacro{date+extradate}{%
	\printtext[parens]%
}{%
	\setunit{\addperiod\space}% Replace parentheses with a full stop and space
	\printtext%
}{}{}

%------------------------------------------------

% Brackets around the journal number
\DeclareFieldFormat[article]{number}{\mkbibparens{#1}}

%------------------------------------------------

% Colon after volume/issue before pages
\renewcommand*{\bibpagespunct}{\addcolon\space}

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\usepackage{fancyhdr} % Required for customising headers and footers
\pagestyle{fancy} % Enable custom headers and footers

\renewcommand{\headrulewidth}{0pt} % Remove default top horizontal rule
\renewcommand{\chaptermark}[1]{\markboth{#1}{}} % Don't output the chapter number
\renewcommand{\sectionmark}[1]{\markright{#1}} % Don't output the section number

\fancyhf{} % Clear default headers/footers

\fancyhead[CE]{\leftmark} % Even page centred header
\fancyfoot[CE]{\thepage} % Even page centred footer

\fancyhead[CO]{\rightmark} % Odd page centred header
\fancyfoot[CO]{\thepage} % Odd page centred footer

%----------------------------------------------------------------------------------------
%	SECTIONS
%----------------------------------------------------------------------------------------

\usepackage[newparttoc]{titlesec} % Required for modifying sections

\newcommand{\redefinepart}[1]{ % Command to change the \part styling, takes an argument for an optional part description
	\titleformat
		{\part} % Section type being modified
		[display] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
		{\thispagestyle{empty}\sffamily\centering} % Format of the whole section
		{% Format of the section label
			\expandafter\ifstrequal\expandafter{\book}{robert}{\LARGE Part \thepart\\}{} % Part title
			\expandafter\ifstrequal\expandafter{\book}{graham}{
				\LARGE Part \Numberstring{part}\\ % Part title
				\vspace{-6pt}%
				\textcolor{LightGrey}{\rule{0.20\textwidth}{3pt}}\vspace{6pt}%
			}{} % Grey rule
		}
		{0pt} % Space between the title and label
		{\Huge} % Code before the label
		[\vspace{3\baselineskip}\parbox{\linewidth}{\rmfamily \Large #1}] % Code after the label
}

\redefinepart{} % Redefine \part{} to not output a part description (in case the user doesn't know about the custom \part commands below)

\newcommand{\partplain}[1]{ % Output a plain part with no description
	\cleardoublepage
	\redefinepart{} % Redefine \part{} to not output a part description
	\part{#1}
	\cleardoublepage
}

\newcommand{\partdescription}[2]{ % Output a part with a description
	\cleardoublepage
	\redefinepart{#2} % Redefine \part{} to output a part description
	\part{#1}
	\redefinepart{} % Redefine \part{} to not output a part description (reset to default)
	\cleardoublepage
}

%------------------------------------------------

\titleformat
	{\chapter} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\centering\sffamily} % Format of the whole section
	{\Large\bfseries CHAPTER \thechapter\\[\baselineskip]} % Format of the section label
	{0pt} % Space between the title and label
	{\huge} % Code before the label
	[] % Code after the label

\titlespacing*{\chapter}{0pt}{2\baselineskip}{5\baselineskip} % Spacing around section titles, the order is: left, before and after

%------------------------------------------------

\titleformat
	{\section} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\Large\sffamily\bfseries} % Format of the whole section
	{\thesection} % Format of the section label
	{5pt} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\section}{0pt}{\baselineskip}{4pt} % Spacing around section titles, the order is: left, before and after

%------------------------------------------------

\titleformat
	{\subsection} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\large\sffamily\bfseries} % Format of the whole section
%	{\thesubsection} % Format of the section label
%	{5pt} % Space between the title and label
	{} % Format of the section label GB NO NUMBER
	{0pt} % Space between the title and label GB FLUSH LEFT
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\subsection}{0pt}{\baselineskip}{4pt} % Spacing around section titles, the order is: left, before and after

%------------------------------------------------

\titleformat
	{\subsubsection} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\sffamily\bfseries} % Format of the whole section
%	{\thesubsubsection} % Format of the section label
%	{5pt} % Space between the title and label
	{} % Format of the section label GBNO NYMBER
	{0pt} % Space between the title and label  GB FLUSH LEFT
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\subsubsection}{0pt}{\baselineskip}{4pt} % Spacing around section titles, the order is: left, before and after

%----------------------------------------------------------------------------------------
%	TABLE OF CONTENTS
%----------------------------------------------------------------------------------------

\usepackage{titletoc} % Required for manipulating the table of contents

\renewcommand{\contentsname}{Table of Contents} % Rename the table of contents chapter heading

% https://tex.stackexchange.com/questions/17071/how-can-i-force-toc-not-to-end-with-a-chapter
% https://tex.stackexchange.com/questions/247687/book-table-of-contents-avoid-page-breaks-after-parts

\expandafter\ifstrequal\expandafter{\book}{graham}{
	\setcounter{tocdepth}{0} % Parts and chapters in the ToC; Use 1 or 2 for full ToC
	
	\titlecontents{part} % Section type being modified
		[0pt] % Left indentation
		{\vspace{32pt}\centering\sffamily\Large} % Before code % was 6 originally.
		{\bfseries PART \thecontentslabel:~\uppercase} % Formatting of numbered sections of this type
		{\bfseries\uppercase} % Formatting of numberless sections of this type
		{} % Formatting of the filler to the right of the heading
		[\vspace{6pt}] % After code
		
	%------------------------------------------------
	
	\titlecontents{chapter} % Section type being modified
		[0pt] % Left indentation
		{\vspace{10pt}\centering\sffamily} % Before code % was 6pt
		{\bfseries\thecontentslabel.~\uppercase} % Formatting of numbered sections of this type
		{\bfseries\uppercase} % Formatting of numberless sections of this type
		{~~\textemdash\textemdash~~\bfseries\thecontentspage} % Formatting of the filler to the right of the heading
		[\vspace{6pt}] % After code
		
	%------------------------------------------------


	\titlecontents{chapterdescription} % Section type being modified
		[0pt] % Left indentation
		{\centering} % Before code
		{} % Formatting of numbered sections of this type
		{} % Formatting of numberless sections of this type
		{} % Formatting of the filler to the right of the heading
		[\vspace{6pt}] % After code

% If a chapter description exists, set it to a level where it doesn't appear in the PDF bookmarks
\makeatletter
\providecommand*{\toclevel@chapterdescription}{3}
\makeatother
}



\expandafter\ifstrequal\expandafter{\book}{robert}{
	\setcounter{tocdepth}{1} % Parts, chapters and sections in the ToC
	
	\titlecontents{part} % Section type being modified
		[0pt] % Left indentation
		{\vspace{18pt}\large\bfseries} % Before code
		{\thecontentslabel~~~} % Formatting of numbered sections of this type
		{} % Formatting of numberless sections of this type
		{\hfill\bfseries\contentspage} % Formatting of the filler to the right of the heading
		[] % After code
	
	%------------------------------------------------
	
	\titlecontents{chapter} % Section type being modified
		[0pt] % Left indentation
		{\vspace{6pt}\large\bfseries} % Before code
		{\thecontentslabel~~~} % Formatting of numbered sections of this type
		{} % Formatting of numberless sections of this type
		{\hfill\bfseries\contentspage} % Formatting of the filler to the right of the heading
		[] % After code
	
	%------------------------------------------------
	
	\titlecontents{section} % Section type being modified
		[15pt] % Left indentation
		{} % Before code
		{\thecontentslabel~~} % Formatting of numbered sections of this type
		{} % Formatting of numberless sections of this type
		{\hfill\contentspage} % Formatting of the filler to the right of the heading
		[] % After code
}

%----------------------------------------------------------------------------------------
%	COLOURS
%----------------------------------------------------------------------------------------

\usepackage[usenames, svgnames]{xcolor} % Required for defining and using custom colours 
% See https://www.latextemplates.com/svgnames-colors for colours
% Try GhostWhite for lighter -- too light;
% and and Gainsboro for darker

\definecolor{cyan}{RGB}{0, 255, 255}
\definecolor{green}{RGB}{0, 255, 0}
\definecolor{storyblock}{RGB}{225, 225, 225}


%----------------------------------------------------------------------------------------
%	LISTS
%----------------------------------------------------------------------------------------

\usepackage{enumitem} % Required for list customisation

\setlist{itemsep=0pt, topsep=0pt} % Remove space between list items and above lists

%----------------------------------------------------------------------------------------
%	LINKS
%----------------------------------------------------------------------------------------

\usepackage{hyperref} % Required for links

\hypersetup{
	colorlinks=false,
	urlcolor=DarkSlateGrey, % Colour for \url and \href links
	linkcolor=DarkSlateGrey, % Colour for \nameref links
	hidelinks, % Hide the default boxes around links
}

%----------------------------------------------------------------------------------------
%	LONG STORY BLOCKS
%----------------------------------------------------------------------------------------

\newenvironment{longstoryblocktitle}[1]{
	\begin{tcolorbox}[
%		colback=GhostWhite, % Box content background colour
%		colframe=GhostWhite, % Title background and frame colour
%		colback=Gainsboro, % Box content background colour
%		colframe=Gainsboro, % Title background and frame colour
		colback=storyblock, % Box content background colour
		colframe=Gainsboro, % Title background and frame colour
		coltitle=black, % Title text colour
        top=2ex,  % GB add a little more space above
   		toptitle=0.4cm, % Top title padding
		bottomtitle=0.2cm, % Bottom title padding
		width=0.90\textwidth, % Box width
		center, % Horizontally centre the box on the page
%		sharp corners, % Don't round corners
		title=\MakeUppercase{#1}, % Box title
		fonttitle=\centering\sffamily\Large\bfseries, % Title text style
		breakable, % Box can break across pages
	]
}{
	\end{tcolorbox}
}

\newenvironment{longstoryblock}{
	\begin{tcolorbox}[
%		colback=GhostWhite, % Box content background colour
%		colframe=GhostWhite, % Title background and frame colour
%		colback=Gainsboro, % Box content background colour
%		colframe=Gainsboro, % Title background and frame colour
		colback=storyblock, % Box content background colour
		colframe=Gainsboro, % Title background and frame colour
        top=2ex,  % GB add a little more space above
		toptitle=0.0cm, % Top title padding
		bottomtitle=0.2cm, % Bottom title padding
		width=0.93\textwidth, % Box width
		center, % Horizontally centre the box on the page
%		sharp corners, % Don't round corners
		breakable, % Box can break across pages
	]
}{
	\end{tcolorbox}
}

%----------------------------------------------------------------------------------------
%	CHAPTER QUOTATIONS
%----------------------------------------------------------------------------------------


\newenvironment{chapterquotation}{
	\begin{adjustwidth}{0.15\textwidth}{0.15\textwidth} % Left indent then right indent
		\itshape
		\centering
		\setlength{\parskip}{0.5\baselineskip} % Space between pagraphs
	}{
	\end{adjustwidth}
	\vspace{2\baselineskip} % Whitespace below
}

%----------------------------------------------------------------------------------------
%	QUOTE ENVIRONMENT
%----------------------------------------------------------------------------------------

\renewenvironment{quote}{
	\begin{adjustwidth}{0.1\textwidth}{0.1\textwidth} % Left indent then right indent
		\itshape
		\setlength{\parskip}{0.5\baselineskip} % Space between pagraphs
}{
	\end{adjustwidth}
	\vspace{0.5\baselineskip} % Whitespace below
}

%----------------------------------------------------------------------------------------
%	QUOTATION ENVIRONMENT
%----------------------------------------------------------------------------------------

\renewenvironment{quotation}{
	\begin{adjustwidth}{0.1\textwidth}{0.1\textwidth} % Left indent then right indent
		\itshape
		\setlength{\parskip}{0.5\baselineskip} % Space between pagraphs
}{
	\end{adjustwidth}
	\vspace{0.5\baselineskip} % Whitespace below
}

%----------------------------------------------------------------------------------------
%	BOOK INFORMATION PAGE
%----------------------------------------------------------------------------------------

\newcommand{\bookinformationpage}[1]{
	\newpage
	
	\thispagestyle{empty} % Suppress headers and footers
	\begin{adjustwidth}{0.1\textwidth}{0.1\textwidth} % Left indent then right indent	
	\begin{center}
		#1
	\end{center}
	\end{adjustwidth}
}

%----------------------------------------------------------------------------------------
%	DEDICATION PAGE
%----------------------------------------------------------------------------------------

\newcommand{\dedicationpage}[1]{
	\cleardoublepage % Ensure the dedication is on an odd page
	
	\thispagestyle{empty} % Suppress headers and footers
	
	~\vfill % 1/3 whitespace
	\begin{adjustwidth}{0.2\textwidth}{0.1\textwidth} % Left indent then right indent
	\raggedleft
	\setlength{\baselineskip}{2.0\baselineskip} % Space between pagraphs
		\sffamily % Sans
		\textbf{#1} % The dedication text
	\end{adjustwidth}
	\vfill\vfill~ % 2/3 whitespace
}

%----------------------------------------------------------------------------------------
%	CUSTOM COMMANDS
%----------------------------------------------------------------------------------------

%\newcommand{\command}[1]{\renewcommand{\command}{#1}}

%----------------------------------------------------------------------------------------
%	LOAD PACKAGES THAT CLASH WITH OTHERS ABOVE
%----------------------------------------------------------------------------------------
\setcounter{biburllcpenalty}{7000}

%----------------------------------------------------------------------------------------
%	TABLES THAT AUTO-SET EACH CELL
%----------------------------------------------------------------------------------------
\usepackage{array, ragged2e}  %Added by Jhonny for better arrays
\newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}}p{#1}}
\newcolumntype{R}[1]{>{\RaggedLeft\hspace{0pt}}p{#1}}
\newcolumntype{C}[1]{>{\centering\hspace{0pt}}p{#1}}

\usepackage{makecell}

\usepackage[most]{tcolorbox} % Required for boxes that split across pages

\usepackage[nonumberlist,toc={false}]{glossaries-extra}  %automated glossary package
%\usepackage[nonumberlist, toc={true}, section=part, numberedsection={false}]{glossaries-extra}  %automated glossary package - not sure why this gives a doubled toc entry
\makeglossaries
\loadglsentries{./glossary.tex}
\glsaddall

%\usepackage{xurl} %An alternate to the \url command inside hyperref
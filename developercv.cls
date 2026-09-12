%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developer CV
% LaTeX Class
% Version 1.1 (February 24, 2025)
%
% This class originates from:
% https://www.LaTeXTemplates.com
%
% Authors:
% Jan Vorisek (jan@vorisek.me)
% Based on a template by Jan Küster (info@jankuester.com)
% Modified for LaTeX Templates by Vel (vel@LaTeXTemplates.com)
%
% License:
% The MIT License (see included LICENSE file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Layout only. Personal data lives in identity.tex; document content in
% resume.tex (EN) and curriculum.tex (ES).
%
% Package order below is deliberate: geometry -> fonts -> colour -> components,
% with hyperref LAST. hyperref patches internals of packages loaded before it and
% needs to see the final page geometry; it was previously loaded first, before
% geometry had run.

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{developercv}[2025/02/24 Developer CV class v1.1]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{extarticle} % Load the base class

\setlength{\parindent}{0mm} % Suppress paragraph indentation

\pagestyle{empty} % Suppress all headers or footers

\usepackage{moresize} % Provides more font size commands (\HUGE)

%----------------------------------------------------------------------------------------
%	PAGE LAYOUT
%----------------------------------------------------------------------------------------

\usepackage{geometry} % Required for adjusting page dimensions and margins

% No headheight/headsep/footskip here: \pagestyle{empty} means there is no header or
% footer for them to size, and without geometry's includehead/includefoot they do not
% enter the text-block calculation either, so they were inert.
\geometry{
	paper=a4paper, % Paper size, change to letterpaper for US letter size
	top=1.75cm, % Top margin
	bottom=1.75cm, % Bottom margin
	left=2.4cm, % Left margin
	right=2.4cm, % Right margin
	%showframe, % Uncomment to show how the type block is set on the page
}

%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

% NOTE: inputenc/fontenc deliberately omitted -- both CI (Tectonic/XeTeX) and
% local builds (LuaTeX) are Unicode engines where they are no-ops, and raleway
% loads fontspec itself. Re-add them only if you switch back to pdfLaTeX.
\usepackage[default,lining]{raleway} % Raleway as the default font.
% 'lining' matters: raleway defaults to OLDSTYLE figures, which set dates in
% varying-height glyphs. (Its 'tabular' switch exists internally but is never
% registered as an option, so it cannot be passed.)

\usepackage{microtype} % Protrusion/expansion -- measurably better justified setting

% Suppress hyphenation. Broken words destroy keyword matching in ATS text
% extraction (e.g. 'signif-icantly', 'compo-nent', 'Juve-nil').
\hyphenpenalty=10000
\exhyphenpenalty=10000

% Ragged right is REQUIRED alongside the above, not a style preference. With
% hyphenation off, justified text in the narrow columns can only reach the right
% margin by stretching inter-word spaces enormously -- and a text extractor reads a
% wide enough gap as a COLUMN BOUNDARY, which scrambles the affected block into
% fragments. Ragged right is also the CV convention.
\raggedright

\usepackage{fontawesome5} % Required for FontAwesome icons

%----------------------------------------------------------------------------------------
%	COLOURS
%----------------------------------------------------------------------------------------

\usepackage{xcolor}

% Monochrome by design. Single knob: change cvaccent and every section header and
% icon chip follows it.
\definecolor{cvaccent}{HTML}{000000} % Black -- section headers, icons
\definecolor{cvink}{HTML}{1A1A1A}    % Near-black -- the name block

% The only grey. Used solely for the right-aligned employer/institution qualifier, so
% company names sit one step below job titles in the hierarchy without introducing a
% colour. #595959 is ~7:1 contrast on white -- readable, and still clearly dark through
% a photocopier or a greyscale print. Set to 000000 for pure black.
\definecolor{cvmuted}{HTML}{595959}

%----------------------------------------------------------------------------------------
%	COMPONENTS
%----------------------------------------------------------------------------------------

% Command to vertically center adjacent content
\newcommand{\vcenteredhbox}[1]{% The only parameter is for the content to center
	\begingroup%
		\setbox0=\hbox{#1}\parbox{\wd0}{\box0}%
	\endgroup%
}

% Command to output an icon in a black square box with text to the right
\newcommand{\icon}[3]{% The first parameter is the FontAwesome icon name, the second is the box size and the third is the text
	\vcenteredhbox{\colorbox{cvaccent}{\makebox(#2, #2){\textcolor{white}{\large\csname fa#1\endcsname}}}}% Icon and box
	\hspace{0.2cm}% Whitespace
	\vcenteredhbox{\textcolor{black}{#3}}% Text
}

% Command to output section title headings
\newcommand{\cvsect}[1]{% The only parameter is the section text
	\vspace{\baselineskip} % Whitespace before the section title
	\colorbox{cvaccent}{\textcolor{white}{\MakeUppercase{\textbf{#1}}}}\\% Section title
}

% Command to output a separator slash between lists, e.g. '  /  '
\newcommand{\slashsep}{\hspace{3mm}/\hspace{3mm}}

%----------------------------------------------------------------------------------------
%	HEADER
%----------------------------------------------------------------------------------------

% Header is TWO columns, not three. The old three-column form interleaved the two
% contact columns row-wise under pdfminer extraction, and its 0.27\textwidth cells
% were too narrow to hold labelled values without overflowing.
%
% Contact rows carry text labels, not bare icons. The FontAwesome glyphs hold no text
% of their own, so what a parser sees depends on the build engine: under XeTeX
% (Tectonic, our CI) they extract as junk -- 'c end.works', '] alin-trandafir'. Labels
% make this engine-proof. Email needs no label (regex-detectable) and the profile URLs
% are domain-qualified, so they label themselves.
%
% #1 job title  #2 location  #3 label for the phone row
% Those three are the ONLY parts that differ between the two languages; the values
% themselves come from identity.tex, so a changed phone number or handle is edited
% once rather than once per language.
\newlength{\namewidth}

\newcommand{\cvheader}[3]{%
	% One box sized to the longer name, so both names share a width instead of forming
	% a ragged staircase of two independently-sized boxes.
	% NOTE: inside a minipage \textwidth is the MINIPAGE's width, which is why this
	% needs an explicit \namewidth rather than a fraction of \textwidth.
	\settowidth{\namewidth}{\HUGE\textbf{\MakeUppercase{\cvlastname}}}% Size to the LONGER name
	\begin{minipage}[t]{0.40\textwidth}% Left column: name and title
		\vspace{-\baselineskip}% Required for vertically aligning minipages

		\colorbox{cvink}{\parbox{\namewidth}{%
			\HUGE\textcolor{white}{\textbf{\MakeUppercase{\cvfirstname}}}\\[2pt]
			\HUGE\textcolor{white}{\textbf{\MakeUppercase{\cvlastname}}}}}

		\vspace{6pt}% Vertical whitespace

		{\huge #1\par}% Career or current job title
	\end{minipage}%
	\hfill% Automatic horizontal whitespace
	\begin{minipage}[t]{0.56\textwidth}% Right column: contact details, stacked
		\vspace{-\baselineskip}% Required for vertically aligning minipages

		\icon{MapMarker}{12}{#2}\\
		\icon{Phone}{12}{#3: \cvphone}\\
		\icon{At}{12}{\cvemail}\\
		\icon{Globe}{12}{Web: \cvweb}\\
		\icon{Github}{12}{\cvgithub}\\
		\icon{Linkedin}{12}{\cvlinkedin}
	\end{minipage}

	\vspace{0.5cm}% Vertical whitespace
}

%----------------------------------------------------------------------------------------
%	ENTRY LIST
%----------------------------------------------------------------------------------------

\usepackage{longtable} % Required for tables that span multiple pages
\setlength{\LTpre}{0pt} % Remove default whitespace before longtable
\setlength{\LTpost}{0pt} % Remove default whitespace after longtable

\setlength{\tabcolsep}{0pt} % No spacing between table columns

% Environment to hold a new list of entries
\newenvironment{entrylist}{
	\begin{longtable}[l]{l l}
}{
	\end{longtable}
}

% Width of the left-hand date column. Override per document with
% \setlength{\dateColWidth}{0.22\textwidth} before \begin{document}.
% 0.22 leaves ~9.6pt of gutter after the widest English range, 'Nov 2024 -- May 2026'
% (91.8pt). At 0.20 that range fitted with 0.37pt to spare -- technically no overflow,
% but no visible gutter either, so the date ran straight into the job title.
\newlength{\dateColWidth}
\setlength{\dateColWidth}{0.22\textwidth}

% Shared body for both entry types.
% #1 dates  #2 heading  #3 right-aligned qualifier  #4 description
% #5 break after the heading line  #6 break(s) ending the table row
% #7 separator between heading and qualifier
\newcommand{\cv@entry}[7]{%
	\parbox[t]{\dateColWidth}{% Widened from the original 0.175, which left under 4pt
		#1 % of slack for 'Oct 2022 -- Nov 2024' in Raleway lining figures.
	}%
	&\parbox[t]{\dimexpr\textwidth-\dateColWidth\relax}{%
		\textbf{#2}#7{\footnotesize \textbf{\textcolor{cvmuted}{#3}}}#5%
		#4 % Entry description text
	}#6%
}

% Multi-line entry (Experience). \hfill is safe here: the description below makes the
% row several lines tall, so PDF extractors keep the row together.
\newcommand{\entry}[4]{\cv@entry{#1}{#2}{#3}{#4}{\\}{\\\\}{\hfill}}

% Single-line entry (Education/Certifications). Uses a literal separator rather than
% \hfill: on a one-line row the wide \hfill gap reads as a COLUMN BOUNDARY to text
% extractors, which shreds the table -- dates, degrees and institutions come out as
% three detached blocks, with the institutions ejected past later sections entirely.
\newcommand{\shortentry}[4]{\cv@entry{#1}{#2}{#3}{#4}{\\[-2pt]}{\\[-4pt]}{ \textemdash\ }}

%----------------------------------------------------------------------------------------
%	HYPERLINKS -- must stay last
%----------------------------------------------------------------------------------------

\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links

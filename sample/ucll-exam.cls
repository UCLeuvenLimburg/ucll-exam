\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucll-exam}[2018/5/30]
\RequirePackage{etoolbox}

\DeclareOption{dutch}{\PassOptionsToPackage{dutch}{babel}}
\DeclareOption{english}{\PassOptionsToPackage{english}{babel}}

\ProcessOptions\relax
\LoadClass[twoside]{scrartcl}

\RequirePackage{babel}
\RequirePackage{amsmath}
\RequirePackage[paper=a4paper,headheight=1.0cm,top=2cm,bottom=1.5cm,left=2cm,right=2cm,includeheadfoot]{geometry}
\RequirePackage[headsepline]{scrpage2}
\RequirePackage{afterpage}
\RequirePackage{tabularx}
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{microtype}
\RequirePackage{lastpage}
\RequirePackage{tikz}
\RequirePackage{pxfonts}
\RequirePackage{framed}
\RequirePackage{comment}
\RequirePackage{marvosym}


\usetikzlibrary{calc,math,shapes.multipart}






%
% Page header and footer
%
\setheadsepline{0pt}

\newcommand{\ucllexam@header}{%
  \begin{tikzpicture}[every node/.style={font=\normalfont\small\scshape}]
    \node[inner sep=0mm,
          minimum height=2cm] (logo) at (0,0) {
      \includegraphics[width=4.14cm]{ucll-logo.png}
    };
    \node[anchor=south west,
          draw,
          minimum height=2cm,
          inner sep=1mm,
          rectangle split,
          rectangle split parts=2,
          rectangle split horizontal=true] (course information) at ($ (logo.south east) + (0.5,0) $) {
      \parbox{5mm}{
        \centering
        \rotatebox{90}{\bfseries \exam@string{Course}}
      }
      \nodepart{two}
      \parbox{11.5cm}{
        \begin{tabular}{rl}
          \exam@string{Name}: & \exam@opo \\[2mm]
          \exam@string{Code}: & \exam@opocode \\[2mm]
          \exam@string{Lecturers}: & \exam@examinator \\
        \end{tabular}
      }
    };
    \node[rectangle split,
          rectangle split parts=3,
          rectangle split horizontal=true,
          anchor=north west,
          draw] (exam information) at ($ (logo.south west) + (0,-0.2) $) {
      \parbox[c][1.5cm]{5mm}{
        \centering
        \rotatebox{90}{\bfseries \exam@string{Exam}}
      }
      \nodepart{two}
      \parbox{12.27cm}{
        \begin{tabular}{rl}
          \exam@string{Date}: & \exam@datum \\[1mm]
          \exam@string{Starting time}: & \exam@beginuur \\[1mm]
          \exam@string{Duration}: & \exam@duur \\[1mm]
          \exam@string{Aids}: & \exam@hulpmiddelen \\
        \end{tabular}
      }
      \nodepart{three}
      \parbox{3.5cm}{
        \raggedleft
        \Huge /20\hspace{2mm}
      }
    };
    \node[rectangle split,
          rectangle split parts=2,
          rectangle split horizontal=true,
          anchor=north west,
          draw,
          minimum height=2cm,
          minimum width=16.25cm] (student information) at ($ (exam information.south west) + (0,-0.2) $) {
      \parbox[c][2cm]{5mm}{
        \centering
        \rotatebox{90}{\bfseries \exam@string{Student}}
      }
      \nodepart{two}
      \parbox{16.04cm}{
        \centering
        \pgfkeys{/exam/pc flag/.get=\exam@pc}
        \begin{tabular}{rlrl}
          \exam@string{Name}: & \multicolumn{3}{l}{\parbox[b][8mm]{13cm}{\dotfill}} \\
          \ifnum\exam@pc=1
            \exam@string{First name}: & \parbox[b][8mm]{7cm}{\dotfill} & \exam@string{PC}: & \parbox[b][8mm]{4.25cm}{\dotfill} \\
          \else
            \exam@string{First name}: & \multicolumn{3}{l}{\parbox[b][8mm]{13cm}{\dotfill}} \\
          \fi
          \exam@string{Student id}: & \parbox[b][8mm]{7cm}{\dotfill} & \exam@string{Group}: & \parbox[b][8mm]{4.25cm}{\dotfill} \\
        \end{tabular}
      }
    };
  \end{tikzpicture}
}

\newcommand{\ucllexam@smallheader}{
  \small\normalfont\scshape
  \begin{tabular}{rlrl}
    Student: & \raisebox{-2pt}{\parbox{15cm}{\dotfill}} \\[1mm]
    OPO: & \exam@opocode -- \exam@opo & \\
 \end{tabular}\hspace*{\fill}%
}

\newcommand{\ucllexam@smallinfoheader}{
  \small\normalfont\scshape \exam@opocode -- \exam@opo \hspace*{\fill}
}

\newpagestyle{exampage}{%
  {\ucllexam@smallinfoheader}%
  {\ucllexam@smallheader}%
  {\ucllexam@smallheader}
  (\textwidth,1pt)%
}{%
  (\textwidth,1pt)%
  {\normalfont\scshape Pagina \thepage\ van \pageref{LastPage} \hspace{\fill} \exam@datum, \exam@beginuur}%
  {\normalfont\scshape\rlap{\exam@datum, \exam@beginuur} \hspace{\fill} Pagina \thepage\ van \pageref{LastPage}}%
  {\normalfont\scshape\rlap{\exam@datum, \exam@beginuur} \hspace{\fill} Pagina \thepage\ van \pageref{LastPage}}%
}

\newpagestyle{firstexampage}{%
  {\ucllexam@header}%
  {\ucllexam@header}%
  {\ucllexam@header}
}{%
  (\textwidth,1pt)%
  {\normalfont\scshape\rlap{\exam@datum, \exam@beginuur} \hspace{\fill} Pagina \thepage\ van \pageref{LastPage}}%
  {\normalfont\scshape\rlap{\exam@datum, \exam@beginuur} \hspace{\fill} Pagina \thepage\ van \pageref{LastPage}}%
  {\normalfont\scshape\rlap{\exam@datum, \exam@beginuur} \hspace{\fill} Pagina \thepage\ van \pageref{LastPage}}%
}

\pagestyle{exampage}

\AtBeginDocument{
  \thispagestyle{firstexampage}
}


%
% Exam information
%
\pgfkeys{
  /exam/.cd,
  academiejaar/.store in=\exam@academiejaar,
  opleiding/.store in=\exam@opleiding,
  fase/.store in=\exam@fase,
  examinator/.store in=\exam@examinator,
  opo/.store in=\exam@opo,
  opo code/.store in=\exam@opocode,
  ola/.store in=\exam@ola,
  ola code/.store in=\exam@olacode,
  activiteit/.store in=\exam@activiteit,
  hulpmiddelen/.store in=\exam@hulpmiddelen,
  datum/.store in=\exam@datum,
  beginuur/.store in=\exam@beginuur,
  duur/.store in=\exam@duur,
  pc flag/.initial=0,
  pc/.style={pc flag=1},
  ti/.style={
    opleiding={Bachelor in de Toegepaste Informatica}
  },
  scripting/.style={
    ti,
    fase={1},
    opo={Scripttalen},
    opo code={MBI59A},
    ola={Scripttalen},
    ola code={MBI59a},
  },
  pvm/.style={
    ti,
    fase={2},
    opo={Programmeren voor Multimedia},
    opo code={MBI66A},
    ola={Programmeren voor Multimedia},
    ola code={MBI66a},
  },
  probleemoplossend denken/.style={
    ti,
    fase={1},
    opo={Probleemoplossend Denken},
    opo code={MBI71A},
    ola={Probleemoplossend Denken},
    ola code={MBI71a},
  },
  algoritmisch denken/.style={
    ti,
    fase={1},
    opo={Algoritmisch Denken},
    opo code={MBI04A},
    ola={Algoritmisch Denken},
    ola code={MBI59a},
  },
}

\newcommand{\exam}[1]{\pgfkeys{/exam/.cd,#1}}


% Strings
\newcommand{\define@string}[3]{
  \pgfkeyssetvalue{/exam/strings/dutch/#1}{#2}
  \pgfkeyssetvalue{/exam/strings/english/#1}{#3}
}

\define@string{Exam}{Examen}{Exam}
\define@string{Student}{Student}{Student}
\define@string{Date}{Datum}{Date}
\define@string{Starting time}{Beginuur}{Starting time}
\define@string{Duration}{Duur}{Duration}
\define@string{Aids}{Hulpmiddelen}{Allowed aids}
\define@string{Name}{Naam}{Name}
\define@string{First name}{Voornaam}{First name}
\define@string{Student id}{R-nummer}{Student Id}
\define@string{PC}{PC}{PC}
\define@string{Group}{Reeks}{Group}
\define@string{Code}{Code}{Code}
\define@string{Lecturers}{Lectoren}{Lecturers}
\define@string{Course}{OPO}{Course}



\newcommand{\exam@string}[1]{\pgfkeysvalueof{/exam/strings/\languagename/#1}}



\AtBeginDocument{
  \ifundef\exam@academiejaar{
    \PackageError{ucll-exam}{Exam information: missing value academiejaar}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@opleiding{
    \PackageError{ucll-exam}{Exam information: missing value opleiding}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@fase{
    \PackageError{ucll-exam}{Exam information: missing value fase}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@examinator{
    \PackageError{ucll-exam}{Exam information: missing value examinator}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@opo{
    \PackageError{ucll-exam}{Exam information: missing value opo}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@opocode{
    \PackageError{ucll-exam}{Exam information: missing value opo code}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@ola{
    \PackageError{ucll-exam}{Exam information: missing value ola}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@olacode{
    \PackageError{ucll-exam}{Exam information: missing value ola code}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@activiteit{
    \PackageError{ucll-exam}{Exam information: missing value activiteit}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@hulpmiddelen{
    \PackageError{ucll-exam}{Exam information: missing value hulpmiddelen}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@datum{
    \PackageError{ucll-exam}{Exam information: missing value datum}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@beginuur{
    \PackageError{ucll-exam}{Exam information: missing value beginuur}{Use the exam command to set all exam parameters}
  }{}
  \ifundef\exam@duur{
    \PackageError{ucll-exam}{Exam information: missing value duur}{Use the exam command to set all exam parameters}
  }{}
}


%
% Guidelines
%
\newenvironment{examguidelines}{
\newgeometry{includeheadfoot,headheight=8cm,top=2cm,bottom=1.5cm,left=2cm,right=2cm}
\vspace*{\fill}
\begin{center}
  \begin{minipage}{.95\linewidth}
    \begin{framed}
      \centering
      \begin{minipage}{.9\linewidth}}{
      \end{minipage}
    \end{framed}
  \end{minipage}
\end{center}
\vspace*{\fill}\vspace*{\fill}
\aftergroup\restoregeometry\clearpage
}

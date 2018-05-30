# Usage

Copy the files

* src/ucll-exam.cls
* src/ucll-logo.png

to the same directory as the one containing your main .tex file.


# Example

See `sample` directory for full sample.


```
\documentclass[dutch]{ucll-exam}

\exam{
  academiejaar=2016--2017,
  examinator={F.~Sanen,~F.~Vogels},
  datum={3 juni 2017},
  beginuur={8.30},
  hulpmiddelen={Open boek},
  activiteit={Examen},
  duur={150 minuten},
  scripting, % Add courses in ucll-exam.cls
  pc % Indicates students are allowed to use pc
}


\begin{document}

\begin{examguidelines}
   ...
\end{examguidelines}

\end{document}
```

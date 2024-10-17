/* SALES AMOUNTS */
(
(CASE WHEN {account} = 'GLSALES1' THEN {amount} ELSE 0 END) + 
(CASE WHEN {account} = 'GSALES2' THEN {amount} ELSE 0 END) +
(CASE WHEN {account} = 'GLSALES3' THEN {amount} ELSE 0 END) +
(CASE WHEN {account} = 'GLSALES4' THEN {amount} ELSE 0 END)
)

 
/* COSTS OF SALES */
(
(CASE WHEN {account} = 'GLCOGS1' THEN {amount} ELSE 0 END) +
(CASE WHEN {account} = 'GLCOGS2' THEN {amount} ELSE 0 END)
)

/* GM CALC */


1 - (
  (
    (CASE WHEN {account} = 'GLCOGS01' THEN {amount} ELSE 0 END) +
    (CASE WHEN {account} = 'GLCOGS02' THEN {amount} ELSE 0 END)
  ) 
  / 
(NULLIF(
    (CASE WHEN {account} = 'GLSALES01' THEN {amount} ELSE 0 END) + 
    (CASE WHEN {account} = 'GLSALES02' THEN {amount} ELSE 0 END) +
    (CASE WHEN {account} = 'GLSALES03' THEN {amount} ELSE 0 END) +
    (CASE WHEN {account} = 'GLSALES04' THEN {amount} ELSE 0 END),
    0
  ))
)

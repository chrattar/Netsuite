/* SALES AMOUNTS */
(
(CASE WHEN {account} = 'GL1' THEN {amount} ELSE 0 END) + 
(CASE WHEN {account} = 'GL2' THEN {amount} ELSE 0 END) +
(CASE WHEN {account} = 'GL3' THEN {amount} ELSE 0 END) +
(CASE WHEN {account} = 'GL4' THEN {amount} ELSE 0 END)
)

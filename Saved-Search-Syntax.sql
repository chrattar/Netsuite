'<div style ="background-color: '||CASE WHEN((CASE WHEN {quantity} != 0 THEN {amount} / {quantity} ELSE 0 END) - TO_NUMBER({item.custitem_p_price_take_03}) < 0) 
THEN '#FE9999' ELSE 'None' END||';'||{amount}||'</div>'


/* #1. RETURN A TEXT FIELD */
CASE 
    WHEN {type} = 'Invoice' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}      
    WHEN {type} = 'Sales Order' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}
ELSE NULL  END

CASE
    WHEN {type} = 'Bill' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}      
    WHEN {type} = 'Sales Order' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}
ELSE NULL  END

CASE
    WHEN {type} = 'Purchase Order' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}      
    WHEN {type} = 'Sales Order' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}
ELSE NULL  END

/* #2. RETURN AN AMOUNT */
CASE
    WHEN {type} = 'Bill' AND {custbody_fieldname} IS NOT NULL THEN {amount}      
    WHEN {type} = 'Sales Order' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}

ELSE NULL  END

CASE WHEN(
(CASE
    WHEN {type} = 'Bill' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname}) 
    =    
    (CASE WHEN {type} = 'Sales Order' AND {custbody_fieldname} IS NOT NULL THEN {custbody_fieldname})
) THEN {amount}
ELSE NULL  END


/* DECODE STRING */

decode({type},'Sales Order', {status})
decode({type},'Sales Order',{applyingtransaction.trandate})
decode({type},'Sales Order',({custbody_p_job_name}))
decode({type},'Sales Order',{applyingtransaction.quantityuom})
decode({type},'Sales Order',{fulfillingtransaction.quantityuom})
decode({type},'Sales Order',({amount}))
decode({type},'Sales Order',{applyingtransaction.amount})
decode({type},'Sales Order',{fulfillingtransaction.cogsamount})
decode({type},'Sales Order',{applyingtransaction.amount})-decode({type},'Sales Order',{fulfillingtransaction.cogsamount},0)
(decode({type},'Sales Order',{applyingtransaction.rate}))-((decode({type},'Sales Order',{fulfillingtransaction.cogsamount},0))/{fulfillingtransaction.quantity})
decode({type},'Sales Order',({applyingtransaction.amount}/{applyingtransaction.quantity}))
decode({type},'Item Receipt',{trandate})


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

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

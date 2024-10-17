/*NETSUITE SAVED SEARCH TEMPLATES*/

/* Ratio Between Two Values, Percent Change */ /*FPERCENT | SUM | */
/*Field Data: Type = string, status = string, custbody = INT*/
NVL(
    SUM(CASE 
            WHEN {type} = 'Quote' AND {status} = 'Processed' 
            THEN {custbody_project_size_squares} 
            ELSE 0 
        END) 
    / 
    NULLIF(SUM(CASE                 WHEN {type} = 'Quote' AND ({status} = 'Processed' OR {status} = 'Expired') 
                THEN {custbody_project_size_squares} 
                ELSE 0 
            END),0),0)

/* Ratio Between Two Values, Percent Change */ /*FPERCENT | SUM | */
/*Field Data: Type = string, status = string, custbody = INT*/
NVL(
    SUM(
        CASE 
            WHEN {type} = 'Quote' AND {status} = 'Processed' 
            THEN 1
            ELSE 0 
        END
    ) 
    / 
    NULLIF(
        SUM(
            CASE 
                WHEN {type} = 'Quote' AND ({status} = 'Processed' OR {status} = 'Expired') 
                THEN 1
                ELSE 0 
            END
        ), 
        0
    ),
    0
)



======================================
/* ({trandate}) is between January 1st of the current year and today's date (SYSDATE). 
If true, it takes the transaction amount ({amount}); otherwise, it returns 0.*/
/*FNUMERIC | SUM | */
CASE WHEN {trandate} 
BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') 
AND SYSDATE 
THEN {amount} 
ELSE 0 END
/*({trandate}) is between January 1st of the current year and today's date (SYSDATE) in previous year*/
CASE WHEN {trandate} 
BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) 
AND ADD_MONTHS(SYSDATE, -12) 
THEN {amount} 
ELSE 0 END

/* Change Percentage of the above two YTD for this year vs last year to durrent date */

(
    (SUM(CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') AND SYSDATE THEN {amount} ELSE 0 END) - 
    SUM(CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(SYSDATE, -12) THEN {amount} ELSE 0 END))
) 
/ 
NULLIF(SUM(CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') AND SYSDATE THEN {amount} ELSE 0 END), 0)

=======================================
Monthly Comparisons
/* January Current Year*/
CASE WHEN {trandate} 
BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') 
AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31', 'YYYY-MM-DD') 
THEN {amount} 
ELSE 0 END

/* January Last Year */
CASE WHEN {trandate} 
BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) 
AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31', 'YYYY-MM-DD'), -12) 
THEN {amount} 
ELSE 0 END

=======================================
/* Current Month, Current Year, Sum Invoiced Sales */ /*FNUMERIC | SUM | */

CASE WHEN {trandate} 
BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD') 
AND LAST_DAY(SYSDATE) 
THEN {amount} 
ELSE 0 END

/* Current Month, Last Year, Sum Invoiced Sales */ /*FNUMERIC | SUM | */
CASE WHEN {trandate} 
BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD'), -12) 
AND LAST_DAY(ADD_MONTHS(SYSDATE, -12)) 
THEN {amount} 
ELSE 0 END

=========================================
Monthly Comparisons
/* January Current Year*/
CASE WHEN {trandate} 
BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') 
AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD') 
THEN {amount} 
ELSE 0 END

/* January Last Year */
CASE WHEN {trandate} 
BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) 
AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD'), -12) 
THEN {amount} 
ELSE 0 END

/* MONTHS Current Year*/
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
--------
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-02-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-02-28', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-03-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-03-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-04-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-04-30', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-05-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-05-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-06-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-06-30', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-07-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-07-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-08-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-08-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-09-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-09-30', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-10-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-10-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-11-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-11-30', 'YYYY-MM-DD') THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-01', 'YYYY-MM-DD') AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31', 'YYYY-MM-DD') THEN {amount} ELSE 0 END


/* MONTHS Last Year*/
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-02-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-02-28', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-03-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-03-30', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-04-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-04-30', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-05-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-05-31', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-06-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-06-30', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-07-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-07-31', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-08-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-08-31', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-09-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-09-30', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-10-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-10-31', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-11-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-11-30', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END
CASE WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-01', 'YYYY-MM-DD'), -12) AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31', 'YYYY-MM-DD'), -12) THEN {amount} ELSE 0 END


/* CHANGE MONTH OVER MONTH PERCENTAGE */
(
    (
        SUM(
            CASE 
                WHEN {trandate} BETWEEN TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') 
                AND TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD') 
                THEN {amount} 
                ELSE 0 
            END
        ) 
        - 
        SUM(
            CASE 
                WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) 
                AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD'), -12) 
                THEN {amount} 
                ELSE 0 
            END
        )
    ) 
    / 
    NULLIF(
        SUM(
            CASE 
                WHEN {trandate} BETWEEN ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01', 'YYYY-MM-DD'), -12) 
                AND ADD_MONTHS(TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-31', 'YYYY-MM-DD'), -12) 
                THEN {amount} 
                ELSE 0 
            END
        ), 
        0
    )
)

'<div style ="background-color: '||CASE WHEN((CASE WHEN {quantity} != 0 THEN {amount} / {quantity} ELSE 0 END) - TO_NUMBER({item.custitem_p_price_take_03}) < 0) 
THEN '#FE9999' ELSE 'None' END||';'||{amount}||'</div>'



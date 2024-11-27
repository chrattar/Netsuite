/**
 * @NApiVersion 2.x
 * @NScriptType ClientScript
 */
define(['N/search', 'N/currentRecord'], function(search, currentRecord) {
    
    function pageInit(context) {
        var record = context.currentRecord;
        
        // Ensure we are only updating stock in create or edit mode CONTEXT MODE VIEW 
        // VIEW CHANGEES WHEN IT IS AVAILABLE
        if (context.mode !== 'view') {
            var lineCount = record.getLineCount({ sublistId: 'item' });

            for (var i = 0; i < lineCount; i++) {
                record.selectLine({ 
                    sublistId: 'item',
                    line: i
                });

                var itemId = record.getCurrentSublistValue({
                    sublistId: 'item',
                    fieldId: 'item'
                });

                var locationId = record.getValue({
                    fieldId: 'location'
                });

                if (itemId && locationId) {
                    // Ssearch to get the stock for specific location
                    var availableInLocation = 0;
                    var itemSearch = search.create({
                        type: 'inventoryitem',  // Use 'inventoryitem' or the appropriate item type
                        filters: [
                            ['internalid', 'is', itemId],
                            'AND',
                            ['inventorylocation', 'anyof', locationId]
                        ],
                        columns: ['locationquantityavailable']
                    });

                    var resultSet = itemSearch.run().getRange({ start: 0, end: 1 });

                    if (resultSet.length > 0) {
                        availableInLocation = parseInt(resultSet[0].getValue('locationquantityavailable'), 10);
                    }

                    // Set the available stock value in the custom field for the selected line
                    //Created due to NS not pulling the correct value so I made my own
                    //
                    record.setCurrentSublistValue({
                        sublistId: 'item',
                        fieldId: 'custcol_stock_from_selected_location', /// Custom Tranaction Line Field Type = Decimal
                        // Applies to = 'Sales Item', 'Item Fulfillment'
                        value: availableInLocation
                    });

                    // Commit the changes for this line
                    record.commitLine({
                        sublistId: 'item'
                    });
                }
            }

            console.log("Stock Reloaded for all lines on page.");
        }
    }

    return {
        pageInit: pageInit
    };
});


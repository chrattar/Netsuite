/**
 * @NApiVersion 2.x
 * @NScriptType ClientScript
 */
define(['N/search', 'N/currentRecord'], function(search, currentRecord) {
    function fieldChanged(context) {
        var record = context.currentRecord;
        var sublistName = context.sublistId;
        var fieldName = context.fieldId;

        console.log("Field Changed Triggered", "sublistName: " + sublistName + ", fieldName: " + fieldName);

        if (sublistName === 'item' && fieldName === 'item') {
            var itemId = record.getCurrentSublistValue({
                sublistId: 'item',
                fieldId: 'item'
            });

            var locationId = record.getValue({
                fieldId: 'location'
            });

            console.log("Item and Location IDs", "itemId: " + itemId + ", locationId: " + locationId);

            if (itemId && locationId) {
                // Perform a search to get the stock for the specific location
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
                    console.log("Available Stock for Location: ", availableInLocation);
                }

                // Set the available stock value to the custom field
                record.setCurrentSublistValue({
                    sublistId: 'item',
                    fieldId: 'custcol_p_shipment_loc_avail',
                    value: availableInLocation
                });

                console.log("Final Available Stock Set", availableInLocation);
            }
        }
    }

    return {
        fieldChanged: fieldChanged
    };
});

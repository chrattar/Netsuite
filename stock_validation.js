/**
 * @NApiVersion 2.x
 * @NScriptType UserEventScript
 */

define(['N/record', 'N/search', 'N/error', 'N/log'],
    function(record, search, error, log) {

        function beforeSubmit(context) {
            var newRecord = context.newRecord;
            var itemCount = newRecord.getLineCount({ sublistId: 'item' });
            // Optional: If location is set at the header level, uncomment the following line
            var headerLocation = newRecord.getValue({ fieldId: 'location' });


            for (var i = 0; i < itemCount; i++) {
                var itemId = newRecord.getSublistValue({
                    sublistId: 'item',
                    fieldId: 'item',
                    line: i
                });
                var quantity = newRecord.getSublistValue({
                    sublistId: 'item',
                    fieldId: 'originalquantity',
                    line: i
            });

             // If location is set at the line level
                   // var lineLocation = newRecord.getSublistValue({
                    //sublistId: 'item',
                    //fieldId: 'location',
                    //line: i});

                // Check inventory levels
                var itemLookup = newRecord.getSublistValue({
                    type: search.Type.INVENTORY_ITEM,
                    sublistId: 'item',
                    columns: ['onhand']
                
                });

                var quantityOnHand = itemLookup.locationquantityonhand;

                // If trying to fulfill more items than on hand, throw an error
                if (quantity > quantityOnHand) {
                    var myCustomError = error.create({
                        name: 'INSUFFICIENT_INVENTORY',
                        message: 'BAM!! Cannot fulfill item "' + itemId + '" as the quantity on hand is insufficient.',
                        notifyOff: false
                    });

                    log.error('Error: ' + myCustomError.name, myCustomError.message);
                    throw myCustomError;
                }
            }
        }

        return {
            beforeSubmit: beforeSubmit
        };
    });

/** Add addtional notes regarding multiple item issues **/

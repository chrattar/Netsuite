/**
 * @NApiVersion 2.1
 * @NScriptType ScheduledScript
 * @NModuleScope SameAccount
 */

define(["N/record"],
    function(record) {

        function execute(context) {
            var rec = record.create({
                type: 'salesorder',
                isDynamic: true
            });

            rec.setValue({
                fieldId:'customform', // Corrected fieldId spelling
                value:148   
            })

            rec.setValue({
                fieldId:'entity', // Corrected fieldId spelling
                value:949
            })

            rec.setValue({
                fieldId:'memo', // Corrected fieldId spelling
                value:"UI TEST"
            })

            rec.setValue({
                fieldId: 'startdate',
                value: new Date(2024, 4, 29) // Year, Month (0-indexed), Day
            });

            rec.setValue({
                fieldId:'otherrefnum', // Corrected fieldId spelling
                value:"TEST_SO_CREATE"
            })

            rec.setValue({
                fieldId:'location', // Corrected fieldId spelling
                value:2
            })


            rec.selectLine({
                sublistId:'item', // Corrected sublistId spelling
                line: 0 // Assuming it's the first line, adjust accordingly if needed
            });

            rec.setCurrentSublistValue({
                sublistId:'item', // Corrected sublistId spelling
                fieldId:'item',
                value: 9409
            })

            rec.setCurrentSublistValue({
                sublistId:'item', // Corrected sublistId spelling
                fieldId:'quantity',
                value: 100
            })

            rec.commitLine({
                sublistId:'item', // Corrected sublistId spelling
            });

            var internalID = rec.save();

            log.debug({
                title:"IT WORKS",
                details:"Sales Order ID: " + internalID,
            })
        }
        return {
            execute: execute
        };
    });

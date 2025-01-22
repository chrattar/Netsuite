/**
 * @NApiVersion 2.x
 * @NScriptType Suitelet
 */
define(['N/search', 'N/log'], function (search, log) {
    function onRequest(context) {
        try {
            const filters = [
                [
                    ['type', 'anyof', 'ItemShip'], // First condition: ItemShip
                    'OR',
                    ['type', 'anyof', 'Invoice']  // Second condition: Invoice
                ],
                'AND',
                ['mainline', 'is', 'F'], // Only line-level records (mainline = false)
                'AND',
                ['trandate', 'within', 'thisfiscalyear'], // Transactions within the current fiscal year
                'AND',
                ['entity', 'isnot', '@NONE@'] // Entity must not be empty or null
            ];

            const columns = [
                search.createColumn({ name: 'internalid' }),
                search.createColumn({ name: 'tranid' }),
                search.createColumn({ name: 'amount' }),
                search.createColumn({ name: 'custbody_acs_fld_invoice_created' }),
                search.createColumn({ name: 'location' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'salesrep' }),
                search.createColumn({ name: 'createdfrom' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),
                search.createColumn({ name: 'cogsamount' }),

                search.createColumn({ name: 'trandate' })
            ];

            const results = getSearchResults('transaction', filters, columns);

            log.debug('Search Results', JSON.stringify(results));
            
            // Optionally, write the results as response
            if (context.response) {
                context.response.write(JSON.stringify(results, null, 2));
            }
        } catch (e) {
            log.error('Error in Suitelet', e.message);
        }
    }

    function getSearchResults(recordType, filters, columns) {
        const results = [];
        const searchObj = search.create({
            type: recordType,
            filters: filters,
            columns: columns
        });

        const pagedSearch = searchObj.runPaged({ pageSize: 1000 });

        pagedSearch.pageRanges.forEach(function (pageRange) {
            const page = pagedSearch.fetch({ index: pageRange.index });
            page.data.forEach(function (result) {
                results.push({
                    id: result.getValue({ name: 'internalid' }),
                    tranid: result.getValue({ name: 'tranid' }),
                    entity: result.getText({ name: 'entity' }),
                    amount: result.getValue({name: 'amount'}),
                    amount_cogs: result.getValue({name: 'cogsamount'}),
                    createdfrom: result.getText({name: 'createdfrom'}),
                    invoice_num_sh: result.getText({ name: 'custbody_acs_fld_invoice_created' }),
                    date: result.getValue({ name: 'trandate' })
                });
            });
        });

        return results;
    }

    return {
        onRequest: onRequest
    };
});

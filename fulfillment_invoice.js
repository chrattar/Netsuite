/**
 * @NApiVersion 2.x
 * @NScriptType Suitelet
 */
define(['N/search', 'N/log'], function (search, log) {
    function onRequest(context) {
        try {
            const filters = [
                ['type', 'anyof', 'ItemShip'], // Filter for Item Fulfillments
                'AND',
                ['mainline', 'is', 'T'], // Only mainline records
                'AND',
                ['trandate', 'within', 'thisfiscalyear'] // Current fiscal year
            ];

            const columns = [
                search.createColumn({ name: 'internalid' }),
                search.createColumn({ name: 'tranid' }),
                search.createColumn({ name: 'amount' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
                search.createColumn({ name: 'entity' }),
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

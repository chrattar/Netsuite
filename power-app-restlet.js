/**
 * @NApiVersion 2.x
 * @NScriptType Restlet
 */
define(['N/search', 'N/log'], function (search, log) {

    /**
     * Handles GET requests
     * @param {Object} requestParams - Parameters sent in the request
     * @returns {Object} - JSON response with customer data or error message
     */
    function doGet(requestParams) {
        try {
            // Define search filters and columns for customers
            const filters = [
                ['entitystatus', 'anyof', 'CUSTOMER'] // Filter for customer status
            ];

            const columns = [
                search.createColumn({ name: 'internalid' }),
                search.createColumn({ name: 'companyname' }),
                search.createColumn({ name: 'email' }),
                search.createColumn({ name: 'phone' }),
                search.createColumn({ name: 'status' })
            ];

            const results = getSearchResults('customer', filters, columns);

            return { success: true, data: results };
        } catch (e) {
            log.error('Error in RESTlet', e.message);
            return { success: false, error: e.message };
        }
    }

    /**
     * Helper function to fetch search results
     * @param {string} recordType - Record type (e.g., 'customer')
     * @param {Array} filters - Search filters
     * @param {Array} columns - Search columns
     * @returns {Array} - Array of search results
     */
    function getSearchResults(recordType, filters, columns) {
        const results = [];
        const searchObj = search.create({ type: recordType, filters, columns });

        const pagedSearch = searchObj.runPaged({ pageSize: 1000 });
        pagedSearch.pageRanges.forEach(function (pageRange) {
            const page = pagedSearch.fetch({ index: pageRange.index });
            page.data.forEach(function (result) {
                results.push({
                    id: result.getValue({ name: 'internalid' }),
                    name: result.getValue({ name: 'companyname' }),
                    email: result.getValue({ name: 'email' }),
                    phone: result.getValue({ name: 'phone' }),
                    status: result.getText({ name: 'status' })
                    /* add additional results in this block */
                });
            });
        });

        return results;
    }

    return {
        get: doGet
    };
});

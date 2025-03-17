# Netsuite

Working with Netsuite can be slightly more complex than other ERPs I have experienced. It requires a lot more manual configuration to get the most out of the service. The other problem is that it has a limited user base that posts solutions. There are only a few good sources of tutorial information on Youbtube. Much of the official documentation that you have access to offers simple explanations for turning on switches. But attempting to understand how different modules interact with others is often quite difficult and not properly documented.

For the new user, there is also some difficultly in navigating the differing reporting structures in the default state. The interface is clumsy. The official docs do not provide strong examples of the required syntax. It is usually very trivial.

My hope with this repository is to provide a place for other Netsuite users (especially new users or less technical users to find a quick and easy way to get results.

### SCRIPTS:

<ul>
<li>Location Available - SO (location-available-so.js): 
This allows you to pull the current available stock for the location that is identified in the header of the transaction. By default, Netsuite will only allow you to reutrn the TOTAL AVAILABLE STOCK for the Subsidiary, not the location specific value for the Transaction Sublist Items.</li>

</ul>

### SAVED SEARCH SYNTAX TEMPLATES:
<u>Mass Date Comparison Templates</u> (ns-ss-date-comparisons.sql): 
A range of templates for Netsuite Saved Searches relating to date functions. Each function is broken up in the .sql file with the comments for each block listed below for easy search.
<ul>
  <li>/* ({trandate}) is between January 1st of the current year and today's date (SYSDATE). */</li>
  <li>/*Similar to Above, but shifts back to the previous year</li>
  <li>/*Change Percentage of the above two YTD for this year vs last year to durrent date*/</li>
  <li>/* MONTHS Current Year*/</li>
  <li>/* Current Month, Current Year, Sum Invoiced Sales */</li>
  <li>/* Current Month, Last Year, Sum Invoiced Sales */</li>
  <li>/* MONTHS Current Year*/ AND /* MONTHS Last Year*/ (One row for every month of year.)</li>
  <li>/* CHANGE MONTH OVER MONTH PERCENTAGE */</li>
  <li>/*DATE BLOCKS*/(Massive Date Block Range to Sum {amount} (or whatever you want here}  by month individually.)</li>
</ul>

Assorted Saved Search Groups - (Saved-Search-Syntax.sql):
<ul>
  <li>Decode Strings of form decode({type},'Sales Order', {status}) or decode({type},'Sales Order',{applyingtransaction.trandate}) </li>
  <li></li></li>
</ul>

Assorted Ratio Templates - (ratios-bw-fields.sql):
<ul>
  <li>/* Ratio Between Two Values, Percent Change */ /*FPERCENT | SUM | */
  /*Field Data: Type = string, status = string, custbody = INT*/</li>
  <li>/* Ratio Between Two Values, Percent Change */ /*FPERCENT | SUM | */
  /*Field Data: Type = string, status = string, custbody = INT*/</li>
</ul>

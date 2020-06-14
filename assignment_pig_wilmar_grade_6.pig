ordersCSV = LOAD '/user/maria_dev/diplomacy/orders.csv'
			USING PigStorage(',');
            
removeQuotes = FOREACH ordersCSV GENERATE
				REPLACE($0, '\\"', '') AS (game_id:int),
				REPLACE($1, '\\"', '') AS (unit_id:int),
				REPLACE($2, '\\"', '') AS (unit_order:chararray),
				REPLACE($3, '\\"', '') AS (location:chararray),
				REPLACE($4, '\\"', '') AS (target:chararray),
				REPLACE($5, '\\"', '') AS (target_dest:chararray),
				REPLACE($6, '\\"', '') AS (success:int),
				REPLACE($7, '\\"', '') AS (reason:chararray),
				REPLACE($8, '\\"', '') AS (turn_num:int);

orderData = FOREACH removeQuotes GENERATE $3, $4;
filterForTargetHolland = FILTER orderData BY $1 == 'Holland';
groupByLocation = GROUP filterForTargetHolland BY ($0, $1);
countLocations = FOREACH groupByLocation GENERATE FLATTEN(group) as (location,target), COUNT($1);
sortedAlph = ORDER countLocations BY $0 ASC;

DUMP sortedAlph;
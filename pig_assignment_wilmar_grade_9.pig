REGISTER '/user/maria_dev/diplomacy/myudf.py' using jython as myudfs
playersCSV = LOAD '/user/maria_dev/diplomacy/players.csv'
			USING PigStorage(',');
            
removeQuotes = FOREACH playersCSV GENERATE
				REPLACE($0, '\\"', '') AS (game_id:int),
				REPLACE($1, '\\"', '') AS (country:chararray),
				REPLACE($2, '\\"', '') AS (won:chararray),
				REPLACE($3, '\\"', '') AS (num_supply_centers:int),
				REPLACE($4, '\\"', '') AS (eliminated:int),
				REPLACE($5, '\\"', '') AS (start_turn:int),
				REPLACE($6, '\\"', '') AS (end_turn:int);

orderData = FOREACH removeQuotes GENERATE $1, $2;
filterForGameWon = FILTER orderData BY $1 == '1';
groupByCountry = GROUP filterForGameWon BY $0;
countWins = FOREACH groupByCountry GENERATE FLATTEN(group) as country, COUNT($1);
countryNames = FOREACH countWins GENERATE myudfs.char_to_country($0);

DUMP countryNames;
def get_players

url= "http://data.nba.net/10s/prod/v1/2018/players.json"

player_database= RestClient.get(url)

player_hash= JSON.parse(player_database)

players_array= player_hash["league"]["standard"]

return players_array

end

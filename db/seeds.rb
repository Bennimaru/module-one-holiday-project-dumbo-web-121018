User.destroy_all
Team.destroy_all
Player.destroy_all

# ben= User.create(name:"Ben")
# vincent= User.create(name:"Vincent")
#
# lebron= Player.create(name:"Lebron James",team:"LAL",position:"SF",points:30)
# durant= Player.create(name:"Kevin Durant",team:"GSW",position:"SF",points:32)
# harden= Player.create(name:"James Harden",team:"HOU",position:"PG",points:40)
# doncic= Player.create(name:"Luka Doncic",team:"DAL",position:"SF",points:21)
# unicorn= Player.create(name:"Kristaps Porzingis",team:"NYK",position:"PF",points:0)
# curry= Player.create(name:"Stephen Curry",team:"GSW",position:"PG",points:25)
#
# team1= Team.create(name:"Ben's Team",user_id: 1)
# team2= Team.create(name:"Ben's Team",user_id: 1)
# team3= Team.create(name:"Vincent's Team",user_id: 2)
# team4= Team.create(name:"Vincent's Team",user_id: 2)

def create_players

  get_players.map do|player|
    Player.create(first_name: player["firstName"],last_name: player["lastName"],team: player["teamId"], position: player["pos"])
  end

end

create_players

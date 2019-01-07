class CommandLineInterface

$prompt= TTY::Prompt.new(active_color: :bright_green)
attr_accessor :user,:team,:player

  def greet
    system "clear"
    puts ("Welcome to BUCKETS")
    @welcome_screen=[
      {"New User" => ->do user_create end},
      {"Log In" => ->do login end},
      {"Exit" => ->do logout end}
    ]
    $prompt.select("",@welcome_screen)
  end

  def gets_user_input
    gets.chomp
  end

  def user_create
    system "clear"
    new_user= $prompt.ask("Hello, new user. Please enter your name:", required: true) do |q|
      q.modify :chomp
    end
    User.create(name: new_user)
    system "clear"
    puts ("Thank you. Please log in.")
    $prompt.select("",@welcome_screen)
  end

  def login
    system "clear"
    username= $prompt.ask('Enter name:', required: true) do |q|
      q.modify :chomp
    end

    @user= User.find_by(name: username)
    if @user == nil
      system "clear"
      $prompt.select("This user does not exist.") do |q|
      q.choice "Create A User"=> -> do user_create end
      q.choice "Exit" => -> do logout end
      end
    else
      user_screen
    end
  end

  def user_screen
    system "clear"
    @user_screen=[
      {"Make A Team" => ->do team_create end},
      {"View Teams" => ->do show_my_teams end},
      {"Add Players" => ->do add_players end},
      {"Delete A Team"=> ->do team_delete end},
      {"Exit" => ->do logout end}
    ]
    $prompt.select("Home Screen",@user_screen)
  end

  def team_create
    system "clear"
    team_name= $prompt.ask("Enter a Team Name:", required: true) do|q|
      q.modify :chomp
    end

    team= Team.find_by(name: team_name, user_id: @user.id)
    if team
      system "clear"
      $prompt.select("This team already exists for you.") do|q|
        q.choice "Create another team?"=> ->do team_create end
        q.choice "Back to Home"=> ->do user_screen end
      end
    else
      new_team= Team.create(name: team_name, user_id: @user.id)
    end
    return user_screen
  end

  def show_my_teams
    system "clear"
    tp @user.teams
    @exit =[
      {"Exit"=> ->do user_screen end}
    ]
    $prompt.select("Teams",@exit)
  end

  def add_players
    system "clear"
    player_name= $prompt.ask("Enter a player's last name:", required: true) do|q|
      q.modify  :chomp, :capitalize
    end
    system "clear"
    found_player= Player.where(last_name: player_name)
    if found_player
      tp found_player
    end
    options=[
      {"Find Player"=> -> do add_players end},
      {"Choose Player"=> ->do pick_player end},
      {"Exit"=> ->do user_screen end}
    ]
    $prompt.select("Player Screen",options)
  end

  def pick_player
    chosen_id= $prompt.ask("Enter player ID:",required: true)
    chosen_team= $prompt.ask("Which team to assign player?(By team id)",required: true)
    updated_team= Team.where(id: chosen_team).update(player_id: chosen_id)
    system "clear"
    tp updated_team
    $prompt.select("Updated Team",@exit)
  end

  def team_delete
    chosen_id= $prompt.ask("Enter team ID:")
    Team.find_by(id: chosen_id).delete
    $prompt.select("Updated Team",@exit)
  end

  def logout
    system "clear"
    puts "Goodbye, come back soon."
  end

end

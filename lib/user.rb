class User < ActiveRecord::Base
  has_many :teams
  has_many :players, through: :teams

  def my_teams
    self.teams
  end


end

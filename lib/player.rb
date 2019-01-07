class Player < ActiveRecord::Base
  has_many :teams
  has_many :users, through: :teams

  def full_name
    [first_name, last_name].join(" ")
  end

end

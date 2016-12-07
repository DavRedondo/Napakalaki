# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame

class Treasure
  def initialize(name, bonus, type)
    @name = name
    @bonus = bonus
    @type = type
  end
  
  attr_reader :name, :bonus, :type
  
  def to_s
    "Nombre: #{@name} Bonus: #{@bonus}, Tipo: #{@type}"
  end
end

end

# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame


require_relative 'prize'
require_relative 'bad_consequence'

class Monster
  def initialize(name, combatLevel, prize, rol)
    @name = name
    @combatLevel = combatLevel
    @premio = prize
    @rol = rol 
  end
  
  attr_accessor :name, :combatLevel, :premio, :rol
  
  
  
  def to_s
    #"Nombre: #{@name}\n"
    "Nombre: #{@name}\nNivel de combate:#{@combatLevel}\nPremio: #{@premio}\nRol:#{@rol}"

  end

  def getLevelsGained()
    return premio.level()
  end

  def getTreasuresGained()
    return premio.treasures
  end

end
end 

# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame

class Prize
  def initialize(treasure, level)
    @treasures = treasure
    @level = level
  end
  
  attr_accessor :treasures, :level
  
def to_s
  "\n    Tesoros ganados: #{@treasures}\n    Niveles ganados: #{@level}\n"
end
  
end
end


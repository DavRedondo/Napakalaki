# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame


require 'singleton'

class Dice
  include Singleton
  def initialize
  end
  
  def nextNumber()
    #numeroAleatorio = 0
    #numeroAleatorio.rand(1..6)
    #return numeroAleatorio
    return rand(1..6)
    
  end
  
end
end

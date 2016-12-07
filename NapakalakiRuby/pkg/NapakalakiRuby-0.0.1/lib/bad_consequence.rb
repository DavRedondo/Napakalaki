# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


module NapakalakiGame

require_relative 'treasure_kind'
require_relative 'player'

class BadConsequence
  
  @@MAXTREASURES=10;
  
  private_class_method :new
  def initialize(aText, someLevels, someVisibleTreasures, someHiddenTreasures,
    someSpecificVisibleTreasures, someSpecificHiddenTreasures, death)
    @text = aText
    @levels = someLevels
    @nVisibleTreasures = someVisibleTreasures
    @nHiddenTreasures = someHiddenTreasures
    @death = death 
    @specificVisibleTreasures = someSpecificVisibleTreasures
    @specificHiddenTreasures = someSpecificHiddenTreasures 
  end
  
  attr_accessor :text, :levels, :nVisibleTreasures, :nHiddenTreasures, :death, :specificVisibleTreasures, :specificHiddenTreasures
  
  def to_s
   "Texto: #{@text}\nNiveles perdidos: #{@levels}\n
    Tesoros perdidos visibles: #{@nVisibleTreasures}\n
    Tesoros perdidos ocultos: #{@nHiddenTreasures}\n 
    Death: #{@death}"
  end

  def BadConsequence.getMaxTreasures()
    return @@MAXTREASURES
  end

  def BadConsequence.newLevelNumberOfTreasures (aText, someLevels, someVisibleTreasures, someHiddenTreasures)
   new(aText, someLevels, someVisibleTreasures, someHiddenTreasures, Array.new, Array.new, false)
  end

  def BadConsequence.newLevelSpecificTreasures (aText, someLevels, someSpecificVisibleTreasures, someSpecificHiddenTreasures)
    new(aText, someLevels, 0, 0, someSpecificVisibleTreasures, someSpecificHiddenTreasures, false)
  end 

  def BadConsequence.newDeath (aText) 
    new(aText, Player.getMaxLevel(), @@MAXTREASURES, @@MAXTREASURES, Array.new, Array.new, true)
  end

  def isDeath()
    return @death
  end

  def getSpecificVisibleTreasures()
    return @specificVisibleTreasures;
  end

  def getSpecificHiddenTreasures()
    return @specificHiddenTreasures
  end

  def isEmpty?
    if @nVisibleTreasures == 0 and @nHiddenTreasures == 0 and
        @specificVisibleTreasures.empty? and @specificHiddenTreasures.empty?
      return true
    else 
      return false
    end

    end

  def substractVisibleTreasure(treasure) 
    @specificVisibleTreasures.delete(treasure)
  end

  def substractHiddenTreasure(treasure) 
    @specificHiddenTreasures.delete(treasure)
  end

  def adjustToFitTreasureLists(v, h)
 
    if @death
      return BadConsequence.newDeath(@text)
    end
    
    if @nVisibleTreasures > 0 or @nHiddenTreasures > 0
      nv = @nVisibleTreasures
      nh = @nHiddenTreasures
      
      if nv > v.size
        nv = v.size
      end
      if nh > h.size
        nh = h.size
      end
      
      return BadConsequence.newLevelNumberOfTreasures(@text, @levels, nv, nh)
      
    else 
      
      nuevovisible = Array.new 
      for tipo in @specificVisibleTreasures
        for tesoro in v
          if tesoro.type == tipo
            nuevovisible << new(tipo)
          end
        end
        break
      end
      
      nuevooculto = Array.new
      for tipo in @specificHiddenTreasures
        for tesoro in h
          if tesoro.type == tipo 
            nuevovisible << new(tipo)
          end
        end
        break
      end
      
      return BadConsequence.newLevelSpecificTreasures(@text, @levels, nuevovisible, nuevooculto)
      
    end
  end
  
end 

end
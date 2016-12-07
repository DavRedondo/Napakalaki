# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module NapakalakiGame


require 'singleton'
require_relative 'treasure'
require_relative 'monster'
require_relative 'treasure_kind'
require_relative 'combat_result'
require_relative 'dice'
require_relative 'card_dealer'
require_relative 'player'



class Napakalaki
  include Singleton
  def initialize
    @players = Array.new
    @currentPlayer
    @dealer = CardDealer.instance
    @currentMonster 
  end
  
  attr_accessor :players, :currentPlayer, :dealer, :currentMonster

  
  def initPlayers(names)
    for nombre in names
      
      @players << Player.new(nombre)
    end
  end
  
  def getCurrentPlayer()
    return @currentPlayer
  end
  
  def getCurrentMonster()
    return @currentMonster
  end
  
  def nextPlayer()
    numero = 0
    if @currentPlayer == nil 
      ngamers = @players.size
      numero = rand(0..ngamers)
    else
      begin 
        numero = (numero + 1) % @players.size
      end while(@players[numero] != @currentPlayer)
      # end while(@players.at(numero) != @currentPlayer)
    end
    numero = (numero + 1) % @players.size
    return @players[numero]
  end
  
  
  def nextTurnIsAllowed()
    if @currentPlayer == nil
      return true
    end
    return @currentPlayer.validState
  end
  
  
  def setEnemies()
    contador = 0
    dado = Dice.instance
    for jugador in @players
      begin 
        contador = dado.nextNumber() % self.players.size
      end while(@players.index(jugador) == contador)
      jugador.setEnemy(@players[contador])
    end
  end
  
  
  def developCombat()
    resultado = @currentPlayer.combat(@currentMonster)
    @dealer.giveMonsterBack(@currentMonster)
    return resultado
  end
  
  def discardVisibleTreasures(treasures)
    for tesoro in treasures
      @currentPlayer.discardVisibleTreasure(tesoro)
      @dealer.giveTreasureBack(tesoro)
    end
  end

  
  def discardHiddenTreasures(treasures)
    for tesoro in treasures
      @currentPlayer.discardHiddenTreasure(tesoro)
      @dealer.giveTreasureBack(tesoro)
    end
  end
  
  
  def makeTrasureVisible(treasures)
    for tesoro in treasures
      @currentPlayer.makeTreasureVisible(tesoro)
    end
  end
  
  
  def initGame(players)
    initPlayers(players)
    setEnemies()
    @dealer.initCards()
    nextTurn()
  end
  
  
  def nextTurn()
    stateOK = nextTurnIsAllowed()
    if stateOK
      @currentMonster = @dealer.nextMonster()
      @currentPlayer = nextPlayer()
      dead = @currentPlayer.isDead()
      if dead
        @currentPlayer.initTreasures()
      end
    end
    return stateOK
  end
  
  def self.endOfGame(result)
    return result == CombatResult::WINGAME
  end
  
=begin
#####    SINGLETON   #####

require 'singleton'

class Singleton
  include Singleton

  def initialize
      ## Poner todos los parámetros que queramos 
  end

end

=end
  
  
end

end
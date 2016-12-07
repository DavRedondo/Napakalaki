# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame

require_relative 'treasure'
require_relative 'monster'
require_relative 'treasure_kind'
require_relative 'combat_result'
require_relative 'dice'
require_relative 'bad_consequence'



class Player
  @@MAXLEVEL = 10
  def initialize(name)
    @name = name
    @level = 1
    @dead = true
    @canISteal = true 
    @hiddenTreasures = Array.new
    @visibleTreasures = Array.new
    @pendingBadConsequence = BadConsequence.newDeath("nada")


  end 
  
  #@pendingBadConsequence 
  @enemy
  #@pendingBadConsequence = BadConsequence.newDeath(nada)
  
  
    attr_accessor :level
    attr_reader :name, :hiddenTreasures, :visibleTreasures, :dead
    attr_writer :enemy, :pendingBadConsequence  
    
  def to_s
      "#{@name} Nivel #{@level}"
  end
  
  def self.getMaxLevel()
    return @@MAXLEVEL
  end
  
  
  def bringToLife()
    @dead=false;
  end
  
  
  def getCombatLevel() 
    levelfinal = @level
    for t in @visibleTreasures
      levelfinal += t.bonus
    end
    return levelfinal
  end
  
  def incrementsLevels(i)
    @level+=i
  end
  
  def decrementLevels(i)
    @level-=i
    if @level <= 0
      @level=1
    end
  end
  
  def setPendingBadConsequence(b)
    @pendingBadConsequence=b
  end
  
  def applyPrize(m)
    nLevels = m.getLevelsGained()
    self.incrementsLevels(nLevels)
    nTreasures = m.getTreasuresGained()
    
    if nTreasures > 0
      dealer = CardDealer.instance 
      for i in (0..nTreasures)
        treasure = dealer.nextTreasure()
        @hiddenTreasures << treasure
      end
    end
  end
  
  def applyBadConsequence(monster)
    badConsequence = monster.rol()
    nLevels = badConsequence.levels()
    decrementLevels(nLevels)
    pendingBad = badConsequence.adjustToFitTreasureLists(@visibleTreasures, @hiddenTreasures)
    setPendingBadConsequence(pendingBad)
  end
  
  
  def canMakeTreasureVisible(t)
    
    if t.type == [TreasureKind::ONEHAND]
      onehand = 0
      for tesoro in @visibleTreasures
        if tesoro.type == [TreasureKind::ONEHAND]
          onehand+=1
          
        end
        if tesoro.type == [TreasureKind::BOTHHANDS]
          return false
        end
        if onehand == 2
          return false
        end
      end
      
    else
      if t.type == [TreasureKind::BOTHHANDS]
        for tesoro in @visibleTreasures
          if tesoro.type == [TreasureKind::ONEHAND]
            return false
          end
        end
      end
    
    
      for tesoro in @visibleTreasures
        if tesoro.type == t.type
          return false
        end
      end
 
    end
    
    return true
    
  end
  
  def howManyVisibleTreasures(tKind)
    contador=0
    for t in @visibleTreasures
      if t.type == tkind
        contador+=1
      end
    end
    return contador
  end
  
  
  def dielfNoTreasures()
    if @hiddenTreasures and @visibleTreasures.empty?
      @dead=true
    end
  end
  
  def isDead()
    return @dead
  end
  
  def combat(m)
    myLevel = getCombatLevel()
    monsterLevel = m.combatLevel()
    
    if !@canISteal
      dice = Dice.instance
      number = dice.nextNumber()
      if number < 3
        enemyLevel = enemy.getCombatLevel()
        monsterLevel += enemyLevel 
      end
    end
    
    puts "Mi nivel ", @level
    puts "Mi nivel de combate ", @myLevel
    puts "Nivel monstruo ", @monsterLevel
    
    
      if myLevel > monsterLevel
        applyPrize(m)
        if @level >= @@MAXLEVEL
          return CombatResult::WINGAME
        else
          return CombatResult::WIN
        end
      else
        applyBadConsequence(m)
        return CombatResult::LOSE
      end
    end
    
  
  
  
  def makeTreasureVisible(treasure)
    canI = canMakeTreasureVisible(treasure)
    if canI
      @visibleTreasures << treasure
      @hiddenTreasures.delete(treasure)
    end
  end

  
  def discardVisibleTreasure(treasure)
    @visibleTreasures.delete(treasure)
    if @pendingBadConsequence != nil and !@pendingBadConsequence.isEmpty?
      @pendingBadConsequence.substractVisibleTreasure(treasure)
    end
    dielfNoTreasures()
  end
  
  
  def discardHiddenTreasure(treasure)
    hiddenTreasures.delete(treasure)
    if @pendingBadConsequence != nil and (!@pendingBadConsequence.isEmpty?)
      @pendingBadConsequence.substractHiddenTreasure(treasure)
    end
    dielfNoTreasures()
  end
  
  
  def validState
    r=false
    if @pendingBadConsequence.isEmpty? and hiddenTreasures.size() <= 4
      r=true
    end
    return r
  end
  
  def initTreasures
    dealer = CardDealer.instance
    dice = Dice.instance
    self.bringToLife()
    treasure = dealer.nextTreasure()
    @hiddenTreasures << treasure
    number = dice.nextNumber()
    
    if number > 1
      treasure = dealer.nextTreasure()
      @hiddenTreasures << treasure
    end
    
    if number == 6
      treasure = dealer.nextTreasure()
      @hiddenTreasures << treasure
    end
    
  end
  
  def getlevels()
    return @level
  end
  
  def stealTreasure()
    canI = self.canISteal() 
    if canI
      canYou = @enemy.canYouGiveMeATreasure()
      if canYou
        treasure = @enemy.giveMeATreasure()
        @hiddenTreasures << treasure
        self.haveStolen()
        return treasure
      end
    end
    return nil
  end
  
  def setEnemy(enemigo)
    @enemy=enemigo
  end
  
  
  def giveMeATreasure()
    numeroAleatorio.rand(0..@hiddenTreasures.size())
    aux = @hiddenTreasures[numeroAleatorio]
    @hiddenTreasures.delete_at(numeroAleatorio)
    return aux
  end
  
  
  def canISteal()
    return @canISteal
  end
  
  def canYouGiveMeATreasure()
    return !@hiddenTreasures.empty?
  end
  
  def haveStolen()
    @canISteal=false
  end
  
  def discardAllTreasures()
    copia = Array.new(@visibleTreasures)
    for tesoro in copia
      self.discardVisibleTreasure(tesoro)
    end
    
    copia = Array.new(@hiddenTreasures)
    for tesoro in copia
      self.discardHiddenTreasure(tesoro)
    end
    
  end
  
  
end
end

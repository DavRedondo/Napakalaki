# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
module NapakalakiGame

require 'singleton'
require 'napakalaki'

class CardDealer
  
  include Singleton
  
  def initialize
    @unusedMonsters = Array.new
    @usedMonsters = Array.new
    @unusedTreasures = Array.new
    @usedTreasures = Array.new
  end
  
  def initTreasureCardDeck()
    @usedTreasures = Array.new
    @unusedTreasures = [
           Treasure.new("Cuchillo de sushi arcano", 2, [TreasureKind::ONEHAND]),
           Treasure.new("Fez alópodo", 3, [TreasureKind::HELMET]),
           Treasure.new("Hacha prehistórica", 2, [TreasureKind::ONEHAND]),
           Treasure.new("El aparato del Pr. Tesla", 4, [TreasureKind::ARMOR]),
           Treasure.new("Gaita", 4, [TreasureKind::BOTHHANDS]),
           Treasure.new("Insecticida", 2, [TreasureKind::ONEHAND]),
           Treasure.new("Escopeta de 3 cañones", 4, [TreasureKind::BOTHHANDS]),
           Treasure.new("Garabato místico", 2, [TreasureKind::ONEHAND]),
           Treasure.new("La rebeca metálica", 2, [TreasureKind::ARMOR]),
           Treasure.new("Shogulador", 1, [TreasureKind::BOTHHANDS]),
           Treasure.new("Varita de atizamiento", 3, [TreasureKind::ONEHAND]),
           Treasure.new("Tentáculo de pega", 1, [TreasureKind::BOTHHANDS]),
           Treasure.new("Zapato deja-amigos", 1, [TreasureKind::SHOES]),
           Treasure.new("¡Sí mi amo!", 4, [TreasureKind::HELMET]),
           Treasure.new("Botas de investigación", 3, [TreasureKind::SHOES]),
           Treasure.new("Capucha de Cthulhu", 3, [TreasureKind::HELMET]),
           Treasure.new("A prueba de babas", 2, [TreasureKind::ARMOR]),
           Treasure.new("Botas de lluvia ácida", 1, [TreasureKind::SHOES]),
           Treasure.new("Casco minero", 2, [TreasureKind::HELMET]),
           Treasure.new("Ametralladora ACME", 4, [TreasureKind::BOTHHANDS]),
           Treasure.new("Camiseta de la ETSIIT", 1, [TreasureKind::ARMOR]),
           Treasure.new("Clavo de rail ferroviario", 3, [TreasureKind::ONEHAND]),
           Treasure.new("Lanzallamas", 4, [TreasureKind::BOTHHANDS]),
           Treasure.new("Necro-comicón", 1, [TreasureKind::ONEHAND]),
           Treasure.new("Necronomicón", 5, [TreasureKind::BOTHHANDS]),
           Treasure.new("Linterna a 2 manos", 3, [TreasureKind::BOTHHANDS]),
           Treasure.new("Necro-gnomicón", 2, [TreasureKind::ONEHAND]),
           Treasure.new("Necrotelecom", 2, [TreasureKind::HELMET]),
           Treasure.new("Mazo de los antiguos", 3, [TreasureKind::ONEHAND]),
           Treasure.new("Necro-playboycón", 3, [TreasureKind::ONEHAND]),
           Treasure.new("Porra preternatural", 2, [TreasureKind::ONEHAND])]
  end
  
  
  def initMonsterCardDeck() 
    @usedMonsters = Array.new

    # El rey de rosa
    prize = Prize.new(4,2)
    badconsequence = BadConsequence.newLevelNumberOfTreasures('Pierdes 5 niveles y
    3tesoros visibles',5 , 3, 0)
    @unusedMonsters << Monster.new('El rey de rosa', 13, prize, badconsequence)

    # Ángeles de la noche ibicenca
    prize = Prize.new(4,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures('Te
    atrapan para llevarte de fiesta y te dejan caer en mitad del vuelo. Descarta 1 
    mano visible y 1 mano oculta', 0,[TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
    @unusedMonsters<< Monster.new('Ángeles de la noche ibicenca', 14, prize, badconsequence)

    # 3 Byakhees de bonanza
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Pierdes tu armadura visible 
    y otra oculta", 0, [TreasureKind::ARMOR], [TreasureKind::ARMOR])
    @unusedMonsters << Monster.new("3 Byakhees de bonanza",8, prize, badconsequence)

    # Tenochtitlan
    prize = Prize.new(1,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Embobador con el lindo 
    primigenio te descartas de tu casco visible", 0, [TreasureKind::HELMET], Array.new)
    @unusedMonsters << Monster.new("Tenochtitlan", 2, prize, badconsequence)

    # El sopor de Dunwich
    prize = Prize.new(1,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("El primordial bostezo 
    contagioso. Pierdes el calzado visible", 0, [TreasureKind::SHOES], Array.new)
    @unusedMonsters << Monster.new("El sopor de Dunwich", 2, prize, badconsequence)

    # H.P. Munchcraft
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Pierdes la armadura
    visible", 0, [TreasureKind::ARMOR], Array.new)
    @unusedMonsters << Monster.new("H.P. Munchcraft", 6, prize, badconsequence)

    # El gorron en el umbral
    prize = Prize.new(3,1)
    badconsequence = BadConsequence.newLevelNumberOfTreasures("Pierdes todos tus 
    tesoros visibles", 0, 100, 0)
    @unusedMonsters << Monster.new("El gorron en el umbral", 13, prize, badconsequence)

    # Demonios de Magaluf
    prize = Prize.new(4,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Te atrapan para llevarte
      de fiesta y te dejan caer en mitad del vuelo. Descarta 1 mano visible y una mano
      oculta", 0, [TreasureKind::ONEHAND], [TreasureKind::ONEHAND])
    @unusedMonsters << Monster.new("Demonios de Magaluf", 2, prize, badconsequence)

    # Necrófago
    prize = Prize.new(1,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Sientes bichos balo la ropa.
      Descarta la armadura visible", 0, [TreasureKind::ARMOR], Array.new)
    @unusedMonsters << Monster.new("Necrofago", 13, prize, badconsequence)

    #El rey de rosado
    prize = Prize.new(3,2)
    badconsequence = BadConsequence.newLevelNumberOfTreasures("Pierdes 5 niveles y 
      3 tesoros visibles", 5, 3, 0)
    @unusedMonsters << Monster.new("El rey de rosado", 11, prize, badconsequence)

    # Flecher
    prize = Prize.new(1,1)
    badconsequence = BadConsequence.newLevelNumberOfTreasures("Toses los pulmones 
      y pierdes 2 niveles", 2, 0, 0)
    @unusedMonsters << Monster.new("Flecher", 2, prize, badconsequence)

    # Bicéfalo
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Te faltan manos 
      para tanta cabeza. Pierdes 3 niveles y tus tesoros visibles de las manos
      ", 3, [TreasureKind::BOTHHANDS, TreasureKind::ONEHAND], Array.new)
    @unusedMonsters<< Monster.new("Bicéfalo", 21, prize, badconsequence)

    # Roboggoth
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("La quinta directiva
      primaria te obliga a perder 2 niveles y un tesoro 2 manos visible", 2, [TreasureKind::BOTHHANDS],Array.new)
    @unusedMonsters<< Monster.new("Roboggoth",8,prize,badconsequence)

    # El espía sordo
    prize = Prize.new(1,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Te asusta en la 
      noche. Pierdes un casco visible", 0, [TreasureKind::HELMET], Array.new)
    @unusedMonsters<< Monster.new("El espía sordo", 5, prize, badconsequence)

    # Tongue
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelNumberOfTreasures("Menudo susto te 
      llevas. Pierdes 2 niveles y 5 tesoros visibles", 2, 5, 0)
    @unusedMonsters<< Monster.new("Tongue", 19, prize, badconsequence)

    # Pollipólipo volante
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelNumberOfTreasures("Da mucho asquito. 
      Pierdes 3 niveles.", 3, 0, 0)
    @unusedMonsters<< Monster.new("Pollipólipo volante", 3, prize, badconsequence)

    # YskhtihyssgGoth
    prize = Prize.new(3,1)
    badconsequence = BadConsequence.newDeath("No le hace gracia que pronuncien
      mal su nombre. Estás muerto.")
    @unusedMonsters<< Monster.new("YskhtihyssgGoth", 14, prize, badconsequence)

    # Familia feliz
    prize = Prize.new(3,1)
    badconsequence = BadConsequence.newDeath("La familia te atrapa. Estás muerto.")
    @unusedMonsters<< Monster.new("Familia feliz", 1, prize, badconsequence)

    # Los hondos
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newDeath("Estos monstruos resultan bastante 
      superficiales y te aburren mortalmente. Estás muerto.")
    @unusedMonsters<< Monster.new("Los hondos", 8, prize, badconsequence)

    # Semillas Cthulhu
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelNumberOfTreasures("Pierdes 2 niveles y
      2 tesoros ocultos", 2 , 0 , 2)
    @unusedMonsters<< Monster.new("Semillas Cthulhu", 4, prize, badconsequence)

    # Dameargo
    prize = Prize.new(2,1)
    badconsequence = BadConsequence.newLevelSpecificTreasures("Te intentas 
    escaquear. Pierdes una mano visible", 0, [TreasureKind::ONEHAND], Array.new)
    @unusedMonsters<< Monster.new("Dameargo", 1, prize, badconsequence)


  end  

  def shuffleMonsters() 
    @unusedMonsters.shuffle!
  end

  def shuffleTreasures() 
    @unusedTreasures.shuffle!
  end


  def nextTreasure()
    if @unusedTreasures.empty?
      @unusedTreasures = @usedTreasures
      shuffleTreasures()
      @usedTreasures = Array.new 
    end
    salida = @unusedTreasures.at(0)
    @unusedTreasures.delete(0)
    return salida
  end

  def nextMonster()
    if @unusedMonsters.empty?
      @unusedMonsters = @usedMonsters
      shuffleMonsters()
      @usedMonsters = Array.new 
    end
    salida = @unusedMonsters.at(0)
    @unusedMonsters.delete(0)
    return salida
  end

  def giveTreasureBack(treasure)
    @usedTreasures << treasure
  end

  def giveMonsterBack(monster)
    @usedMonsters << monster
  end

  def initCards()
    self.initTreasureCardDeck()
    self.initMonsterCardDeck()
  end

end
end

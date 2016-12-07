/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package NapakalakiGame;

/**
 *
 * @author Redondo
 */

//import java.util.Random;

public class Dice {
    
    private static Dice instance = null;

    public Dice() {
    }

    public static Dice getInstance() {
        if( instance == null) {
            instance = new Dice();
        }
        return instance;
    }

// Genera un número aleatorio entre 1 y 6 (ambos incluidos).    
    public int nextNumber() {
        int numeroAleatorio = (int) (Math.random()*6+1);
        return numeroAleatorio;
    }
   
}

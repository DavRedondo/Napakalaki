/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package NapakalakiGame;

import java.util.ArrayList;

/**
 *
 * @author Redondo
 */
public class BadConsequence {
    
    private String text;
    private int levels;
    private int nVisibleTreasures;
    private int nHiddenTreasures;
    private boolean death;
    
    public static final int MAXTREASURES = 10 ; 
    

    public BadConsequence(String text, int levels, int nVisibleTreasures, int nHiddenTreasures) {
        this.text = text;
        this.levels = levels;
        this.nVisibleTreasures = nVisibleTreasures;
        this.nHiddenTreasures = nHiddenTreasures;
    }

    public BadConsequence(String text, boolean death) {
        this.text = text;
        this.death = death;
        /* this.levels = Player.MAXLEVEL;
        this.nVisibleTreasures = MAXTREASURES;
        this.nHiddenTreasures = MAXTREASURES; */
    }
    
    private ArrayList<TreasureKind> specificHiddenTreasures = new ArrayList();
    private ArrayList<TreasureKind> specificVisibleTreasures = new ArrayList();

    
    public BadConsequence(String text, int levels, ArrayList<TreasureKind> tVisible, ArrayList<TreasureKind> tHidden) {
            this.text = text;
            this.levels = levels;
            specificVisibleTreasures = tVisible;
            specificHiddenTreasures = tHidden;
    }
    
    
    public String getText() {
        return text;
    }

    public int getLevels() {
        return levels;
    }

    @Override
    public String toString() {
        return "BadConsequence{" + "text=" + text + ", levels=" + levels + ", nVisibleTreasures=" + nVisibleTreasures + ", nHiddenTreasures=" + nHiddenTreasures + ", death=" + death + ", specificHiddenTreasures=" + specificHiddenTreasures + ", specificVisibleTreasures=" + specificVisibleTreasures + '}';
    }

    public int getnVisibleTreasures() {
        return nVisibleTreasures;
    }

    public int getnHiddenTreasures() {
        return nHiddenTreasures;
    }

    public boolean isDeath() {
        return death;
    }

    public ArrayList<TreasureKind> getSpecificHiddenTreasures() {
        return specificHiddenTreasures;
    }

    public ArrayList<TreasureKind> getSpecificVisibleTreasures() {
        return specificVisibleTreasures;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setLevels(int levels) {
        this.levels = levels;
    }

    public void setnVisibleTreasures(int nVisibleTreasures) {
        this.nVisibleTreasures = nVisibleTreasures;
    }

    public void setnHiddenTreasures(int nHiddenTreasures) {
        this.nHiddenTreasures = nHiddenTreasures;
    }

    public void setDeath(boolean death) {
        this.death = death;
    }

    public void setSpecificHiddenTreasures(ArrayList<TreasureKind> specificHiddenTreasures) {
        this.specificHiddenTreasures = specificHiddenTreasures;
    }

    public void setSpecificVisibleTreasures(ArrayList<TreasureKind> specificVisibleTreasures) {
        this.specificVisibleTreasures = specificVisibleTreasures;
    }
    
    public boolean  isEmpty(){
        
        if (nVisibleTreasures > 0 )
            return false ; 
        else if(nHiddenTreasures > 0)
            return false ;  
        else if(!specificHiddenTreasures.isEmpty())
            return false ; 
        else if(!specificVisibleTreasures.isEmpty())
            return false ; 
        
        return true ; 
    }
    
    
    public void substractVisibleTreasure(Treasure t){
        
        if(specificVisibleTreasures.contains(t.getType()))
           specificVisibleTreasures.remove(t.getType()) ; 
        else if(nVisibleTreasures > 0)
            nVisibleTreasures-- ; 

    }
    
      public void substractHiddenTreasure(Treasure t){
        
            if(specificHiddenTreasures.contains(t.getType()))
           specificHiddenTreasures.remove(t.getType()) ; 
        else if(nHiddenTreasures > 0)
            nHiddenTreasures-- ; 
      }
    
    public BadConsequence adjustToFitTreasureList(ArrayList<Treasure> v, ArrayList<Treasure> h){
   
        if(death) return(new BadConsequence(this.text, true)) ; 
            
        if (nVisibleTreasures > 0 || nHiddenTreasures > 0) {
            int nv = this.getnVisibleTreasures(); 
            int nh = this.getnHiddenTreasures();
            if(nv > v.size())
                nv = v.size() ; 
            if(nh > h.size())
                nh = h.size() ; 
        
            return (new BadConsequence(this.getText(), this.getLevels(), nv, nh)) ; 
            
        } else {
            
            ArrayList<TreasureKind> nuevovisible = new ArrayList() ; 
            for (TreasureKind tipo: specificVisibleTreasures) {
                for (Treasure tesoro: v)
                    if (tesoro.getType() == tipo)
                        nuevovisible.add(tipo) ; 
                break; 
            }
            
            ArrayList<TreasureKind> nuevooculto = new ArrayList(); 
            for (TreasureKind tipo: specificVisibleTreasures) {
                for (Treasure tesoro: h)
                    if (tesoro.getType() == tipo)
                        nuevooculto.add(tipo); 
                break; 
            }
            
            return (new BadConsequence(this.getText(), this.getLevels(), nuevovisible, nuevooculto)); 
        }
    }
}

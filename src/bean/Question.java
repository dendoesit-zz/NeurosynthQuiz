package bean;

import java.io.Serializable;

/**
 * Created by Ryan on 16/03/2018.
 */
public class Question implements Serializable {
    protected int id;
    protected int systema;
    protected int systemb;

    public Question(){
    }

    public Question(int id, int systema, int systemb){
        this.id = id;
        this.systema = systema;
        this.systemb = systemb;
    }

	public int getId() {
        return id;
    }

    public int getSystema() {
        return systema;
    }
    
    public int getSystemb() {
        return systemb;
    }

    public void setId(int id) {
        this.id = id;
    }
    public void setSystema(int systema) {
		this.systema = systema;
	}
    public void setSystemb(int systemb) {
		this.systemb = systemb;
	}


    @Override
    public String toString(){
        return id + ": " + systema + ": " + systemb;
    }
}

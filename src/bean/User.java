package bean;

import java.io.Serializable;

/**
 * Created by Ryan on 16/03/2018.
 */
public class User implements Serializable {
    protected String id;
    protected String pass;

    public User(){
    }

    public User(String id, String pass){
        this.id = id;
        this.pass = pass;
    }

    public String getId() {
        return id;
    }

    public String getPass() {
        return pass;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    @Override
    public String toString(){
        return id + ": " + pass;
    }
}

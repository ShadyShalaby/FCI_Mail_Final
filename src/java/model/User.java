package model;

import java.io.InputStream;
import java.sql.Blob;
import java.util.ArrayList;


/**
 *
 * @author sabry_ragab
 */
public class User {

    private String userEmail;
    private String name;
    private String password;
    private String country;
    private InputStream  profilePic; // change from blob to inputstream ya shady ---> conflict
    private ArrayList<Email> inbox;
    private ArrayList<Email> archive;
    private ArrayList<Email> sent;

    public User(String userEmail, String name, String password, String country,
            InputStream  profilePic, ArrayList<Email> inbox, ArrayList<Email> archive) {//---> conflict
        this.userEmail = userEmail;
        this.name = name;
        this.password = password;
        this.country = country;
        this.profilePic = profilePic;
        this.inbox = inbox;
        this.archive = archive;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

     public ArrayList<Email> getSent() {
        return sent;
    }

    public void setSent(ArrayList<Email> sent) {
        this.sent = sent;
    }
   
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public InputStream  getProfilePic() {  //---> conflict
        return profilePic;
    }

    public void setProfilePic(InputStream  profilePic) { //---> conflict
        this.profilePic = profilePic;
    }

    public ArrayList<Email> getInbox() {
        return inbox;
    }

    public void setInbox(ArrayList<Email> inbox) {
        this.inbox = inbox;
    }

    public ArrayList<Email> getArchive() {
        return archive;
    }

    public void setArchive(ArrayList<Email> archive) {
        this.archive = archive;
    }

}

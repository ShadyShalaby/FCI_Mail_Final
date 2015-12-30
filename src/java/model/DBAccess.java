package model;

import java.util.ArrayList;
import java.io.*;
import java.sql.*;
import javax.sql.*;
import java.sql.DriverManager;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author sabry_ragab
 */
public class DBAccess {

    private Connection con;

    public DBAccess() throws SQLException {

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException cnfe) {
            System.err.println("Error loading driver: " + cnfe);
        }

        con = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/fci_mail",
                "root", "root");
    }

    public void closeConnection() throws SQLException {
        con.close();
    }

    public boolean isValidUser(String userEmail, String password) throws SQLException {

        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM User;");

        while (resultSet.next()) {
            if (userEmail.equals(resultSet.getString("userEmail"))
                    && password.equals(resultSet.getString("password"))) {
                resultSet.close(); //release resources
                stmt.close(); //release resources             
                return true;
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources
        return false;
    }

   public User getUser(String userEmail) throws SQLException {

        String name = "", password = "", country = "";
        InputStream  profilePic = null;

        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM User;");

        while (resultSet.next()) {
            if (userEmail.equals(resultSet.getString("userEmail"))) {
                name = resultSet.getString("name");
                password = resultSet.getString("password");
                country = resultSet.getString("country");
                profilePic = resultSet.getBinaryStream("profilePic");   
                break;
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources

        ArrayList<Email> inbox = getUserInbox(userEmail);
        ArrayList<Email> archive = getUserArchive(userEmail);

        User user = new User(userEmail, name, password, country,
                profilePic, inbox, archive);

        return user;
    }
    
    public boolean isExistEmail(String userEmail) throws SQLException {
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM User;");

        while (resultSet.next()) {
            if (userEmail.equals(resultSet.getString("userEmail"))) {
                resultSet.close(); //release resources
                stmt.close(); //release resourcesF
                return true;
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources
        return false;
    }
    
        
    public ArrayList<Email> getSearchResult(String text, String userEmail) throws SQLException{
        ArrayList<Email> searchResult = new ArrayList<Email>();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM Email;");
        while (resultSet.next()) {
         
            if ( (text.contains(resultSet.getString("sender")) || text.contains(resultSet.getString("receiver")) || 
                    resultSet.getString("sender").contains(text) || resultSet.getString("receiver").contains(text))
                    && (  userEmail.equals(resultSet.getString("sender")) || 
                    userEmail.equals(resultSet.getString("receiver")) ) ){
                
                int emailID = resultSet.getInt("emailID");
                String sender = resultSet.getString("sender");
                String receiver = resultSet.getString("receiver");
                String subject = resultSet.getString("subject");
                String body = resultSet.getString("body");
                int replyID = resultSet.getInt("replyID");
                int isArchieved = resultSet.getInt("isArchieved");
                Date emailDateTime = resultSet.getDate("emailDateTime");
                searchResult.add(new Email(emailID, sender, receiver, subject, body, replyID, isArchieved, emailDateTime));
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources

        return searchResult;
    }

    public void addNewUser(User user) throws SQLException {
        PreparedStatement pre = con.prepareStatement("insert into User values(?,?,?,?,?)");
        pre.setString(1, user.getUserEmail());
        pre.setString(2, user.getName());
        pre.setString(3, user.getPassword());
        pre.setString(4, user.getCountry());
        pre.setBinaryStream(5, (InputStream) user.getProfilePic());
        pre.executeUpdate();
        pre.close();
    }

    public void updateUserData(User user) throws SQLException {
        Statement stmt = con.createStatement();
        String UQuery = "UPDATE User "
                + "SET name='" + user.getName() + "', country= '" + user.getCountry()
                + "', password='" + user.getPassword()
                + "' WHERE userEmail= '" + user.getUserEmail() + "';";

        stmt.executeUpdate(UQuery);
    }

    public void updateUserProfile(User user) throws SQLException {
        Statement stmt = con.createStatement();
        String UQuery = "UPDATE User "
                + "SET profilePic='" + user.getProfilePic()
                + "' WHERE userEmail= '" + user.getUserEmail() + "';";

        stmt.executeUpdate(UQuery);
    }

    /**
     * ********************** BY Shady ***************************
     */
    public Email getEmail(int EmailID) throws SQLException {

        Statement stmt = con.createStatement();
        String query = "SELECT * FROM Email WHERE emailID=" + EmailID + " OR ReplyID=" + EmailID + ";";
        Email email = null;
        ArrayList<Email> emailReplies = new ArrayList<Email>();
        ResultSet resultSet = stmt.executeQuery(query);

        while (resultSet.next()) {
            int emailID = resultSet.getInt("emailID");
            String sender = resultSet.getString("sender");
            String receiver = resultSet.getString("receiver");
            String subject = resultSet.getString("subject");
            String body = resultSet.getString("body");
            int replyID = resultSet.getInt("replyID");
            int isArchieved = resultSet.getInt("isArchieved");
            Date emailDateTime = resultSet.getDate("emailDateTime");

            if (emailID == EmailID) {
                email = new Email(emailID, sender, receiver, subject, body, replyID, isArchieved, emailDateTime);
            } else {
                emailReplies.add(new Email(emailID, sender, receiver, subject, body, replyID, isArchieved, emailDateTime));
            }
        }

        email.setReplies(emailReplies);
        resultSet.close();  //release resources
        stmt.close();       //release resources
        return email;
    }

    /**
     * ********************** BY Shady ***************************
     */
    public int addReply(Email email) throws SQLException {

        Statement stmt = con.createStatement();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String date = "";
        date = dateFormat.format(cal.getTime());

        String query = "Insert into email (sender, receiver, subject, body, replyID, isArchieved, emailDateTime)"
                + " values('" + email.getSender() + "' , '" + email.getReceiver() + "' , '" + email.getSubject() + "' , "
                + "'" + email.getBody() + "' , " + email.getReplyID() + "," + 0 + ",'" + date + "')";

        int affectedRows = stmt.executeUpdate(query);
        stmt.close();       //release resources
        return affectedRows;
    }

    /******************************* By Sherif **************************/
    
    public boolean addNewEmail(Email email) throws SQLException {
        Statement stmt = con.createStatement();
        String sender = email.getSender();
        String receiver = email.getReceiver();
        String subject = email.getSubject();
        String body = email.getBody();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String date = "";
        date = dateFormat.format(cal.getTime());
        String query = "INSERT INTO email (sender,receiver,subject,body,replyID,isArchieved,emailDateTime,deleted)"
                + "values('" + sender + "','" + receiver + "','"
                + subject + "','" + body + "'," + null + "," + 0 + ",'" + date + "'," + 0 + ")";

        int affectedRows = stmt.executeUpdate(query);

        if (affectedRows > 0) {
            return true;
        } else {
            return false;
        }

    }

    public boolean forwardEmail(Email email) throws SQLException {
        Statement stmt = con.createStatement();
        String sender = email.getSender();
        String receiver = email.getReceiver();
        String subject = email.getSubject();
        String body = email.getBody();

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        String date = "";
        date = dateFormat.format(cal.getTime());
        String query = "INSERT INTO email (sender,receiver,subject,body,replyID,isArchieved,emailDateTime,deleted)"
                + "values('" + sender + "','" + receiver + "','"
                + subject + "','" + body + "'," + null + "," + 0 + ",'" + date + "'," + 0 + ")";

        int affectedRows = stmt.executeUpdate(query);

        if (affectedRows > 0) {
            return true;
        } else {
            return false;
        }

    }
    
    //*********************//
    public boolean deleteEmails(ArrayList<Email> emails, User user) throws SQLException {

        PreparedStatement stmt = null;
        int change = -1;
        for (int i = 0; i < emails.size(); i++) {
            Email temp = emails.get(i);
            if (temp.getReceiver().equals(user.getUserEmail())) {
                String query = "UPDATE Email SET deleted= CASE WHEN deleted=0 THEN 2 ELSE 3 END WHERE EmailID=" + temp.getEmailID() + ";";
                stmt = con.prepareStatement(query);
                change = stmt.executeUpdate(query);

            } else if (temp.getSender().equals(user.getUserEmail())) {
                String query = "UPDATE Email SET deleted= CASE WHEN deleted=0 THEN 1 ELSE 3 END WHERE EmailID=" + temp.getEmailID() + ";";
                stmt = con.prepareStatement(query);
                change = stmt.executeUpdate(query);

            }

        }
        stmt.close();
        if (change == -1) {
            return false;
        }
        return true;
    }

    public boolean archiveEmails(ArrayList<Email> emails, User user) throws SQLException {

        PreparedStatement stmt = null;
        int change = -1;
        for (int i = 0; i < emails.size(); i++) {
            Email temp = emails.get(i);
            if (temp.getReceiver().equals(user.getUserEmail())) {

                String query = "UPDATE Email SET isArchieved= CASE WHEN isArchieved=0 THEN 2 ELSE 3 END WHERE EmailID=" + temp.getEmailID() + ";";
                stmt = con.prepareStatement(query);
                change = stmt.executeUpdate(query);

            } else if (temp.getSender().equals(user.getUserEmail())) {
                String query = "UPDATE Email SET isArchieved= CASE WHEN isArchieved=0 THEN 1 ELSE 3 END WHERE EmailID=" + temp.getEmailID() + ";";
                stmt = con.prepareStatement(query);
                change = stmt.executeUpdate(query);

            }

        }
        stmt.close();
        if (change == -1) {
            return false;
        }
        return true;
    }
    
    
    public ArrayList<Email> getUserSent(String userEmail) throws SQLException {
        ArrayList<Email> inbox = new ArrayList<Email>();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM Email;");
        while (resultSet.next()) {
            if (userEmail.equals(resultSet.getString("sender"))
                    && (resultSet.getInt("isArchieved") != 1 && resultSet.getInt("isArchieved") != 3)
                    && (resultSet.getInt("deleted") != 1 && resultSet.getInt("deleted") != 3)) {

                int emailID = resultSet.getInt("emailID");
                String sender = resultSet.getString("sender");
                String receiver = resultSet.getString("receiver");
                String subject = resultSet.getString("subject");
                String body = resultSet.getString("body");
                int replyID = resultSet.getInt("replyID");
                int isArchieved = resultSet.getInt("isArchieved");
                Date emailDateTime = resultSet.getDate("emailDateTime");
                if (replyID == 0) {

                    inbox.add(new Email(emailID, sender, receiver, subject, body, replyID, isArchieved, emailDateTime));
                }

            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources

        return inbox;
    }
    public ArrayList<Email> getUserInbox(String userEmail) throws SQLException {
        ArrayList<Email> inbox = new ArrayList<Email>();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM Email;");
        while (resultSet.next()) {
            if (userEmail.equals(resultSet.getString("receiver"))
                    && (resultSet.getInt("isArchieved") != 2 && resultSet.getInt("isArchieved") != 3)
                    && (resultSet.getInt("deleted") != 2 && resultSet.getInt("deleted") != 3)) {

                int emailID = resultSet.getInt("emailID");
                String sender = resultSet.getString("sender");
                String receiver = resultSet.getString("receiver");
                String subject = resultSet.getString("subject");
                String body = resultSet.getString("body");
                int replyID = resultSet.getInt("replyID");
                int isArchieved = resultSet.getInt("isArchieved");
                Date emailDateTime = resultSet.getDate("emailDateTime");
                if (replyID == 0) {

                    inbox.add(new Email(emailID, sender, receiver, subject, body, replyID, isArchieved, emailDateTime));
                }

            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources

        return inbox;
    }

    public ArrayList<Email> getUserArchive(String userEmail) throws SQLException {
        ArrayList<Email> archive = new ArrayList<Email>();
        Statement stmt = con.createStatement();
        ResultSet resultSet = stmt.executeQuery("SELECT * FROM Email;");
        while (resultSet.next()) {

            if ((userEmail.equals(resultSet.getString("sender")) && (resultSet.getInt("isArchieved") == 1 || resultSet.getInt("isArchieved") == 3)
                    && (resultSet.getInt("deleted") != 1 && resultSet.getInt("deleted") != 3))
                    || (userEmail.equals(resultSet.getString("receiver")) && (resultSet.getInt("isArchieved") == 2 || resultSet.getInt("isArchieved") == 3)
                    && (resultSet.getInt("deleted") != 2 && resultSet.getInt("deleted") != 3))) {
                int emailID = resultSet.getInt("emailID");
                String sender = resultSet.getString("sender");
                String receiver = resultSet.getString("receiver");
                String subject = resultSet.getString("subject");
                String body = resultSet.getString("body");
                int replyID = resultSet.getInt("replyID");
                int isArchieved = resultSet.getInt("isArchieved");
                Date emailDateTime = resultSet.getDate("emailDateTime");
                if (replyID == 0) {
                    archive.add(new Email(emailID, sender, receiver, subject, body, replyID, isArchieved, emailDateTime));
                }
            }
        }
        resultSet.close(); //release resources
        stmt.close(); //release resources

        return archive;
    }

}

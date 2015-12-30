
package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author sabry_ragab
 */
public class Email {

    private int emailID;
    private String sender;
    private String receiver;
    private String subject;
    private String body;
    private int replyID;
    private int isArchieved;
    private Date emailDateTime ; // to be checked
    private ArrayList <Email> replies;

    public Email(int emailID, String sender, String receiver, String subject, String body, 
            int replyID, int isArchieved, Date emailDateTime) {
        this.emailID = emailID;
        this.sender = sender;
        this.receiver = receiver;
        this.subject = subject;
        this.body = body;
        this.replyID = replyID;
        this.isArchieved = isArchieved;
        this.emailDateTime = emailDateTime;
        this.replies = new ArrayList<Email>();
    }

    public int getEmailID() {
        return emailID;
    }

    public void setEmailID(int emailID) {
        this.emailID = emailID;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getReplyID() {
        return replyID;
    }

    public void setReplyID(int replyID) {
        this.replyID = replyID;
    }

    public int isIsArchieved() {
        return isArchieved;
    }

    public void setIsArchieved(int isArchieved) {
        this.isArchieved = isArchieved;
    }

    public Date getEmailDateTime() {
        return emailDateTime;
    }

    public void setEmailDateTime(Date emailDateTime) {
        this.emailDateTime = emailDateTime;
    }
    
    public ArrayList<Email> getReplies() {
        return replies;
    }

    public void setReplies(ArrayList<Email> replies) {
        this.replies = replies;
    }
    

}

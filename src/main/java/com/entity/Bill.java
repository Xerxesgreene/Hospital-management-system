package com.entity;

import java.util.Date;

public class Bill {
    private int bid; // Assuming bid is an auto-generating primary key
    private int pid; // Foreign key referencing another table
    private int appId; // Foreign key referencing another table
    private Date date; // Date attribute

    // Constructors
    public Bill() {
    }

    public Bill(int pid, int appId, Date date) {
        this.pid = pid;
        this.appId = appId;
        this.date = date;
    }

    // Getters and setters
    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getAppId() {
        return appId;
    }

    public void setAppId(int appId) {
        this.appId = appId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    // Additional getters and setters
    // ...
}

package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.entity.Bill;

public class BillDao {
    private Connection connection;

    public BillDao(Connection connection) {
        this.connection = connection;
    }
    public BillDao() {
        
    }
    public List<Bill> getBillsByUserId(int userId) {
        List<Bill> billList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM bill WHERE pid = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Bill bill = new Bill();
                        bill.setBid(rs.getInt("bid"));
                        bill.setPid(rs.getInt("pid"));
                        bill.setAppId(rs.getInt("appId"));
                        // Add the bill to the list
                        billList.add(bill);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return billList;
    }
    public boolean insertBill(String appointmentId, String userId) {
        PreparedStatement ps = null;

        try {
            // Prepare the SQL statement for insertion
            String sql = "INSERT INTO bill (appid, pid) VALUES (?, ?)";
            ps = connection.prepareStatement(sql);
            ps.setString(1, appointmentId);
            ps.setString(2, userId);

            // Execute the insert statement
            int rowsAffected = ps.executeUpdate();

            // Return true if at least one row is affected
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            // Close the PreparedStatement
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public int getAppIdByBillId(int billId) {
        String sql = "SELECT appId FROM bill WHERE bid = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, billId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt("appId");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
        }

        return -1; // Return -1 if no appId found or handle it according to your business logic
    }
    public List<Integer> getAppIdsByPId(int pid) {
        List<Integer> appIds = new ArrayList<>();
        String sql = "SELECT appId FROM bill WHERE pid = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, pid);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    appIds.add(resultSet.getInt("appId"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
        }

        return appIds;
    }
    public void close() {
        // Implement the close method if needed
        // Close any additional resources related to database connections
    }
    public List<Bill> getAllBills() {
        List<Bill> billList = new ArrayList<>();

        String sql = "SELECT * FROM bill";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBid(rs.getInt("bid"));
                bill.setPid(rs.getInt("pid"));
                bill.setAppId(rs.getInt("appId"));
                
             
                
                billList.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return billList;
    }

}

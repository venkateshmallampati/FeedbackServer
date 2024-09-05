package myclgproject;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Faculty")
public class Faculty extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	String rollno = (String) session.getAttribute("rollno");
    	session.setAttribute("rollno", rollno);
    	
    	String ss = (String) session.getAttribute("ss");
    	session.setAttribute("ss", ss);
    	
        String cycle = (String) session.getAttribute("cycle");
        session.setAttribute("cycle", cycle);
        String academicYear = (String) session.getAttribute("academicyear");
        session.setAttribute("academicyear", academicYear);
        String facultyst = "SELECT fid, sub, fname FROM faculty WHERE fid=? AND sec=?";
        int fCounter=0;
        
        if (request.getParameter("fCounter") != null) {
        	String fCounterParam = request.getParameter("fCounter");
            fCounter = Integer.parseInt(fCounterParam);    
        }
        // Increment subjectCounter by 1 to start from the next subject
        fCounter++;
        Connection con = null;
        try {
        	con = DBConnect.connect();
            String query = "SELECT COUNT(*) AS total FROM faculty WHERE acc_year = ? AND sec = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, academicYear);
            stmt.setString(2, ss);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) 
                     rs.getInt("total");
        	int totalSubjects = rs.getInt("total"); // Assuming you have 5 subjects
            boolean isLastSubject = (fCounter == totalSubjects + 1);

            if (isLastSubject) {
                // Redirect to a new page indicating successful completion
                response.sendRedirect("last.html");
            }
                else{
            

            PreparedStatement facultyStmt = con.prepareStatement(facultyst);
            
            String[]fids=(String[])session.getAttribute("fids");
            facultyStmt.setString(1, fids[fCounter-1]);
            facultyStmt.setString(2,ss);
            ResultSet facultyResult = facultyStmt.executeQuery();
            if (facultyResult.next()) {
            	
            	String[] facultyinfo = new String[3];
            	facultyinfo[0] = facultyResult.getString("fid");
                facultyinfo[1] = facultyResult.getString("sub");
                facultyinfo[2] = facultyResult.getString("fname");
                session.setAttribute("facultyinfo", facultyinfo);
                request.setAttribute("fCounter", fCounter);

                request.getRequestDispatcher("Questions1.jsp").forward(request, response);
            }
                }
            
        } catch (SQLException e) {
            e.printStackTrace(); // Handle database errors
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Handle class not found exception
        } finally {
            // Close the database connection
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String rollno = request.getParameter("rnumber");
        session.setAttribute("rollno", rollno);
        String cycle = request.getParameter("cycle");
        session.setAttribute("cycle", cycle);
        String academicYear = request.getParameter("academicyear");
        session.setAttribute("academicyear", academicYear);
        String sec = request.getParameter("section");
        String year = request.getParameter("year");
        String sem = request.getParameter("sem");
        
        session.setAttribute("sec", sec);
        
        String branch = request.getParameter("branch");
        String ss = year + "_" + sem + "_" + branch + "_" + sec;
        String facultyQuery = "SELECT fid FROM faculty WHERE sec = ? AND acc_year = ?";
        String facultyst = "SELECT fid, sub, fname FROM faculty WHERE fid=? AND sec=?";
        int fCounter = 0; // Initialize to 0 to access the first subject
        
        // Check if subjectCounter is provided in the request
        if (request.getParameter("fCounter") != null) {
            fCounter = Integer.parseInt(request.getParameter("fCounter"));
        }
        // Increment subjectCounter by 1 to start from the next subject
        fCounter++;

        Connection con = null;
        try {
            con = DBConnect.connect();
            PreparedStatement facultyQur = con.prepareStatement(facultyQuery);
            facultyQur.setString(1, ss);
            facultyQur.setString(2, academicYear);
            ResultSet facultyRes = facultyQur.executeQuery();
            PreparedStatement facultyStmt = con.prepareStatement(facultyst);
            String[] fids = new String[6];
            int index = 0; 
             while (facultyRes.next() && index < 6) {
                 String fid = facultyRes.getString("fid");
                 fids[index] = fid;
                 index++;
            }
            
            facultyStmt.setString(1, fids[fCounter-1]);
            facultyStmt.setString(2,ss);
            ResultSet facultyResult = facultyStmt.executeQuery();
            session.setAttribute("fids", fids);
            if (facultyResult.next()) {
            	
            	String[] facultyinfo = new String[3];
            	facultyinfo[0] = facultyResult.getString("fid");
                facultyinfo[1] = facultyResult.getString("sub");
                facultyinfo[2] = facultyResult.getString("fname");
                session.setAttribute("facultyinfo", facultyinfo);
                session.setAttribute("fCounter", fCounter);
                
                session.setAttribute("ss",ss);
                
                
                request.getRequestDispatcher("Questions1.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace(); // Handle database errors
        } finally {
            // Close the database connection
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
    

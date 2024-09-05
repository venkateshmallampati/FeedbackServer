package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SubmitFeedback
 */
@WebServlet("/SubmitFeedback")
public class SubmitFeedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
        try {
            response.setContentType("text/html");
            
            con = DBConnect.connect();

            HttpSession session = request.getSession();
            String rollno = (String) session.getAttribute("rollno");
            String academicyear = request.getParameter("academicyear");
            String sec = request.getParameter("sec");

            String cycle =request.getParameter("cycle");
            
            int fCounter = Integer.parseInt(request.getParameter("fCounter"));
 // Assuming subjectCounter is passed
            
            // Retrieve answers from the form
            String[] answers = new String[5]; // Assuming there are 5 questions
            for (int i = 0; i < 5; i++) {
                String answer = request.getParameter("answer" + (i + 1));
                answers[i] = answer; // Store the answer or an empty string if not provided
            }
            String query ="INSERT INTO answers (rollno, acc_year,sec,fid ,q1, q2, q3, q4, q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15) VALUES (?, ?, ?,?,?, ?, ?, ?,?,?,?,?,?,?,?,?,?,?,?)";
            
            PreparedStatement Stmt1 = con.prepareStatement(query); 
            String[] fids = (String[]) session.getAttribute("fids");
           
            // Set parameters for each subject's statement
            Stmt1.setString(1, rollno);
            Stmt1.setString(2, academicyear );
            Stmt1.setString(3, sec);
            
            Stmt1.setString(4, fids[fCounter]);
            // Set feedback values for each subject
            for (int i = 1; i <=15 ; i++) {
                Stmt1.setString(i + 4, request.getParameter("q" + i));                
            }

            Stmt1.executeUpdate();
            if (fCounter == 5) {
                // If it's the last subject, redirect to success page
                response.sendRedirect("last.html");
            } else {
                // If there are more subjects, redirect to the questionnaire page for the next subject
                response.sendRedirect("Faculty?rollno=" +rollno +
                		               "&acadmicyear="+academicyear+
                		               "&sec="+sec+
                                       "&cycle=" + cycle +
                                       "&fCounter=" + (fCounter + 1)); // Increment subjectCounter
            }

            
        }catch (Exception e) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
            
	}

}

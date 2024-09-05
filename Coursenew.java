package myclgproject;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/Coursenew")
public class Coursenew extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Connection con = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String rollno = (String) session.getAttribute("rollno");
        session.setAttribute("rollno", rollno);
        String academicyear = (String) session.getAttribute("academicyear");
        session.setAttribute("academicyear", academicyear);
        String year = request.getParameter("year");
        String sem = request.getParameter("sem");
        String branch = request.getParameter("branch");
        session.setAttribute("year", year);
        session.setAttribute("sem", sem);
        session.setAttribute("branch", branch);
        int subjectCounter = 0; // Initialize to 0 to access the first subject

        // Check if subjectCounter is provided in the request
        if (request.getParameter("subjectCounter") != null) {
            subjectCounter = Integer.parseInt(request.getParameter("subjectCounter"));
        }
        // Increment subjectCounter by 1 to start from the next subject
        subjectCounter++;

        String query = "SELECT subject1,subject2,subject3,subject4,subject5 FROM subs  WHERE year = ? AND sem=? AND branch =?;";

        try {
            con = DBConnect.connect();
            PreparedStatement st = con.prepareStatement(query);

            st.setString(1, year);
            st.setString(2, sem);
            st.setString(3, branch);
            ResultSet rst = st.executeQuery();
            // Process each row of subjects
            while (rst.next()) {
                // Retrieve subjects for the row
                String[] subjects = new String[] { rst.getString("subject1"), rst.getString("subject2"),
                        rst.getString("subject3"), rst.getString("subject4"), rst.getString("subject5") };
                // Determine if the current subject is the last subject
                int totalSubjects = 6; // Assuming you have 5 subjects
                boolean isLastSubject = (subjectCounter == totalSubjects);

                if (isLastSubject) {
                    // Redirect to a new page indicating successful completion
                    response.sendRedirect("last.html");
                } else {
                    session.setAttribute("subjects", subjects);
                    request.setAttribute("subjectCounter", subjectCounter);
                    String currentSubject = subjects[subjectCounter - 1];
                    String query2 = "SELECT * FROM cosnsubjects WHERE subjectName=?;";
                    PreparedStatement stt = con.prepareStatement(query2);
                    stt.setString(1, currentSubject);
                    ResultSet rs = stt.executeQuery();
                    String[] questions = new String[5];
                    if (rs.next()) {
                        questions[0] = rs.getString("co1");
                        questions[1] = rs.getString("co2");
                        questions[2] = rs.getString("co3");
                        questions[3] = rs.getString("co4");
                        questions[4] = rs.getString("co5");
                    }
                    request.setAttribute("questions", questions);
                    request.getRequestDispatcher("Questions.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the exception for debugging purposes
            e.printStackTrace();

            response.setContentType("text/html");
            PrintWriter oout = response.getWriter();
            oout.println("An error occurred: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rollno = request.getParameter("rnumber");
        String academicyear = request.getParameter("academicyear");
        HttpSession session = request.getSession();
        session.setAttribute("rollno", rollno);
        session.setAttribute("academicyear", academicyear);
        String year = request.getParameter("year");
        String sem = request.getParameter("sem");
        String branch = request.getParameter("branch");
        session.setAttribute("year", year);
        session.setAttribute("sem", sem);
        session.setAttribute("branch", branch);
        int subjectCounter = 0; // Initialize to 0 to access the first subject

        // Check if subjectCounter is provided in the request
        if (request.getParameter("subjectCounter") != null) {
            subjectCounter = Integer.parseInt(request.getParameter("subjectCounter"));
        }
        // Increment subjectCounter by 1 to start from the next subject
        subjectCounter++;

        String query = "SELECT subject1,subject2,subject3,subject4,subject5 FROM subs  WHERE year = ? AND sem=? AND branch =?;";

        try {
            con = DBConnect.connect();
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, year);
            st.setString(2, sem);
            st.setString(3, branch);
            ResultSet rst = st.executeQuery();
            // Process each row of subjects
            while (rst.next()) {
                // Retrieve subjects for the row
                String[] subjects = new String[] { rst.getString("subject1"), rst.getString("subject2"),
                        rst.getString("subject3"), rst.getString("subject4"), rst.getString("subject5") };
                // Determine if the current subject is the last subject
                int totalSubjects = 6; // Assuming you have 5 subjects
                boolean isLastSubject = (subjectCounter == totalSubjects);
                if (isLastSubject) {
                    response.sendRedirect("su.html");
                } else {
                    session.setAttribute("subjects", subjects);
                    request.setAttribute("subjectCounter", subjectCounter);
                    String currentSubject = subjects[subjectCounter - 1];
                    String query2 = "SELECT * FROM cosnsubjects WHERE subjectName=?;";
                    PreparedStatement stt = con.prepareStatement(query2);
                    stt.setString(1, currentSubject);
                    ResultSet rs = stt.executeQuery();

                    String[] questions = new String[5];
                    if (rs.next()) {
                        questions[0] = rs.getString("co1");
                        questions[1] = rs.getString("co2");
                        questions[2] = rs.getString("co3");
                        questions[3] = rs.getString("co4");
                        questions[4] = rs.getString("co5");
                    }
                    request.setAttribute("questions", questions);
                    request.getRequestDispatcher("Questions.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the exception for debugging purposes
            e.printStackTrace();

            response.setContentType("text/html");
            PrintWriter oout = response.getWriter();
            oout.println("An error occurred: " + e.getMessage());
        }

    }
}

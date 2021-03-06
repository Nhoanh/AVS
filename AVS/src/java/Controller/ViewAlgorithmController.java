/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Entity.Algorithm;
import Entity.User;
import Model.AlgorithmModel;
import Model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ukah
 */
@WebServlet(name = "ViewAlgorithm", urlPatterns = {"/viewalgo"})
public class ViewAlgorithmController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            HttpSession session = request.getSession();

            //hien thi trang home neu nguoi dung khong phai admin
            Cookie cookie[] = request.getCookies();
            String roleid = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
            }
            int adminrolenumber = 1;
            if (roleid == null || Integer.parseInt(roleid) != adminrolenumber) {
                response.sendRedirect("home");
                return;
            }
            //ket thuc kiem tra
            
            int algoid = Integer.parseInt(request.getParameter("id"));
            AlgorithmModel algodao = new AlgorithmModel();
            Algorithm thisalgo = algodao.getAlgoByID(algoid);
            
            String category = "algorithm";
            request.setAttribute("category", category);
            request.setAttribute("algo", thisalgo);
            request.setAttribute("addnew", false);
            request.getRequestDispatcher("jsp/viewalgo.jsp").forward(request, response);

        } catch (Exception ex) {
            response.sendRedirect("error");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

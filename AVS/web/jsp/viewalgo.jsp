<%-- 
    Document   : viewalgo
    Created on : Mar 19, 2020, 9:15:51 PM
    Author     : Ukah
--%>

<%@page import="Model.UserModel"%>
<%@page import="Entity.User"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Entity.Algorithm"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/Visual.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />

        <%
            Algorithm algo = (Algorithm) request.getAttribute("algo");
            Boolean addnew = (Boolean) request.getAttribute("addnew");
        %>
    </head>

    <body>
        <%@include file="header.jsp" %> 

        <div class="banner">
            <h1>Welcome to Algorithm Visualize System</h1>
            <h5>The noblest pleasure is the joy of understanding</h5>
        </div>
        <div class="main">
            <%@include file="adminleft.jsp" %> 
            <div class="right">

                <div class="algoinfomation">
                    <%if (addnew) {%>
                    <!--trang addnew-->
                    <form method="POST" action="manage">
                        <input type="hidden" name="managetype" value="addalgo">

                        <div>Name: </div> <div><input type="text" name="algoname" value=""></div>
                        <div>Code Java:  </div> <div><textarea name="codejava" rows="10" cols="30" ></textarea></div>
                        <div>Code C++:  </div> <div><textarea name="codecpp" rows="10" cols="30" ></textarea></div>
                        <div>Code JS:  </div> <div><textarea name="codejs" rows="10" cols="30" ></textarea></div>
                        <div>Code Visualize:  </div> <div><textarea name="codevisual" rows="10" cols="30" ></textarea></div>
                        <div>Description: </div> <div><textarea name="description" rows="10" cols="30" ></textarea></div>
                        <div>Resource: </div> <div><input type="text" name="resource" value=""></div>
                        <div>Category: </div> <div>
                            <input type="hidden" name="category" id="inputcategory" value="1">
                            <select id="selectcategory" onchange="changeCategory(this)">
                                <option value="1">Sort</option>
                                <option value="2">Search</option>
                                <option value="3">Other</option>
                            </select></div>
                        <input type="submit" value="Save">
                    </form>

                    <a href="admin?category=algorithm"><button>Cancel</button></a>

                    <%} else {%>
                    <!--trang view-->
                    <div class="algoid">Algorithm ID: <%=algo.getAlgoID()%></div>
                    <div> Added Time: <%=algo.getAlgoDatetime()%></div>
                    <form method="POST" action="manage">
                        <input type="hidden" name="managetype" value="editalgo">
                        <input type="hidden" name="algoid" value="<%=algo.getAlgoID()%>" >
                        <div>Name: </div> <div><input type="text" name="algoname" value="<%=algo.getAlgoName()%>"></div>
                        <div>Code Java:  </div> <div><textarea name="codejava" rows="10" cols="30" ><%=algo.getAlgoCodeJava()%></textarea></div>
                        <div>Code C++:  </div> <div><textarea name="codecpp" rows="10" cols="30" ><%=algo.getAlgoCodeCplus()%></textarea></div>
                        <div>Code JS:  </div> <div><textarea name="codejs" rows="10" cols="30" ><%=algo.getAlgoCodeJS()%></textarea></div>
                        <div>Code Visualize:  </div> <div><textarea name="codevisual" rows="10" cols="30" ><%=algo.getAlgoCodeVisual()%></textarea></div>
                        <div>Description: </div> <div><textarea name="description" rows="10" cols="30" ><%=algo.getAlgoDescription()%></textarea></div>
                        <div>Resource: </div> <div><input type="text" name="resource" value="<%=algo.getAlgoResource()%>"></div>
                        <div>Category: </div> <div>
                            <input type="hidden" name="category" id="inputcategory" value="<%=algo.getCategoryID()%>">
                            <select id="selectcategory" onchange="changeCategory(this)">
                                <option value="1">Sort</option>
                                <option value="2">Search</option>
                                <option value="3">Other</option>
                            </select></div>
                        <input type="submit" value="Save">
                    </form>
                    <a href="admin?category=algorithm"><button>Back</button></a>
                    <form method="POST" action="manage">
                        <input type="hidden" name="managetype" <%if(algo.getDeleted()==1){%>value="restorealgo"<%}else{%>value="deletealgo"<%}%>>
                        <input type="hidden" name="algoid" value="<%=algo.getAlgoID()%>" >
                        <input type="submit" <%if(algo.getDeleted()==1){%>value="Restore"<%}else{%>value="Delete"<%}%>>
                    </form>
                    <script>
                        document.getElementById("selectcategory").selectedIndex = <%=algo.getCategoryID()%> - 1;
                    </script>
                    <%}%>
                </div>
            </div>
            <%@include file="footer.jsp" %>    

    </body>
    <script>
        function changeCategory(element) {
            document.getElementById("inputcategory").value = element.options[element.selectedIndex].value;
        }
    </script>
</html>

<%-- 
    Document   : noteGraph
    Created on : Mar 3, 2020, 8:05:14 PM
    Author     : quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <style>
            .rectangle {
                height: 50px;
                width: 50px;
            }
        </style>
        <%
            int red = 100;
            int green = 255;
            int blue = 255;
            String[] graphnamearr = {"bubblesort", "selectionsort", "insertionsort", "quicksort", "mergesort"};
            for (int i = 0; i < graphnamearr.length; i++) {
        %>
        <div>
            <div class="rectangle" style="background-color:rgb(<%=red%>,<%=green%>,<%=blue%>)"></div>
            <a href="<%=graphnamearr[i]%>"><%=graphnamearr[i]%></a>
        </div>
        <%
            }
        %>
    </body>
</html>

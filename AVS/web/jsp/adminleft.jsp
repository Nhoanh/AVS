<%-- 
    Document   : adminleft
    Created on : Mar 20, 2020, 9:35:13 PM
    Author     : Ukah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>

            #category {
                background-color: #edf0f4;
                color: black;
                cursor: pointer;
                padding: 18px;
                width: inherit;
                border: none;
                text-align: left;
                outline: none;
                font-size: 15px;
            }

            #category>a {
                color: black;
                cursor: pointer;
                width: 100%;
                border: none;
                outline: none;
                font-size: 15px;
            }

            #category:hover {
                background-color: gray;
                color: aqua;
            }

            .category_active{
                background-color: gray !important;
                color: aqua !important;
            }

            .tableadmin>table {
                border-collapse: collapse;
            }

            table,th,td{
                border: #29323d solid 1px;
            }

            /*            .show{
                            max-height: 97px !important;
                        }*/

        </style>
        <%
            String category = (String) request.getAttribute("category");
        %>
    </head>

    <body>
        <div class="left">
            <a style="text-decoration: none"  href="admin?category=account"><div <c:if test="${category eq 'account'}">class="category_active"</c:if> id="category">Account</div></a>
            <a style="text-decoration: none"  href="admin?category=algorithm"><div <c:if test="${category eq 'algorithm'}">class="category_active"</c:if>id="category" >Algorithm</div></a>
            <a style="text-decoration: none"  href="admin?category=news"><div <c:if test="${category eq 'news'}">class="category_active"</c:if>id="category" >News</div></a>
            <button type="button" class="collapsible" <%if(category == "history") {%>id="autoopen"<%}%>>History</button>
            <div class="content show">
                <ul class="list_items"> 
                    <li><a style=" text-decoration: none;" id="AlgoNameList" href="admin?category=user_history"">User history</a></li>
                    <li><a style=" text-decoration: none;" id="AlgoNameList" href="admin?category=algo_history"">Algorithm history</a></li>
                    <li><a style=" text-decoration: none;" id="AlgoNameList" href="admin?category=news_history"">News history</a></li>
                </ul>
            </div>
        </div>
        <script type="text/javascript" src="js/code.js"></script>
        
        <script>
                document.getElementById("autoopen").click();
        </script>
    </body>
</html>

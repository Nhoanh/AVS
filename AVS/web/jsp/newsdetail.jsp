
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="Entity.Likenews"%>
<%@page import="Entity.Likecomment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Entity.News"%>
<%@page import="Entity.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <script src="https://kit.fontawesome.com/5a03b2ca60.js" crossorigin="anonymous"></script>      
        <link rel="stylesheet" type="text/css" href="css/style.css" />        


        <%@include file="header.jsp" %> 

    </head>
    <body>   

        <%
            Cookie cookie[] = request.getCookies();
            int age = cookie[0].getMaxAge();
            String username = "";
            String userid = "";
            String roleid = "";
            for (Cookie ck : cookie) {
                if (ck.getName().equals("username")) {
                    username = ck.getValue();
                }
                if (ck.getName().equals("roleid")) {
                    roleid = ck.getValue();
                }
                if (ck.getName().equals("userid")) {
                    userid = ck.getValue();
                }
                if (age == 0) {
                    username = "";
                    userid = "";
                }
            }
        %>


        <%
            ArrayList<Comment> listallcommentbynewid = (ArrayList<Comment>) request.getAttribute("listallcommentbynewid");
            News news = (News) request.getAttribute("news");
            HashMap<Integer, Integer> commentid_and_numberof_like = (HashMap<Integer, Integer>) request.getAttribute("commentid_and_numberof_like");
            ArrayList<Likecomment> listallvote = (ArrayList<Likecomment>) request.getAttribute("listallvote");
            ArrayList<Likenews> listalllikenewsbynewsid = (ArrayList<Likenews>) request.getAttribute("listalllikenewsbynewsid");
            int total_likenews = (Integer) request.getAttribute("total_likenews");
        %>


        <%if (!username.equals("")) {%>
        <div class="main3">
            <div class="news_box">
                <h1 class="news_title">
                    <small><%=news.getNewstittles()%></small>
                </h1>

                <div class="news_content">


                    <p>  <%=news.getNewscontent()%> </p>

                    <%

                        boolean thumplikenewsup = false;
                        for (int i = 0; i < listalllikenewsbynewsid.size(); i++) {
                            int likeuserid = listalllikenewsbynewsid.get(i).getUserid();
                            int likenewsid = listalllikenewsbynewsid.get(i).getNewsid();
                            if (likeuserid == Integer.parseInt(userid) && likenewsid == news.getNewsID()) {
                                thumplikenewsup = true;
                                break;
                            }
                        }
                    %>
                    <c:set var = "thumplikenewsup" scope = "session" value = "<%=thumplikenewsup%>"/>
                    <i onclick="LikeNewsFunction(this,<%=news.getNewsID()%>,<%=Integer.parseInt(userid)%>)" class= "${thumplikenewsup ?("fas fa-heart fa-2x"):("far fa-heart fa-2x")}"></i>

                    <div id="likenew">${thumplikenewsup ?("Liked"):("Unliked")}</div> 
                    <input class="hiddeninputnumberlike" id="txtlikenewsnumber" type="text" name="" value="<%=total_likenews%>" />
                </div>
                <img class="news_img" src="https://genk.mediacdn.vn/GA8Ko1ApccccccccccccfqZTLfY3/Image/2012/11/1-ee82e.jpg" alt="">
                <div class="detail">
                    <h3 class="news_detail">News Details</h3>
                    <ul>
                        <li>Time: <%=news.getNewsdaterealease()%></li>
                        <li>Create By:<%=news.getUser().getFullname()%> </li>
                        <li>Has <%=listallcommentbynewid.size()%> comment in this news </li>
                    </ul>
                </div>
            </div>
        </div>     
        <script>
            function LikeNewsFunction(thumblikenews, newsid, userid) {
                var numberlikenew = parseInt(document.getElementById('txtlikenewsnumber').value);
                console.log(numberlikenew);
                if (thumblikenews.classList.toggle("far")) {
                    console.log('Ban vua an bo like' + newsid + 'va ' + userid);
                    $.ajax({
                        type: "post",
                        url: "DeleteLikeCommentController", //this is my servlet
                        data: {userid: userid, newsid: newsid}
                    });
                    document.getElementById('likenew').innerHTML = 'Unliked';
                    document.getElementById('txtlikenewsnumber').value = numberlikenew - 1;
                }
                if (thumblikenews.classList.toggle("fas")) {
                    console.log('Ban vua an like' + newsid + 'va ' + userid);
                    $.ajax({
                        type: "post",
                        url: "SaveLikeCommentController", //this is my servlet
                        data: {userid: userid, newsid: newsid}
                    });
                    document.getElementById('likenew').innerHTML = 'Liked';
                    document.getElementById('txtlikenewsnumber').value = numberlikenew + 1;
                }
            }
        </script>


        <% if (!listallcommentbynewid.isEmpty()) {
                for (int i = 0; i < listallcommentbynewid.size(); i++) {
                    int commentid = listallcommentbynewid.get(i).getCommentid();
                    int numberlike = commentid_and_numberof_like.get(commentid).intValue();
                    boolean thumbup = false;
                    for (int j = 0; j < listallvote.size(); j++) {
                        int votecommentid = listallvote.get(j).getCommentid();
                        int voteuserid = listallvote.get(j).getUserid();
                        //ng dang dang nhap tung like roi
                        if (commentid == votecommentid && voteuserid == Integer.parseInt(userid)) {
                            thumbup = true;
                            break;
                        }
                    }
        %>
        <c:set var = "thumpup" scope = "session" value = "<%=thumbup%>"/>
        <%      //ko phai nguoi đang đăng nhập
            if (!username.equals(listallcommentbynewid.get(i).getUser().getUsername())) {
        %>


        <div id="<%=i%>">
            <hr>
            <%=thumbup%>

            <c:out value = "${thumpup}"/>

            <%="nguoi khac" + commentid%>
            <div> <%=listallcommentbynewid.get(i).getUser().getUsername()%></div>
            <div id="content_<%=commentid%>"><%=listallcommentbynewid.get(i).getContent()%> </div> 
            <div> <%= "At: " + listallcommentbynewid.get(i).getDatetime()%></div>  
            <i onclick="LikeCommentFunction(this,<%=commentid%>,<%=userid%>)" class= "${thumpup ?("fas fa-heart fa-3x"):("far fa-heart fa-3x")}"></i>
            <div id="like_<%=commentid%>">${thumpup ?("Liked"):("Unliked")}</div>       
            <input class="hiddeninputnumberlike" id="numberlike_<%=commentid%>" type="text"  value="<%=numberlike%>" />
        </div>
        <% }
            //là người đang đăng nhập sẽ hiển thị xoá,sửa            
            if (username.equals(listallcommentbynewid.get(i).getUser().getUsername())) {%> 
        <div id="<%=i%>">          
            <hr>
            <div>
                <div>  <%= listallcommentbynewid.get(i).getUser().getUsername()%></div>
                <%=thumbup%>
                <%="tao da" + commentid%>
                <div  id="content_<%=commentid%>">   
                    <%=listallcommentbynewid.get(i).getContent()%> 
                </div>
                <input class="hidden" id="txtedit_<%=commentid%>" type="text" name="commentcontentedit" value="<%=listallcommentbynewid.get(i).getContent()%>" />
                <div> <%= "At: " + listallcommentbynewid.get(i).getDatetime()%></div>

                <i onclick="LikeCommentFunction(this,<%=commentid%>,<%=userid%>)" class= "${thumpup ?("fas fa-heart fa-3x"):("far fa-heart fa-3x")}"></i>
                <div id="like_<%=commentid%>">${thumpup ?("Liked"):("Unliked")}</div> 
                <input class="hiddeninputnumberlike" id="numberlike_<%=commentid%>" type="text"  value="<%=numberlike%>" />
                <form>            

                    <input type="hidden" name="commentid" value="<%=commentid%>" />
                    <input  type="hidden" name="newsid" value="<%=news.getNewsID()%>" />                      
                </form>         
                <table>
                    <tr> 
                        <td><input id="save_<%=commentid%>" type="submit" name ="save" onclick="savecomment(<%=commentid%>);" value="Save"  /></td>
                        <td>  <input id="cancel_<%=commentid%>" type="submit" name ="cancel" onclick="cancel(<%=commentid%>)" value="Cancel" /></td>
                    </tr>
                    <tr>
                        <td><input id="edit_<%=commentid%>"  type="submit" name ="Edit" value="Edit" onclick="edit(<%=commentid%>);" />    </td>     
                        <td><input id="delete_<%=commentid%>" type="submit" name="Delete" value="Deleteofuser" onclick="btndelete(<%=i%>,<%=commentid%>,<%=news.getNewsID()%>);"/></td>
                    </tr>
                </table>
            </div>
            <% } else if (roleid.equals("1")) { // la admin thi co the xoa

            %>
            <input id="delete_<%=commentid%>" type="submit" name="Delete" value="deletead_<%=commentid%>" onclick="btndelete(<%=i%>,<%=commentid%>,<%=news.getNewsID()%>);"/>

            <% }%>

            <script>
                var checkedit = 0;
                setSaveButtonStatus(<%=commentid%>, 'hidden');
                setCancelButtonStatus(<%=commentid%>, 'hidden');
                //   setTxteditStatus(<%=commentid%>, 'hidden');

                $('#txtedit_<%=commentid%>').keyup(function () {
                    // Get the Login Name value and trim it
                    var name = $('#txtedit_<%=commentid%>').val();
                    console.log(name);
                    // Check if empty of not
                    if (name.length < 1) {
                        $("#save_<%=commentid%>").attr("disabled", true);
                    } else {
                        $("#save_<%=commentid%>").attr("disabled", false);
                    }
                });
                function LikeCommentFunction(thumb, commentid, userid) {

                    var numberlike = parseInt(document.getElementById('numberlike_' + commentid).value);
                    if (thumb.classList.toggle("far")) {
                        console.log('Ban vua an bo like' + commentid + 'va ' + userid + "numberlike" + numberlike);
                        $.ajax({
                            type: "post",
                            url: "DeleteLikeCommentController", //this is my servlet
                            data: {userid: userid, commentid: commentid}
                        });
                        console.log(numberlike);
                        document.getElementById('numberlike_' + commentid).value = numberlike - 1;
                        document.getElementById('like_' + commentid).innerHTML = 'unlike';
                    }
                    if (thumb.classList.toggle("fas")) {
                        console.log('Ban vua an like' + commentid + 'va ' + userid + "numberlike" + numberlike);
                        $.ajax({
                            type: "post",
                            url: "SaveLikeCommentController", //this is my servlet
                            data: {userid: userid, commentid: commentid}
                        });
                        console.log(numberlike);
                        document.getElementById('numberlike_' + commentid).value = numberlike + 1;
                        document.getElementById('like_' + commentid).innerHTML = 'Liked';
                    }
                }


                function edit(commentid) {
                    if (checkedit === 0) {
                        checkedit = 1;
                        console.log(commentid + " can edit");
                        document.getElementById("txtedit_" + commentid).className = "show";

                        setDeleteButtonStatus(commentid, "hidden");
                        // setTxteditStatus(commentid, "visible");
                        setSaveButtonStatus(commentid, 'visible');
                        setCancelButtonStatus(commentid, "visible");
                        setEditButtonStatus(commentid, "hidden");
                        document.getElementById('content_' + commentid).style.visibility = 'hidden';
                    }
                }
                function btndelete(divpositiontodelete, commentid, newsid) {
                    setDeleteButtonStatus(commentid, "hidden");
                    console.log("xoa div nao: " + divpositiontodelete + " comentid: " + commentid + " newsid " + newsid);
                    $.ajax({
                        type: "post",
                        url: "DeleteCommentServlet", //this is my servlet
                        data: {newsid: newsid, commentid: commentid}
                    });
                    var divdelete = document.getElementById(divpositiontodelete);
                    divdelete.remove();

                }

                function setSaveButtonStatus(btn_position, status) {
                    document.getElementById('save_' + btn_position).style.visibility = status;
                }
                function setCancelButtonStatus(btn_position, status) {
                    document.getElementById('cancel_' + btn_position).style.visibility = status;
                }
                function setTxteditStatus(btn_position, status) {
                    document.getElementById("txtedit_" + btn_position).style.visibility = status;
                }
                function setDeleteButtonStatus(btn_position, status) {
                    document.getElementById('delete_' + btn_position).style.visibility = status;
                }
                function setEditButtonStatus(btn_position, status) {
                    document.getElementById('edit_' + btn_position).style.visibility = status;
                }
                function cancel(commentid) {
                    document.getElementById("txtedit_" + commentid).className = "hidden";
                    setDeleteButtonStatus(commentid, 'visible');
                    //  setTxteditStatus(commentid, 'hidden');
                    setSaveButtonStatus(commentid, 'hidden');
                    setCancelButtonStatus(commentid, "hidden");
                    setEditButtonStatus(commentid, 'visible');
                    //  document.getElementById("txtedit_" + commentid).value= content;
                    document.getElementById('content_' + commentid).style.visibility = 'visible';
                    checkedit = 0;
                }
                function savecomment(commentid) {
                    document.getElementById("txtedit_" + commentid).className = "hidden";
                    setSaveButtonStatus(commentid, "hidden");
                    setDeleteButtonStatus(commentid, "visible");
                    //  setTxteditStatus(commentid, "hidden");
                    setCancelButtonStatus(commentid, "hidden");
                    setEditButtonStatus(commentid, "visible");
                    var txt_edit_content = document.getElementById("txtedit_" + commentid).value;
                    document.getElementById('content_' + commentid).innerHTML = txt_edit_content;
                    document.getElementById('content_' + commentid).style.visibility = 'visible';
                    console.log(txt_edit_content);
                    $.ajax({
                        type: "post",
                        url: "DeleteCommentServlet", //this is my servlet
                        data: {commentcontentedit: txt_edit_content, commentid: commentid},
                        success: function (msg) {
                            $('#output').append(msg);
                        }
                    });
                    checkedit = 0;
                }

            </script>
        </div>
        <!--check nguoi dang dang nhap co nhung comment nao -->

        <%  }
        } else { //chua co comment nao

        %>
        <%= "Don't have any comment. let be the first comment!!! "%>
        <%}
        %>

        <div>
            <form  method="POST" action="CommentController">
                <%DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd  HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();
                    String strdate = dtf.format(now);
                %>
                <input type="hidden" name="strdate" value="<%=strdate%>" />
                <input type="hidden" name="newsid" value="<%=news.getNewsID()%> " />
                <tr><textarea id="txtsavedb" width="500" name="commentcontent"></textarea></tr>
                <input type="submit" id="postcomment" name="postodb" value="Post comment" />       
            </form>
        </div>

        <script>
            $('#txtsavedb').keyup(function () {
                // Get the Login Name value and trim it
                var name = $('#txtsavedb').val();
                console.log(name);
                // Check if empty of not
                if (name.length < 1) {
                    console.log(' <1');
                    $('#postcomment').attr("disabled", true);
                } else {
                    $('#postcomment').attr("disabled", false);
                }
            });

        </script>

        <%} else {  // trang hien thi cua guest %>
        <div class="main3">
            <div class="news_box">
                <h1 class="news_title">
                    <small><%=news.getNewstittles()%></small>
                </h1>

                <div class="news_content">


                    <p>  <%=news.getNewscontent()%> </p>

                    <%
                        boolean thumplikenewsup = false;
                        if (listalllikenewsbynewsid.size() > 0) {
                            thumplikenewsup = true;
                        }
                    %>
                    <c:set var = "thumplikenewsup" scope = "session" value = "<%=thumplikenewsup%>"/>
                    <i  class= "${thumplikenewsup ?("fas fa-heart fa-2x"):("far fa-heart fa-2x")}"></i>            
                    <input class="hiddeninputnumberlike"  type="text" name="" value="<%=total_likenews%>" />
                    
                    <img class="news_img" src="https://genk.mediacdn.vn/GA8Ko1ApccccccccccccfqZTLfY3/Image/2012/11/1-ee82e.jpg" alt="">
                    <div class="detail">
                        <h3 class="news_detail">News Details</h3>
                        <ul>
                            <li>Time: <%=news.getNewsdaterealease()%></li>
                            <li>Create By:<%=news.getUser().getFullname()%> </li>
                            <li>Has <%=listallcommentbynewid.size()%> comment in this news </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>             
        <% if (!listallcommentbynewid.isEmpty()) {
                for (int i = 0; i < listallcommentbynewid.size(); i++) {
                    int commentid = listallcommentbynewid.get(i).getCommentid();
                    int numberlike = commentid_and_numberof_like.get(commentid).intValue();
                    boolean thumbup = false;

                    //ng dang dang nhap tung like roi
                    if (numberlike > 0) {
                        thumbup = true;
                    }

        %>
        <c:set var = "thumpup" scope = "session" value = "<%=thumbup%>"/>   
        <div>
            <hr>          
            <c:out value = "${thumpup}"/>
            <div> <%=listallcommentbynewid.get(i).getUser().getUsername()%></div>
            <div><%=listallcommentbynewid.get(i).getContent()%> </div> 
            <div> <%= "At: " + listallcommentbynewid.get(i).getDatetime()%></div>  
            <i  class= "${thumpup ?("fas fa-heart fa-2x"):("far fa-heart fa-2x")}"></i>             
            <input class="hiddeninputnumberlike"  type="text"  value="<%=numberlike%>" />
        </div>
        <%} //hien thi tung comment
                } //neu mang comment > 0
            } // la guest hay user 
        %>
        <%@include file="footer.jsp" %>  

    </body>
</html>

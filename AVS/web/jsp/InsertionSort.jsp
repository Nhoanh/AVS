<%-- 
    Document   : InsertionSort
    Created on : Feb 24, 2020, 11:09:50 PM
    Author     : Quangnhse05858
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Algorithm compare</title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script type="text/javascript" src="../js/InsertionSort.js"></script>

    </head>

    <body onload ="init();">
        <h1>Hello ! InsertionSort </h1>  
        <progress id="progressStep" value="1"  max="100" > 0 </progress>
        <p>Step</p>
        <input id="slideStep" type="range" oninput="chooseStep();" max="0" min="0" value="1">
        <div id="txtStepcount" style="float: contour"></div>
        <input type="submit" onclick=" init();" value="Restart" />    
        <input id="PauseOrCon" type="submit" onclick="resume();" value="Pause" />
        <input id="btnPrev" type="submit" onclick="back();" value="<" />
        <input id="btnNext" type="submit" onclick="next();" value=">" />
        <input id="txtElement" onkeydown="isNumberKey(event);" type="text" name="name" value="" />
        <input type="submit" onclick="inputByUser();" value="Nhập data" />
        <input id="btnShuffle" type="submit" onclick="shuffle();" value="Shuffle" />
        <canvas id="canvasAnimation" width="700" height="50" style="border:1px solid #000000;"></canvas>
        <canvas id="canvasGraph" width="35" height="230"  style="border:2px solid #000000;"></canvas>
        <p>Speed</p>
        <input id="rangebar" type="range" oninput="changeSpeed();" max="10" min="1" value="1">    
        <script type="text/javascript" src="InsertionSort.js"></script>

        <div>            
            <table>        
                <tr id="line_1" > <td>  for (int j = 1; j < n; j++) {  </td></tr>
                <tr id="line_2"><td> int key = array[j];  </td></tr>
                <tr id="line_3"><td>  int i = j-1; </td> </tr>
                <tr id="line_4"><td> while ( (i > -1) && ( array [i] > key ) ) {</td></tr>  
                <tr id="line_5"> <td>    array [i+1] = array [i];  </td></tr>
                <tr id="line_6"> <td>     i--;  </td></tr>
                <tr id="line_7"><td>  }  </td></tr>
                <tr id="line_8"><td>  array[i+1] = key;  </td></tr>
                <tr id="line_9"> <td>      }        </td> </tr>
            </table>
        </div>
        <jsp:include page="./noteGraph.jsp" />
    </body>      

</html>

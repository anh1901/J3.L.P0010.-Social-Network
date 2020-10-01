<%-- 
    Document   : index
    Created on : Sep 17, 2020, 4:25:49 PM
    Author     : DELL
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="hide-sidebar ls-bottom-footer" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="SoMi">
        <meta name="author" content="Anh">
        <title>SoMi</title>
        <link href="css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
        <link href="css/app.css" rel="stylesheet">
        <style>
            .alert {
                position: relative;
                top: 60px;
                background-color: #f44336;
                color: white;
            }

            .closebtn {
                margin-left: 15px;
                color: white;
                font-weight: bold;
                float: right;
                font-size: 22px;
                line-height: 20px;
                cursor: pointer;
                transition: 0.3s;
            }

            .closebtn:hover {
                color: black;
            }
        </style>
    </head>
    <body class="login" onload="noBack();"  onpageshow="if (event.persisted) noBack();" onUnload="" style="width:100%;">
        <br>
        <c:if test="${not empty ERROR}">
            <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                <strong>${ERROR}</strong>
            </div>
        </c:if>
        <div id="content">
            <c:import url="LoginForm.jsp"/>
            <!-- Sign Up Form-->
            <c:import url="RegisterForm.jsp"/>
        </div>
        <c:import url="Footer.jsp"/>
        <script>
            var close = document.getElementsByClassName("closebtn");
            var i;
            for (i = 0; i < close.length; i++) {
                close[i].onclick = function () {
                    var div = this.parentElement;
                    div.style.opacity = "0";
                    setTimeout(function () {
                        div.style.display = "none";
                    }, 600);
                }
            }
        </script>
    </body>
</html>


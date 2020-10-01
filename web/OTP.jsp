<%-- 
    Document   : OTP
    Created on : Sep 18, 2020, 8:04:07 AM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="hide-sidebar ls-bottom-footer" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="SoMi">
        <meta name="author" content="Anh">
        <title>OTP Verification</title>
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
    <body class="login">
        <c:if test="${not empty OTPERROR}">
            <div class="alert">
                <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                <strong>${OTPERROR}</strong>
            </div>
        </c:if>
        <div id="content">
            <div class="navbar navbar-main navbar-primary navbar-fixed-top" role="navigation">
                <div class="container">
                    <div class="navbar-header">
                        <strong><a class="navbar-brand" href="Index.html">SoMi</a></strong>
                    </div>
                    <div class="collapse navbar-collapse" id="main-nav">
                        <ul style="padding:10px;" class="nav navbar-nav  navbar-right ">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="lock-container">
                    <h1>Just one more step.</h1>
                    <h4>We had send the OTP to your email.</h4>
                    <div class="panel panel-default text-center">
                        <div class="panel-body">
                            <form id='OTP' action='OTPServlet' method='POST'
                                  accept-charset='UTF-8'>
                                <input required class="form-control" type="text" name='otpCode' id='otp' maxlength="8" placeholder="Enter your OTP... " autocomplete="off">
                                <c:if test="${not empty otpError}">
                                    <p style="color:red">${otpError}</p>
                                </c:if>
                                <input style="background-color: #4CAF50" type="submit" value="Verify OTP" name="button"> 
                                <input type="hidden" name="userEmail" value="${param.userEmail}"/>
                                <input type="hidden" name="userPassword" value="${param.userPassword}"/>
                                <i class="fa fa-fw fa-unlock-alt"></i>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>>
    </body>
    <footer class="footer">
        <strong>SoMi</strong> v1.0.0 &copy; Copyright 2020
    </footer>
    <script type="text/javascript">
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
        window.history.forward();
        function noBack()
        {
            window.history.forward();
        }
    </script>
</html>

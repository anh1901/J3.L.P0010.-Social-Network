<%-- 
    Document   : headingBeforeLoggedIn
    Created on : Sep 26, 2020, 1:10:31 PM
    Author     : DELL
--%>
<%-- 
    Document   : headerAfterLoggedIn
    Created on : Sep 23, 2020, 6:36:40 PM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="hide-sidebar ls-bottom-footer" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SoMi Homepage</title>
        <link href="css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
        <link href="css/app.css" rel="stylesheet">
        <link href="css/stylesheet.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/comments.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/pages/page_log_reg_v1.css">
        <link rel="stylesheet" href="css/pages/font-awesome-min.css">
        <link rel="stylesheet" href="css/pages/page_search_inner_tables.css">
        <link rel="stylesheet" href="css/default.css">
    </head>
    <body style="width:100%;">
        <div class='st-container'>
            <!-- Fixed navbar -->
            <div class='navbar navbar-main navbar-primary navbar-fixed-top' role='navigation'>
                <div class='container'>
                    <div class='navbar-header'>
                        <strong>
                            <a class='navbar-brand' href='HomePageServlet'>Welcome, 
                                <c:choose>
                                    <c:when test="${FullName eq null}">GUEST</c:when>
                                    <c:when test="${FullName ne null}">${FullName}</c:when>
                                </c:choose>
                            </a>
                        </strong>
                    </div>
                    <div class='collapse navbar-collapse' id='collapse'>
                        <form action="SearchPostServlet" method="POST" class="navbar-form navbar-left hidden-xs">
                            <div class="search-2">
                                <div class="input-group">
                                    <span class="input-group-btn">
                                        <input class="btn btn-primary" type="submit" value="Search">
                                    </span>
                                    <input class="form-control form-control-w-200" id='search' name='search' placeholder='Search post by content...' type='text'/>
                                </div>
                            </div>
                        </form>
                        <ul class='nav navbar-nav  navbar-right'>
                            <li class="animated">
                                <a href="index.jsp">Login Now !</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
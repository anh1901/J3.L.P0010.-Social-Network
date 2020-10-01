<%-- 
    Document   : loginForm
    Created on : Sep 23, 2020, 9:25:15 PM
    Author     : DELL
--%>
<div class="navbar navbar-main navbar-primary navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <strong><a class="navbar-brand" href="index.html">SoMi</a></strong>
        </div>
        <div class="collapse navbar-collapse" id="main-nav">
            <ul style="padding:10px;" class="nav navbar-nav  navbar-right ">
                <table border="0" style="border:none">
                    <tr>
                    <form id='login' action='LoginServlet' method='post' accept-charset='UTF-8'>
                        <td style="padding:0 15px 0 15px;">
                            <input type="text" tabindex="1" value="${param.userEmail}" id="userEmail" placeholder="Email" name="userEmail" autocomplete="off" class="form-control" >
                        <c:if test="${not empty emailError}">
                            <p style="color:red">${emailError}</p>
                        </c:if>
                        </td>
                        <td style="padding:0 15px 0 15px;">
                            <input type="password" tabindex="2" id="userPassword" placeholder="Password" name="userPassword" autocomplete="off" class="form-control" >
                        <c:if test="${not empty passwordError}">
                            <p style="color:red">${passwordError}</p>
                        </c:if>
                        </td>
                        <td>
                            <input style="background-color: #4CAF50" type="submit" value="Login" name="button"> 
                            <i class="fa fa-fw fa-unlock-alt"></i>
                        </td>
                    </form>
                    </tr>
                </table>
            </ul>
        </div>
    </div>
</div>
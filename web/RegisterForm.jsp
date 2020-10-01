<%-- 
    Document   : registerForm
    Created on : Sep 23, 2020, 9:26:34 PM
    Author     : DELL
--%>
<div class="container-fluid">
    <div class="lock-container">
        <h1>Connect with other on the network</h1>
        <div class="panel panel-default text-center">
            <div class="panel-body">
                <form id='register' action='RegisterServlet' method='post'
                      accept-charset='UTF-8'>
                    <input required class="form-control" type="text" name='firstName' id='firstName' maxlength="50" placeholder="First Name" autocomplete="off">
                    <input required class="form-control" type="text" name='lastName' id='lastName' maxlength="50" placeholder="Last Name" autocomplete="off">
                    <input required class="form-control" name="userEmail" type="text" placeholder="Email ID" autocomplete="off">
                    <c:if test="${not empty registerEmailError}">
                        <p style="color:red">${registerEmailError}</p>
                    </c:if>
                    <input required class="form-control" name="userPassword" type="password" placeholder="Password" autocomplete="off">
                    <c:if test="${not empty registerPasswordError}">
                        <p style="color:red">${registerPasswordError}</p>
                    </c:if>
                    <input style="background-color: #4CAF50" type="submit" value="Sign up" name="button"> 
                    <i class="fa fa-fw fa-pencil-square-o"></i>
                </form>
            </div>
        </div>
    </div>
</div>
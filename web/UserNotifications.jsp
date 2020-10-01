<%-- 
    Document   : UserNotifications
    Created on : Sep 27, 2020, 3:30:25 PM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="HeaderAfterLoggedIn.jsp"/>
<div class="container content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2 col-sm-6 col-sm-offset-3" style="background-color: #cccccc;">
            </br>
            You have <strong>${notifications.size()}</strong> notifications.</br></br>
            <c:forEach var="notification" items="${notifications}">
                <strong>${notification.email}</strong> had <strong>${notification.type}</strong> on your 
                post on <strong>${notification.date}</strong>.
                <hr>
                <br>
            </c:forEach>
            End of notifications.
        </div>
    </div>
</div>
</body>
<c:import url="Footer.jsp"/>
</html>

<%-- 
    Document   : SearchPost
    Created on : Sep 26, 2020, 1:10:51 PM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:import url="HeaderAfterLoggedIn.jsp"/>
<%--search--%>
</br></br>

<div class="container content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2 col-sm-6 col-sm-offset-3" style="background-color: #cccccc;">
            <strong>${searchResult.size()}</strong> 
            results were found for the search for 
            <strong>${searchValue}</strong>
            <c:forEach var="result" items="${searchResult}">
                <div style="border: black inset medium; padding: 5px 5px 5px 5px; margin-bottom:10px">
                    <div class="detailBox" style="border: black thin solid">
                        <div class="titleBox">
                            <label>Posted by <b>${result.email}</b> 
                                <span class="date sub-text"></br>on ${result.dateTimeOfArticle}</span>
                            </label>
                        </div>
                        <div class="commentBox">
                            <p class="taskDescription">${result.content}</p>
                        </div>
                        <div class="text-center">
                            <a href="PostDetail.jsp?postID=${result.postID}">View detail...</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
<c:import url="Footer.jsp"/>
</html>

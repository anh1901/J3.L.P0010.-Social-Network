<%-- 
    Document   : PostDetail
    Created on : Sep 26, 2020, 1:11:03 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:import url="HeaderAfterLoggedIn.jsp"/>
<%--search--%>
</br></br>

<div class="container content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2 col-sm-6 col-sm-offset-3" style="background-color: #cccccc;">
            <c:forEach var="result" items="${searchResult}">
                <c:if test="${result.postID eq param.postID}">
                    <div style="border: black inset medium; padding: 5px 5px 5px 5px; margin-bottom:10px">
                        <div class="detailBox" style="border: black thin solid">
                            <div class="titleBox">
                                <label>Posted by <b>${result.email}</b> 
                                    <span class="date sub-text"></br>on ${result.dateTimeOfArticle}</span>
                                </label>
                            </div>
                            <div class="commentBox">
                                <p class="taskDescription">${result.content}</p>
                                <c:if test="${result.image ne ''}">
                                    <img src="images/${result.image}" width="100%" height="100%"/>
                                </c:if>
                            </div>
                            <%--Emotions--%>
                            <div class="titleBox" style="border: gray thin inset">
                                <form action="EmotionServlet" method="POST">
                                    <input type="hidden" name="postID" value="${result.postID}">
                                    <input type="hidden" name="numberOfLike" value="${result.numberOfLike}">
                                    <input type="hidden" name="numberOfDislike" value="${result.numberOfDislike}">
                                    <input type="submit" name="button" value="Like"></input>&nbsp&nbsp&nbsp${result.numberOfLike}&nbsp&nbsp&nbsp
                                    <input type="submit" name="button" value="Dislike"></input>&nbsp&nbsp&nbsp${result.numberOfDislike}
                                </form>
                                <jsp:useBean id="userEmotion" class="anh.SoMi.daos.EmotionDAO"/>
                                <c:if test="${userEmotion.checkEmotionStatus(User.email, result.postID) eq 'Liked'}">
                                    <p style="color: green">You liked this post</p>
                                </c:if>
                                <c:if test="${userEmotion.checkEmotionStatus(User.email, result.postID) eq 'Disliked'}">
                                    <p style="color: red">You disliked this post</p>
                                </c:if>
                            </div>      
                            <%--Comment--%>
                            <div class="actionBox">
                                <ul class="commentList">
                                    There is <strong><c:out value="${result.comments.size()}"></c:out></strong> comment(s).
                                    <c:forEach var="comments" items="${result.comments}">
                                        <li style="border-bottom: gray thin solid">
                                            <div class="commentText">
                                                <p class=""><b>${comments.email}</b>
                                                    </br>${comments.content}</p> 
                                                <span class="date sub-text">on ${comments.dateTimeOfComment}</span>
                                            </div>
                                        </li>
                                        <br/>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <form action="CommentServlet" method="POST">
                            <input type="hidden" name="postID" value="${result.postID}">
                            <div class="input-group col-md-12 margin-bottom-0">
                                <input type="text" placeholder="Comment something..." class="form-control" name="comment" required/>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <input class="btn-u pull-right" type="submit" value="Comment" name="button">
                                </div>
                            </div>
                        </form>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>
</body>
<c:import url="Footer.jsp"/>
</html>


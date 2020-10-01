<%-- 
    Document   : homePage
    Created on : Sep 19, 2020, 6:08:05 PM
    Author     : DELL
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
    <c:when test="${User.email eq null}">
        <c:import url="HeaderBeforeLoggedIn.jsp"/>
    </c:when>
    <c:when test="${User.email ne null}">
        <c:import url="HeaderAfterLoggedIn.jsp"/>
    </c:when>
</c:choose>
<%--newfeed--%>
<div class="container content">
    <div class="row">
        <div class="col-md-8 col-md-offset-2 col-sm-6 col-sm-offset-3" style="background-color: #cccccc;">
            <br>
            <form class="reg-page" action="PostServlet" method="POST" enctype="multipart/form-data">
                <div>
                    <h4>Post Something</h4>
                </div>
                <div class="input-group margin-bottom-20">
                    <textarea class="form-control" rows="3" cols="100" placeholder="What on your mind?..." class="textarea"
                              name="userPost" required></textarea>
                </div>
                Attact image:<input type="file" name="image" accept="image/x-png,image/gif,image/jpeg" />
                <div class="row">
                    <div class="col-md-20" style="margin-top: 1%">
                        <button class="btn-u pull-right" type="submit">Post</button>
                    </div>
                </div>
            </form>
            </br>
            <c:forEach var="post" items="${posts}">
                <div style="border: black inset medium; padding: 5px 5px 5px 5px; margin-bottom:10px">
                    <div class="detailBox" style="border: black thin solid">
                        <div class="titleBox">
                            <label>Posted by <b>${post.email}</b> 
                                <span class="date sub-text"></br>on ${post.dateTimeOfArticle}</span>
                            </label>
                            <c:if test="${post.email eq User.email}">
                                <form action="DeletePostServlet">
                                    <input type="hidden" name="postID" value="${post.postID}">
                                    <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete?')" />
                                </form>
                            </c:if>
                        </div>
                        <div class="commentBox">
                            <p class="taskDescription">${post.content}</p>
                            <c:if test="${post.image ne ''}">
                                <img src="images/${post.image}" width="100%" height="100%"/>
                            </c:if>
                        </div>
                        <%--Emotions--%>
                        <div class="titleBox" style="border: gray thin inset">
                            <form action="EmotionServlet" method="POST">
                                <input type="hidden" name="postID" value="${post.postID}">
                                <input type="hidden" name="numberOfLike" value="${post.numberOfLike}">
                                <input type="hidden" name="numberOfDislike" value="${post.numberOfDislike}">
                                <input type="submit" name="button" value="Like"></input>&nbsp&nbsp&nbsp${post.numberOfLike}&nbsp&nbsp&nbsp
                                <input type="submit" name="button" value="Dislike"></input>&nbsp&nbsp&nbsp${post.numberOfDislike}
                            </form>
                            <jsp:useBean id="userEmotion" class="anh.SoMi.daos.EmotionDAO"/>
                            <c:if test="${userEmotion.checkEmotionStatus(User.email, post.postID) eq 'Liked'}">
                                <p style="color: green">You liked this post</p>
                            </c:if>
                            <c:if test="${userEmotion.checkEmotionStatus(User.email, post.postID) eq 'Disliked'}">
                                <p style="color: red">You disliked this post</p>
                            </c:if>
                        </div>      
                        <%--Comment--%>
                        <div class="actionBox">
                            <ul class="commentList">
                                There is <strong><c:out value="${post.comments.size()}"></c:out></strong> comment(s).
                                <c:forEach var="comment" items="${post.comments}">
                                    <li style="border-bottom: gray thin solid">
                                        <div class="commentText">
                                            <p class=""><b>${comment.email}</b>
                                                </br>${comment.content}</p> 
                                            <span class="date sub-text">on ${comment.dateTimeOfComment}</span>
                                        </div>
                                        <c:if test="${comment.email eq User.email}">
                                            <form action="DeleteCommentServlet">
                                                <input type="hidden" name="commentID" value="${comment.commentID}">
                                                <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete?')" />
                                            </form>
                                        </c:if>
                                    </li>
                                    <br/>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <form action="CommentServlet" method="POST">
                        <input type="hidden" name="postID" value="${post.postID}"/>
                        <input type="hidden" name="commentUser" value="${User.email}">
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
            </c:forEach>
            <%--Paging--%>    
            <ul class="pagination pagination-lg">
                <c:if test="${currentPage != 1}">
                    <li class="page-item">
                        <a href="HomePageServlet?page=${currentPage -1 }"><<</a>
                    </li>
                </c:if>
                <c:forEach begin="1" end="${numberOfPage}" var="i">
                    <li class="page-item">
                        <c:choose>
                            <c:when test="${currentPage eq i}">
                                <a>${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="HomePageServlet?page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>
                <c:if test="${currentPage lt numberOfPage}">
                    <li class="page-item">
                        <a href="HomePageServlet?page=${currentPage +1 }">>></a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
</body>
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
<c:import url="Footer.jsp"/>
</html>

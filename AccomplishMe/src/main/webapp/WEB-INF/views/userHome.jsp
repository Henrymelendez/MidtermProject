<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" charset="UTF-8">
<title>User Home</title>

 <%@ include file="../CSSInclude.jsp" %>
</head>
<body>
<main class="container-fluid">
<div class="row">
 <%@ include file="navbar.jsp" %>
</div>
	
	<c:choose>
	<c:when test="${! empty user.userChallenges}">
		<c:if test="${! empty user.currentUserChallenge }">
			<c:set var="userChallenge" value="${user.currentUserChallenge }"></c:set>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:set var="userChallenge" value="${null }"></c:set>
	</c:otherwise>
	</c:choose>
<br><br>
 <div class="row" >
<div class="col-4">
<c:choose>
<c:when test="${! empty userChallenge}">
	<h3>${userChallenge.challenge.name}</h3>
	<p>${userChallenge.challenge.description}</p>
	<h5>Goals:</h5>
	<p>${userChallenge.details}</p>
	<br>
	<br>
	<br>
</c:when>
<c:otherwise>
<h3>No Challenge Selected</h3>
<p> Please visit the challenge section to select a challenge!</p>
</c:otherwise>
</c:choose>
	<h2 class="unImplemented">Friends</h2>
	<p class="unImplemented">Coming soon!</p>
</div>
 <div class="col-4 scroll centerHeading" >
 	<h3>Journal Entries</h3>
 	<c:choose>
 	<c:when test="${! empty userChallenge.challengeLogs}">
	<ul><c:forEach items="${userChallenge.challengeLogs}" var="log" >
		<c:choose>
		<c:when test="${! empty log }">
		<li class="noDot" ><a class="btn btn-primary" href="viewLogById.clc?id=${log.id }">${log.entryDate }</a></li>
		</c:when>
		</c:choose>
	</c:forEach> </ul>
 	</c:when>
 	</c:choose>
 </div>
 <div class="col-4 scroll">
 	<h2 class="unImplemented"><i class="fa fa-users"></i> Friends Feed</h2>
 	<p class="unImplemented">Coming soon!</p>
 </div>

 </div>
 
 	 <div class=row>
 <c:choose>
 <c:when test="${! empty message}">
 <h4 class="message">${message}</h4>
 </c:when>
 </c:choose>
 </div>


</main>
<%@ include file="../JSInclude.jsp" %>
</body>
</html>
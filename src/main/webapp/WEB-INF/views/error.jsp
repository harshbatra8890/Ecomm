<!DOCTYPE html>
<html>
<head>
    <title>Oops! Something Went Wrong</title>
    <link href="${pageContext.request.contextPath}/css/error-style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <h1>Oops! Something Went Wrong</h1>
    <p>We encountered an unexpected error. Please try again later.</p>
    <a href="/" class="button">Go Back to Home Page</a>
    
    <%@include file="message.jsp" %>
    
</body>
</html>
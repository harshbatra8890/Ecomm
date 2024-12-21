<p style="font-weight:bold; text-align:center;">
    <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
        out.println("<span style='color:red;'>" + error + "</span>");
    }
    %>
</p>
 
<p style="font-weight:bold; text-align:center;">
    <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
        out.println("<span style='color:green;'>" + message + "</span>");
    }
    %>
</p>
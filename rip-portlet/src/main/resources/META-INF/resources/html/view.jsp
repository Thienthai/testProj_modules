<%@ include file="../init.jsp" %>

<portlet:renderURL var="toWritePage">
</portlet:renderURL>

<div>
	<aui:form action="<%= toWritePage %>" name="<portlet:namespace />gf">
	<button id="addBut">Add</button>
	</aui:form>
	<table id="customers">
	  <tr>
	    <th>Floor</th>
	    <th>Room</th>
	    <th>Name</th>
	    <th>Host</th>
	    <th>Leave Date</th>
	    <th>Place</th>
	    <th>Show</th>
	  </tr>
	  <tr>
	  <!--
	    <td>3</td>
	    <td>1404</td>
	    <td>Test</td>
	    <td>Test</td>
	    <td>04/04/2020</td>
	    <td>Gantin</td>
	    <td>N</td>
	  -->
	  </tr>
	</table>
	<span id="noResult">No Result</span>
	<hr>
</div>
<script>
	var catUrl = <%= themeDisplay.getURLPortal() + request.getContextPath() %> + "/html/write.jsp";
	jQuery.ajax({
	       url:catUrl,
	       type:"POST",
	       dataType:"json",
	        async:false,
	        cache:false,
	        success:function(data,textStatus, XMLHttpRequest){
	            alert(data);
	        },
	         error:function(data,textStatus, XMLHttpRequest){
	           alert("request failed");
	       }
	});  	
</script>
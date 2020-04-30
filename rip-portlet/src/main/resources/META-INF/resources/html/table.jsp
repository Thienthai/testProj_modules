<%@ include file="../init.jsp" %>
	  <tr>
	    <th>Floor</th>
	    <th>Room</th>
	    <th>Name</th>
	    <th>Host</th>
	    <th>Period</th>
	    <th>Leave Date</th>
	    <th>Place</th>
	    <th>Show</th>
	  </tr>
<%
	  List<ripReservation> entries = (List<ripReservation>) resourceRequest.getAttribute("entries");
		if(entries.size() != 0){
			int number = entries.size();
			for(int i = 0;i<number;i++)
			{
				String myId = Long.toString(entries.get(i).getId());
%>
	<portlet:renderURL var="editPageURL" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
		<portlet:param name="mvcPath" value="/html/edit.jsp"/>
		<portlet:param name="myId" value="<%= Long.toString(entries.get(i).getId()) %>"/>
		<portlet:param name="Floor" value="<%= entries.get(i).getFloor() %>"/>
		<portlet:param name="Room" value="<%= entries.get(i).getRoom() %>"/>
		<portlet:param name="Name" value="<%= entries.get(i).getName() %>"/>
		<portlet:param name="Room_number" value="<%= Integer.toString(entries.get(i).getRoom_number()) %>"/>
		<portlet:param name="Leave_date" value="<%= entries.get(i).getLeave_date() %>"/>
		<portlet:param name="Place" value="<%= entries.get(i).getPlace() %>"/>
		<portlet:param name="Show" value="<%= entries.get(i).getShow() %>"/>
		<portlet:param name="Host" value="<%= entries.get(i).getHost() %>"/>
	</portlet:renderURL>
	  <tr>
	    <td><%= entries.get(i).getFloor() %></td>
	    <td><%= entries.get(i).getRoom() %></td>
	    <td><aui:a id="<%= myId %>" label="<%=entries.get(i).getName()%>" href="javascript:void(0)" onClick="forwardFunc('${entries.get(i).getFloor()}','${entries.get(i).getRoom()}','${entries.get(i).getName()}','${entries.get(i).getHost()}','${entries.get(i).getRoom_number()}','${entries.get(i).getLeave_date()}','${entries.get(i).getPlace()}','${entries.get(i).getShow()}','${entries.get(i).getId()}','${editPageURL}')" /></td>
	    <td><%= entries.get(i).getHost() %></td>
	    <td><%= entries.get(i).getRoom_number() %> days</td>
	    <td><%= entries.get(i).getLeave_date()  %></td>
	    <td><%= entries.get(i).getPlace() %></td>
	    <td><%= entries.get(i).getShow() %></td>
	  </tr>

<%
			}
%>	
			</table>
<%	
		}else{
%>
			</table>
			<span id="noResult">No Result</span>
<%
		}
%>
	  
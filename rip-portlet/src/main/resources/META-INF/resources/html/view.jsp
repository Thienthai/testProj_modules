<%@ include file="../init.jsp" %>

<portlet:renderURL var="secondJspURL" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="mvcPath" value="/html/write.jsp"/>
</portlet:renderURL>

<div>
	<aui:button id="popupButton" value="Add" />
	<table id="customers" style="border-collapse: collapse;">
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
	  List<ripReservation> entries = (List<ripReservation>) renderRequest.getAttribute("entries");
		if(entries != null){
			int number = entries.size();
			for(int i = 0;i<number;i++)
			{
				String myId = Long.toString(entries.get(i).getId());
	  %>
	<portlet:renderURL var="editPageURL" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
		<portlet:param name="mvcPath" value="/html/edit.jsp"/>
		<portlet:param name="Floor" value="<%= entries.get(i).getFloor() %>"/>
		<portlet:param name="Room" value="<%= entries.get(i).getRoom() %>"/>
		<portlet:param name="Name" value="<%= entries.get(i).getName() %>"/>
		<portlet:param name="Room_number" value="<%= Integer.toString(entries.get(i).getRoom_number()) %>"/>
		<portlet:param name="Leave_date" value="<%= entries.get(i).getLeave_date() %>"/>
		<portlet:param name="Place" value="<%= entries.get(i).getFloor() %>"/>
		<portlet:param name="Show" value="<%= entries.get(i).getShow() %>"/>
		<portlet:param name="Host" value="<%= entries.get(i).getHost() %>"/>
	</portlet:renderURL>
	  <tr>
	    <td><%= entries.get(i).getFloor() %></td>
	    <td><%= entries.get(i).getRoom() %></td>
	    <td><aui:a id="<%= myId %>" label="<%=entries.get(i).getName()%>" href="#" onClick="return false;" /></td>
	    <td><%= entries.get(i).getHost() %></td>
	    <td><%= entries.get(i).getRoom_number() %> days</td>
	    <td><%= entries.get(i).getLeave_date()  %></td>
	    <td><%= entries.get(i).getPlace() %></td>
	    <td><%= entries.get(i).getShow() %></td>
	  </tr>
	  <aui:script position="inline" use="aui-base">
		var editpageButton = A.one('#<portlet:namespace /><%=myId%>');
		editpageButton.on('click',
			function() {
				
				Liferay.Util.openWindow(
					{
						dialog: {
							//cssClass: 'aui-popup-example',
							destroyOnHide: true,
							height: 700,
							width: 700
						},
						dialogIframe: {
							//bodyCssClass: 'custom-css-class'
						},
						title: 'Edit Page',
						uri: '<%=editPageURL.toString()%>',
						id: '<portlet:namespace/>dialog2',
						
					}
				);		
				
			}
		);
	  </aui:script>
	  <%
			}
		}else{
			%>
			<span id="noResult">No Result</span>
			<%
		}
	  %>
	</table>
	<hr>
</div>

<!-- AUI Script For IFrame POPUP -->
<aui:script position="inline" use="aui-base">
var popupButton = A.one('#<portlet:namespace />popupButton');
popupButton.on('click',
	function() {
		Liferay.Util.openWindow(
			{
				dialog: {
					//cssClass: 'aui-popup-example',
					destroyOnHide: true,
					height: 600,
					width: 700
				},
				dialogIframe: {
					//bodyCssClass: 'custom-css-class'
				},
				title: 'Room Reservation',
				uri: '<%=secondJspURL.toString()%>',
				id: '<portlet:namespace/>dialog',
				
			}
		);
		
	Liferay.provide(
     window,
     'closePopup',
     function(dialogId) {
             var dialog = Liferay.Util.getWindow(dialogId);


          Liferay.fire('closeWindow', {
                    id:'<portlet:namespace/>dialog'
                           });
                 },['aui-base','liferay-util-window'] );
	}
);

</aui:script>
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
	  %>
	  <tr>
	    <td><%= entries.get(i).getFloor() %></td>
	    <td><%= entries.get(i).getRoom() %></td>
	    <td><aui:a id="editPageButton" href="#" ><%= entries.get(i).getName() %></aui:a></td>
	    <td><%= entries.get(i).getHost() %></td>
	    <td><%= entries.get(i).getRoom_number() %> days</td>
	    <td><%= entries.get(i).getLeave_date()  %></td>
	    <td><%= entries.get(i).getPlace() %></td>
	    <td><%= entries.get(i).getShow() %></td>

	  </tr>
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
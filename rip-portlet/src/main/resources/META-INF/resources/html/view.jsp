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
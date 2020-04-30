<%@page import="com.liferay.portal.kernel.servlet.SessionMessages"%>
<%@ include file="../init.jsp" %>

<portlet:renderURL var="secondJspURL" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
	<portlet:param name="mvcPath" value="/html/write.jsp"/>
</portlet:renderURL>

<portlet:resourceURL var="resourceURL">
</portlet:resourceURL>

<liferay-ui:error key="error" message="You not have permission to view this portlet!!" />

<aui:script position="inline" use="aui-base">

	window.forwardFunc = function(Floor,Room,Name,Host,Room_Number,Date,Place,Show,myId,editPageURL){
		//alert(Floor +" "+Room+" "+Name+" "+ Host+" "+Room_Number+" "+Date+" "+Place+" "+Show+" "+myId+" "+editPageURL)
		var editpageButton = A.one('#<portlet:namespace />myId');
					
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
						uri: editPageURL,
						id: '<portlet:namespace/>dialog2',
						
					}
					
					
					
				);
				
	Liferay.provide(
     window,
     'closePopup',
     function(dialogId) {
             var dialog = Liferay.Util.getWindow(dialogId);


          Liferay.fire('closeWindow', {
                    id:'<portlet:namespace/>dialog2'
                           });
                           
                  console.log("close it") 
                  // call ajax instead
                  
                      AUI().use('aui-io-request', (A) => {   // call ajax block
					        A.io.request('<%=renderResponse.encodeURL(resourceURL.toString())%>', {
					               method: 'post',
					               dataType: 'html',
					               data: {
					               	   <portlet:namespace />mode: 'Render',
					               },
					               on: {
					                   success: function(response) {
					                   		var context = response.details[1].responseText;
					                   		console.log(response);
					                   		document.getElementById('customers').children[0].remove();
					                   		document.getElementById('customers').innerHTML = context;
					                   },
					                   failure: function() {

					                   }
					              }
					        });
					    }); // end ajax block
                         
                 },['aui-base','liferay-util-window'] );		
				
	}
			
</aui:script>
<%-- 	
		Permission Checking start 
--%>
<% 
		String userType = (String) renderRequest.getAttribute("userType");

		if(!userType.equals("Guest")) {
			
%>

<div>
	<aui:button style="float:right" id="popupButton" value="Add" />
	  <script>
	  	console.log("Start create table");
	  </script>
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
	  List<ripReservation> entries = (List<ripReservation>) request.getAttribute("entries");
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
		<portlet:param name="Ns" value="<%= renderResponse.getNamespace()%>" />
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
	  <aui:script position="inline" use="aui-base">
	  	console.log("table run");
		var editpageButton = A.one('a');
		editpageButton.on('click',
			function() {
				forwardFunc('${entries.get(i).getFloor()}','${entries.get(i).getRoom()}','${entries.get(i).getName()}','${entries.get(i).getHost()}','${entries.get(i).getRoom_number()}','${entries.get(i).getLeave_date()}','${entries.get(i).getPlace()}','${entries.get(i).getShow()}','${entries.get(i).getId()}','${editPageURL}')				
			}
		);
	  </aui:script>
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
	<hr>
</div>

<%
		}
%> <%-- Permission Checking end --%>

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
                           
                  console.log("close it") 
                  //window.location.reload();
                  // call ajax instead
                  
                      AUI().use('aui-io-request', (A) => {   // call ajax block
					        A.io.request('<%=renderResponse.encodeURL(resourceURL.toString())%>', {
					               method: 'post',
					               dataType: 'html',
					               data: {
					               	   <portlet:namespace />mode: 'Render',
					               },
					               on: {
					                   success: function(response) {
					                   		var context = response.details[1].responseText;
					                   		console.log(response);
					                   		document.getElementById('customers').children[0].remove();
					                   		document.getElementById('customers').innerHTML = context;
					                   		document.getElementById("noResult").remove()
					                   },
					                   failure: function() {

					                   }
					              }
					        });
					    }); // end ajax block
                         
                 },['aui-base','liferay-util-window'] );
	}
);

</aui:script>
                 

                        
	
<%@ include file="../init.jsp" %>

<%
	String roomNumber = request.getParameter("Room_number");
	String UserName = request.getParameter("Name");
	String HostName = request.getParameter("Host");
	String leaveDate = request.getParameter("Leave_date");
	String placeUser = request.getParameter("Place");
%>

<aui:script use="node, event">
	var selectFloor = A.one('#<portlet:namespace/>selectedFloor');
	selectFloor.on('change',() => {
		var selectRoom = A.one('#<portlet:namespace/>selectRoom');
		console.log(selectFloor.val() == '2');
		if(selectFloor.val() == '2'){
			selectRoom.empty();
			selectRoom.append("<option value='201'>Room 201</option><option value='202'>Room 202</option>");
		}else if(selectFloor.val() == '3'){
			selectRoom.empty();
			selectRoom.append("<option value='301'>Room 301</option><option value='302'>Room 302</option>");
		}else if(selectFloor.val() == '5'){
			selectRoom.empty();
			selectRoom.append("<option value='501'>Room 501</option><option value='502'>Room 502</option><option value='503'>Room 503</option>");
		}else if(selectFloor.val() == '6'){
			selectRoom.empty();
			selectRoom.append("<option value='601'>Room 601</option><option value='602'>Room 602</option><option value='603'>Room 603</option>");
		}else if(selectFloor.val() == '7'){
			selectRoom.empty();
			selectRoom.append("<option value='701'>Room 701</option><option value='702'>Room 702</option><option value='703'>Room 703</option>");
		}else if(selectFloor.val() == 'b1'){
			selectRoom.empty();
			selectRoom.append("<option value='b101'>Room B101</option><option value='b102'>Room B102</option><option value='b103'>Room B103</option>");
		}else if(selectFloor.val() == '2b'){
			selectRoom.empty();
			selectRoom.append("<option value='b201'>Room B201</option><option value='b202'>Room B202</option><option value='b203'>Room B203</option>");
		}
		
	});
</aui:script>
<portlet:actionURL name="editWritePage" var="getAddPage">
</portlet:actionURL>
<portlet:actionURL name="deleteList" var="deleteurl">
	<portlet:param name="mvcPath" value="/html/view.jsp"/>
	<portlet:param name="myId" value="<%= request.getParameter("myId") %>"/>
</portlet:actionURL>

<portlet:actionURL name="testingLink" var="testingURL">
	<portlet:param name="mvcPath" value="/html/view.jsp"/>
</portlet:actionURL>

	<portlet:renderURL var="editPageURL">
	</portlet:renderURL>

<aui:form name="myForm" action="<%= getAddPage %>" >
<table id="addForm" style="width: 90%; padding-left: 25px;">
	<tr>
			<td>
				<aui:input style="display:none" type="text" name="myId" label="" value="<%= request.getParameter("myId") %>"></aui:input>
				<th>Show Enable</th>
			</td>
			<td style="padding: 19px;">
				<aui:input checked="<%= (request.getParameter("Show").equals("Enable")) ? true : false %>" inlineField="true" label="Enable" name="showOption"  type="radio" value="Enable" />
		        <aui:input checked="<%= (request.getParameter("Show").equals("Disable")) ? true : false %>" inlineField="true" label="Disable" name="showOption"  type="radio" value="Disable" />
			</td>
			<td>
				<th>Number</th>
			</td>
			<td style="padding: 19px;">
				<aui:input label="" name="roomNumber" value="<%= roomNumber %>"  type="number" />
			</td>
	</tr>
	<tr>
			<td>
				<th>Floor</th>
			</td>
			<td style="padding: 19px;">
				<aui:select id="selectedFloor" label="" name="selectFloor">
				
					  <% if(request.getParameter("Floor").equals("2")){ %>
					  	<option selected value="2">2nd Floor</option> 
					  <% }else{ %>
					    <option value="2">2nd Floor</option>
					  <%} %>
					  
					  <% if(request.getParameter("Floor").equals("3")){ %>
					  	<option selected value="3">3rd Floor</option>
					  <% }else{ %>
					  	<option value="3">3rd Floor</option>
					  <%} %>					  

					  <% if(request.getParameter("Floor").equals("5")){ %>
					  	 <option selected value="5">5th Floor</option>
					  <% }else{ %>
					  	 <option value="5">5th Floor</option>
					  <%} %>
					  
					  <% if(request.getParameter("Floor").equals("6")){ %>
					  	 <option selected value="6">6th Floor</option>
					  <% }else{ %>
					  	 <option value="6">6th Floor</option>
					  <%} %>
					  
					  <% if(request.getParameter("Floor").equals("7")){ %>
					  	<option selected value="7">7th Floor</option>
					  <% }else{ %>
					  	<option value="7">7th Floor</option>
					  <%} %>
					  
					  <% if(request.getParameter("Floor").equals("b1")){ %>
					  	<option selected value="b1">B1</option>
					  <% }else{ %>
					  	<option value="b1">B1</option>
					  <%} %>
					  
					  <% if(request.getParameter("Floor").equals("2b")){ %>
					  	<option selected value="2b">2B</option>
					  <% }else{ %>
					  	<option value="2b">2B</option>
					  <%} %>					  					  				  					  					  
				</aui:select>
			</td>
			<td>
				<th>Room</th>
			</td>
			<td style="padding: 19px;">
				<aui:select id="selectRoom" label="" name="selectRoom">
						
					  <% if(request.getParameter("Floor").equals("2")){ %>
					  	<option value='201'>Room 201</option><option value='202'>Room 202</option>
					  <% }%>
					  
					  <% if(request.getParameter("Floor").equals("3")){ %>
					  	<option value='301'>Room 301</option><option value='302'>Room 302</option> 
					  <% }%>
					  
					  <% if(request.getParameter("Floor").equals("5")){ %>
					  	<option value='501'>Room 501</option><option value='502'>Room 502</option><option value='503'>Room 503</option> 
					  <% }%>
					  
					  <% if(request.getParameter("Floor").equals("6")){ %>
					  	<option value='601'>Room 601</option><option value='602'>Room 602</option><option value='603'>Room 603</option>
					  <% }%>
					  
					  <% if(request.getParameter("Floor").equals("7")){ %>
					  	<option value='701'>Room 701</option><option value='702'>Room 702</option><option value='703'>Room 703</option> 
					  <% }%>
					  
					  <% if(request.getParameter("Floor").equals("b1")){ %>
					  	<option value='b101'>Room B101</option><option value='b102'>Room B102</option><option value='b103'>Room B103</option>
					  <% }%>
					  
					  <% if(request.getParameter("Floor").equals("2b")){ %>
					  	<option value='b201'>Room B201</option><option value='b202'>Room B202</option><option value='b203'>Room B203</option>
					  <% }%>
				</aui:select>
				<aui:script use="node">
					var optionList = A.one('#<portlet:namespace/>selectRoom')._node.options;
					for(var i = 0; i < optionList.length; i++){
					    console.log(optionList[i].value);
					    if(optionList[i].value == <%= request.getParameter("Room") %>){
					    	console.log("check true: " + optionList[i].value + " " + <%= request.getParameter("Room") %>);
					    	optionList[i].setAttribute('selected','true');
					    }
					}
				</aui:script>
			</td>
	</tr>
	<tr>
		<td>
			<th>Name</th>
		</td>
		<td style="padding: 19px;">
			<aui:input value="<%= UserName  %>" label="" name="UserName" type="text" />
		</td>
		<td>
			<th>Host</th>
		</td>
		<td style="padding: 19px;">
			<aui:input label="" value="<%= HostName %>" name="HostName" type="text" />
		</td>
	</tr>
	<tr>
		<td>
			<th>Leave Date</th>
		</td>
		<td style="padding: 19px;">
			<aui:input readonly="true" value="<%= leaveDate %>" id = "datePic" label="" name="leaveDate" type="text" style="float: left;width: 133px;margin-right: 18px;color: black;cursor: text;" />
			<i id="datePic" style="cursor:pointer" class="icon-calendar icon-white"></i>
		</td>
	</tr>
	<tr>
		<td>
			<th>Place</th>
		</td>
		<td style="padding: 19px;">
			<aui:input label="" value="<%= placeUser %>" name="placeUser" type="text" />
		</td>
	</tr>
</table>
<aui:button type="Submit" style="background-color: #315cbc;color: white;margin-left: 27px;margin-top: 12px;margin-bottom: 10px;" id="submitButton" value="Update" />
<aui:button onClick="<%= deleteurl.toString() %>" style="margin-left: 12px;margin-top: 12px;margin-bottom: 10px;background-color: #ea6c6c;color: white;" id="deleteButton" value="Delete"/>
<aui:button style="margin-left: 12px;margin-top: 12px;margin-bottom: 10px;" id="cancelButton" value="Cancel"/>
<aui:button onCLick="testFunc()" style="margin-left: 12px;margin-top: 12px;margin-bottom: 10px;" id="testButton" value="Test"/>
<script>
	function testFunc(){
		 location.replace("<%= testingURL %>");
		 Liferay.Util.getOpener().closePopup('<portlet:namespace/>dialog');
	}
	
</script>
</aui:form>

<aui:script use="node, event">
YUI().use(
  'aui-datepicker',
  (Y) => {
    new Y.DatePicker(
      {
        trigger: '#datePic',
        popover: {
          zIndex: 1
        },
        on: {
          selectionChange: function(event) {
            console.log(event.newSelection);
            var day = event.newSelection[0].toString().substr(8,2);
            var month = event.newSelection[0].toString().substr(4,3);
            var year = event.newSelection[0].toString().substr(11,4);
            
            if(month == "Jan"){
            	month = "01"
            }else if(month == "Feb"){
            	month = "02"
            }else if(month == "Mar"){
            	month = "03"
            }else if(month == "Apr"){
            	month = "04"
            }else if(month == "May"){
            	month = "05"
            }else if(month == "Jun"){
            	month = "06"
            }else if(month == "Jul"){
            	month = "07"
            }else if(month == "Aug"){
            	month = "08"
            }else if(month == "Sep"){
            	month = "09"
            }else if(month == "Oct"){
            	month = "10"
            }else if(month == "Nov"){
            	month = "11"
            }else if(month == "Dec"){
            	month = "12"
            }
            
            console.log(day + "/" + month + "/" + year);
            var dateInput = A.one('#<portlet:namespace/>datePic');
            console.log(dateInput.val());
            dateInput.set('value', day + "/" + month + "/" + year);
          }
        }
      }
    );
  }
);

A.one('#<portlet:namespace/>cancelButton').on('click', function(event) {
    Liferay.Util.getOpener().closePopup('<portlet:namespace/>dialog');
});


</aui:script>




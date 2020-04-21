<%@ include file="../init.jsp" %>
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
<portlet:actionURL name="addWritePage" var="getAddPage"></portlet:actionURL>

<aui:form action="<%= getAddPage %>">
<table id="addForm" style="width: 90%; padding-left: 25px;">
	<tr>
			<td>
				<th>Show Enable</th>
			</td>
			<td style="padding: 19px;">
				<aui:input inlineField="true" label="Enable" name="showOption"  type="radio" value="Enable" />
		        <aui:input inlineField="true" label="Disable" name="showOption"  type="radio" value="Disable" />
			</td>
			<td>
				<th>Number</th>
			</td>
			<td style="padding: 19px;">
				<aui:input label="" name="roomNumber"  type="number" value="1" />
			</td>
	</tr>
	<tr>
			<td>
				<th>Floor</th>
			</td>
			<td style="padding: 19px;">
				<aui:select id="selectedFloor" label="" name="selectFloor">
					  <option value="2">2nd Floor</option>
					  <option value="3">3rd Floor</option>
					  <option value="5">5th Floor</option>
					  <option value="6">6th Floor</option>
					  <option value="7">7th Floor</option>
					  <option value="b1">B1</option>
					  <option value="2b">2B</option>
				</aui:select>
			</td>
			<td>
				<th>Room</th>
			</td>
			<td style="padding: 19px;">
				<aui:select id="selectRoom" label="" name="selectRoom">
					<option value='201'>Room 201</option>
					<option value='202'>Room 202</option>
				</aui:select>
			</td>
	</tr>
	<tr>
		<td>
			<th>Name</th>
		</td>
		<td style="padding: 19px;">
			<aui:input label="" name="UserName" type="text" />
		</td>
		<td>
			<th>Host</th>
		</td>
		<td style="padding: 19px;">
			<aui:input label="" name="HostName" type="text" />
		</td>
	</tr>
	<tr>
		<td>
			<th>Leave Date</th>
		</td>
		<td style="padding: 19px;">
			<aui:input readonly="true" id = "datePic" label="" name="leaveDate" type="text" style="float: left;width: 133px;margin-right: 18px;color: black;cursor: text;" />
			<i id="datePic" style="cursor:pointer" class="icon-calendar icon-white"></i>
		</td>
	</tr>
	<tr>
		<td>
			<th>Place</th>
		</td>
		<td style="padding: 19px;">
			<aui:input label="" name="placeUser" type="text" />
		</td>
	</tr>
</table>
<aui:button type="Submit" style="background-color: #315cbc;color: white;margin-left: 27px;margin-top: 12px;margin-bottom: 10px;" id="submitButton" value="Submit" />
<aui:button style="margin-left: 12px;margin-top: 12px;margin-bottom: 10px;" id="cancelButton" value="Cancel"/>
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

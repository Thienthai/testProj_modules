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
				
			Liferay.provide(
		     window,
		     'closePopup',
		     function(dialogId) {
		             var dialog = Liferay.Util.getWindow(dialogId);
		
		
		          Liferay.fire('closeWindow', {
		                    id:'<portlet:namespace/>dialog2'
		                           });
		                           

                  		window.location.reload(); 
		                           
		                 },['aui-base','liferay-util-window'] );		
				
			}
		);
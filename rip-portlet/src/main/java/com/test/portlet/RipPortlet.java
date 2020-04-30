package com.test.portlet;

import com.test.constants.RipPortletKeys;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.Role;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.RoleLocalServiceUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.service.model.ripReservation;
import com.service.service.ripReservationLocalService;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.PortletRequestDispatcher;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * @author Ice
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=Mini-Project",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=Rip",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/html/view.jsp",
		"javax.portlet.name=" + RipPortletKeys.RIP,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class RipPortlet extends MVCPortlet {
	private static Log _log = LogFactoryUtil.getLog(RipPortlet.class.getName());
	@Reference
	private ripReservationLocalService _ripLocalService;
	
	public void deleteList(ActionRequest actionRequest,ActionResponse actionResponse) throws NumberFormatException, PortalException {
		
		try {
			_ripLocalService.deleteripReservation(Long.parseLong(ParamUtil.getString(actionRequest, "myId")));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		// TODO Auto-generated method stub
		super.doView(renderRequest, renderResponse);
	}

	
	public void testingLink(ActionRequest actionRequest,ActionResponse actionResponse){
		
		System.out.println("run something");
	}
	
	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		
		PortalUtil pt = new PortalUtil();
		HttpServletRequest httpreq = PortalUtil.getHttpServletRequest(renderRequest);
		
		String userType = "noUserType";

		List<Role> user = RoleLocalServiceUtil.getUserRoles(pt.getUserId(httpreq));
		
		List<Integer> roleList = new ArrayList<Integer>();
		for (Role temp : user) {
			roleList.add((int) temp.getRoleId());
		}
		
		if(roleList.contains(20107)){
			userType = "Admin";
		}else if(roleList.contains(20112)){
			userType = "User";
		}else{
			userType = "Guest";
		}
		
		if(!userType.equals("Admin") && !userType.equals("User")) {
		
			SessionErrors.add(renderRequest, "error");
		}
		
		List<ripReservation> rip = null;
		
		rip = _ripLocalService.getripReservations(0, _ripLocalService.getripReservationsCount());
		
		renderRequest.setAttribute("entries", rip);
		
		renderRequest.setAttribute("userType", userType);
		
		super.render(renderRequest, renderResponse);
	}
	
	public void serveResource(ResourceRequest resourceRequest,ResourceResponse resourceResponse) 
	throws IOException,PortletException {
		_log.info("This is serve resource method....");
		
		String mode = ParamUtil.getString(resourceRequest, "mode");
		
		if(mode.equals("delete")) {
			String string = ParamUtil.getString(resourceRequest, "fm");
			String[] parts = string.split("&");
			String myId = parts[1].substring(parts[1].indexOf("=") + 1);
			
			try {
				_ripLocalService.deleteripReservation(Long.parseLong(myId));
			} catch (NumberFormatException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (PortalException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
		}
		
		if (mode.equals("edit")) {
			
			String string = ParamUtil.getString(resourceRequest, "fm");
			String[] parts = string.split("&");
			String myId = parts[1].substring(parts[1].indexOf("=") + 1);
			String showOption = parts[2].substring(parts[2].indexOf("=") + 1);
			String roomNumber = parts[3].substring(parts[3].indexOf("=") + 1);
			String selectFloor = parts[4].substring(parts[4].indexOf("=") + 1);
			String selectRoom = parts[5].substring(parts[5].indexOf("=") + 1);
			String UserName = parts[6].substring(parts[6].indexOf("=") + 1).replace("%20", " ");
			String HostName = parts[7].substring(parts[7].indexOf("=") + 1).replace("%20", " ");
			String leaveDate = parts[8].substring(parts[8].indexOf("=") + 1).replace("%2F", "/");
			String placeUser = parts[9].substring(parts[9].indexOf("=") + 1).replace("%20", " ");
			
			try {
				ripReservation rip = _ripLocalService.getripReservation(Long.parseLong(myId));
				rip.setShow(showOption);
				rip.setRoom_number(Integer.parseInt(roomNumber));
				rip.setFloor(selectFloor);
				rip.setRoom(selectRoom);
				rip.setName(UserName);
				rip.setHost(HostName);
				rip.setLeave_date(leaveDate);
				rip.setPlace(placeUser);
				_ripLocalService.updateripReservation(rip);
			} catch (NumberFormatException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (PortalException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
		}
		
		if(mode.equals("write")) {
			
			String string = ParamUtil.getString(resourceRequest, "fm");
			String[] parts = string.split("&");
			
			String showOption = parts[1].substring(parts[1].indexOf("=") + 1);
			String roomNumber = parts[2].substring(parts[2].indexOf("=") + 1);
			String selectFloor = parts[3].substring(parts[3].indexOf("=") + 1);
			String selectRoom = parts[4].substring(parts[4].indexOf("=") + 1);
			String UserName = parts[5].substring(parts[5].indexOf("=") + 1).replace("%20", " ");
			String HostName = parts[6].substring(parts[6].indexOf("=") + 1).replace("%20", " ");
			String leaveDate = parts[7].substring(parts[7].indexOf("=") + 1).replace("%2F", "/");
			String placeUser = parts[8].substring(parts[8].indexOf("=") + 1).replace("%20", " ");
			
			ripReservation rip = _ripLocalService.createripReservation(CounterLocalServiceUtil.increment());
			rip.setShow(showOption);
			rip.setRoom_number(Integer.parseInt(roomNumber));
			rip.setFloor(selectFloor);
			rip.setRoom(selectRoom);
			rip.setName(UserName);
			rip.setHost(HostName);
			rip.setLeave_date(leaveDate);
			rip.setPlace(placeUser);
			
			
			
			try {
				_ripLocalService.addripReservation(rip);
			} catch (Exception e) {
				e.printStackTrace();
				SessionErrors.add(resourceRequest, "error-key");
				SessionMessages.add(resourceRequest, PortalUtil.getPortletId(resourceRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
			}
			
		}
		
		if(mode.equals("Render")) {
			
			List<ripReservation> rip = null;
			
			rip = _ripLocalService.getripReservations(0, _ripLocalService.getripReservationsCount());
			
			resourceRequest.setAttribute("entries", rip);

			PortletRequestDispatcher dispatcher = resourceRequest.getPortletSession().getPortletContext().getRequestDispatcher("/html/table.jsp");
			resourceRequest.getPortletSession().getPortletContext().setAttribute("entries", rip);
			resourceRequest.getPortletSession().getPortletContext().setAttribute("test", rip);
			dispatcher.include(resourceRequest, resourceResponse);
			
		}
		
		super.serveResource(resourceRequest, resourceResponse);
	}
	
}
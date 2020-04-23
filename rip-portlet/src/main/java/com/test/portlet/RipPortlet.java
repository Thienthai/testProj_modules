package com.test.portlet;

import com.test.constants.RipPortletKeys;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
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
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

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
	
	public void testingLink(ActionRequest actionRequest,ActionResponse actionResponse){
		
		System.out.println("run something");
	}
	
	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		
		System.out.println(ParamUtil.getString(renderRequest, "floor"));
		
		List<ripReservation> rip = null;
		
		rip = _ripLocalService.getripReservations(0, _ripLocalService.getripReservationsCount());
		
		renderRequest.setAttribute("entries", rip);
		
		super.render(renderRequest, renderResponse);
	}
	
	public void editWritePage(ActionRequest actionRequest,ActionResponse actionResponse) throws NumberFormatException, PortalException {
		
		String myId = ParamUtil.getString(actionRequest, "myId");
		String showOption = ParamUtil.getString(actionRequest, "showOption");
		String roomNumber = ParamUtil.getString(actionRequest, "roomNumber");
		String selectFloor = ParamUtil.getString(actionRequest, "selectFloor");
		String selectRoom = ParamUtil.getString(actionRequest, "selectRoom");
		String UserName =ParamUtil.getString(actionRequest, "UserName");
		String HostName =ParamUtil.getString(actionRequest, "HostName");
		String leaveDate =ParamUtil.getString(actionRequest, "leaveDate");
		String placeUser =ParamUtil.getString(actionRequest, "placeUser");
		
		System.out.println("showOption: " + showOption);
		System.out.println("roomNumber: " + roomNumber);
		System.out.println("selectFloor: " + selectFloor);
		System.out.println("selectRoom: " + selectRoom);
		System.out.println("UserName: " + UserName);
		System.out.println("HostName: " + HostName);
		System.out.println("leaveDate: " + leaveDate);
		System.out.println("placeUser: " + placeUser);
		
		
		ripReservation rip = _ripLocalService.getripReservation(Long.parseLong(myId));
		rip.setShow(showOption);
		rip.setRoom_number(Integer.parseInt(roomNumber));
		rip.setFloor(selectFloor);
		rip.setRoom(selectRoom);
		rip.setName(UserName);
		rip.setHost(HostName);
		rip.setLeave_date(leaveDate);
		rip.setPlace(placeUser);
		
		try {
			_ripLocalService.updateripReservation(rip);
		} catch (Exception e) {
			e.printStackTrace();
			SessionErrors.add(actionRequest, "error-key");
			SessionMessages.add(actionRequest, PortalUtil.getPortletId(actionRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
		}
		
	}

	public void addWritePage(ActionRequest actionRequest,ActionResponse actionResponse) {

		String showOption = ParamUtil.getString(actionRequest, "showOption");
		String roomNumber = ParamUtil.getString(actionRequest, "roomNumber");
		String selectFloor = ParamUtil.getString(actionRequest, "selectFloor");
		String selectRoom = ParamUtil.getString(actionRequest, "selectRoom");
		String UserName =ParamUtil.getString(actionRequest, "UserName");
		String HostName =ParamUtil.getString(actionRequest, "HostName");
		String leaveDate =ParamUtil.getString(actionRequest, "leaveDate");
		String placeUser =ParamUtil.getString(actionRequest, "placeUser");
		
		System.out.println("showOption: " + showOption);
		System.out.println("roomNumber: " + roomNumber);
		System.out.println("selectFloor: " + selectFloor);
		System.out.println("selectRoom: " + selectRoom);
		System.out.println("UserName: " + UserName);
		System.out.println("HostName: " + HostName);
		System.out.println("leaveDate: " + leaveDate);
		System.out.println("placeUser: " + placeUser);
		
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
			actionResponse.sendRedirect("/html/edit.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			SessionErrors.add(actionRequest, "error-key");
			SessionMessages.add(actionRequest, PortalUtil.getPortletId(actionRequest) + SessionMessages.KEY_SUFFIX_HIDE_DEFAULT_ERROR_MESSAGE);
		}
		
		
	}
	
	public void serveResource(ResourceRequest resourceRequest,ResourceResponse resourceResponse) 
	throws IOException,PortletException {
			System.out.println("Inisde serve resource------>>>");
			resourceResponse.setContentType("text/html");
			PrintWriter out = resourceResponse.getWriter();
			out.println("AUI Ajax call is performed");
			out.flush();
			super.serveResource(resourceRequest, resourceResponse);
			super.serveResource(resourceRequest, resourceResponse);
	}
}
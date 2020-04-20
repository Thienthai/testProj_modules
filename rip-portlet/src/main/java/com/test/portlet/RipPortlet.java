package com.test.portlet;

import com.test.constants.RipPortletKeys;

import java.io.IOException;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.util.ParamUtil;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

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
		
	}
	
	public void serveResource(ResourceRequest resourceRequest,ResourceResponse resourceResponse) 
	throws IOException,PortletException {
			System.out.println("Inisde serve resource------>>>");
			//super.serveResource(resourceRequest, resourceResponse);
	}
}
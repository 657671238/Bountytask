package servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.request;
import bean.task;
import service.requestService;
import service.taskService;
import service_imp.requestService_imp;
import service_imp.taskService_imp;



@WebServlet("/showTaskServlet")
public class showTaskServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String us = (String) session.getAttribute("username");
		if (us == null) {
			req.getRequestDispatcher("/pleaselogin.jsp").forward(req, resp);
			return;
		}
		String taskId = req.getParameter("taskId");
		int task_Id = Integer.parseInt(taskId);
		//System.out.printf(taskId);
		taskService ts = new taskService_imp();
		boolean ismyTask = ts.isMytask(task_Id, us);
		//此处分开判断是为了在我的任务栏目中避免判断逻辑
		//System.out.println(ismyTask);
		if(ismyTask) {
			
			int taskstate = ts.requesttaskstate(task_Id);
			//任务未被分配，进入任务详情页面
			if(taskstate>=0) {
				req.getRequestDispatcher("showMyTaskServlet").forward(req, resp);
				return;	
			}
			//任务已经发布，不可修改，进入任务进度页面
			else {
				req.getRequestDispatcher("showMypublishTaskServlet").forward(req, resp);
				return;	
			}
		}
		else {
			requestService rs = new requestService_imp();
			request r = new request();
			r.setTaskId(task_Id);
			r.setMyPhone(us);
			boolean hasrequest = rs.isRequest(r);
			//判断用户是否已请求该任务，选择不同的逻辑
			if(hasrequest) {
				//判断已请求该任务后，应判断请求状态，成功与否
				task task = ts.queryone(task_Id);
				
				req.setAttribute("task", task);
				req.getRequestDispatcher("/showOtherRequestTask.jsp").forward(req, resp);
				return;	
			}else {
				task task = ts.queryone(task_Id);
				req.setAttribute("task", task);
				req.getRequestDispatcher("/showOtherTask.jsp").forward(req, resp);
			
			
			}
			
		}
		
	}

}

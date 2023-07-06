

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ArrayNode;
import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;
import org.json.JSONArray;

import com.google.gwt.json.client.JSONObject;
import com.pub.database.QueryBean;

/**
 * Servlet implementation class bug_project_issue_list_json
 */
@WebServlet("/bug_project_issue_list_json")
public class bug_project_issue_list_json extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public bug_project_issue_list_json() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		try {
			

		String project_name = request.getParameter("projectNameDesc");
		Hashtable lhtTableData = null;
		QueryBean gqbnDAO=null;
		gqbnDAO=new QueryBean("BUGDB_WFLOW",true,"utf-8","utf-8");
		
		String lstrSQL = "select SUBSTR(d.app_date, 1, 7) MONTH, count(d.app_date) COUNT,"
						+ "case d.status when 'Z' then 'open' else 'close' end as status"
						+ " from bug_discuss d,bug_project p "
						+ " where d.def_num = p.flow_num and p.wo_name='"+project_name+"' and d.status not in ('D') "
						+ " GROUP BY SUBSTR(d.app_date, 1, 7),case d.status when 'Z' then 'open' else 'close' end   order by  SUBSTR(d.app_date, 1, 7)";
		
		lhtTableData = gqbnDAO.hashtableSQL(lstrSQL);
		if (lhtTableData ==null ) return ;
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNodeFactory nodeFactory = mapper.getNodeFactory();
		
	    //create JSON Object
		ObjectNode dataObject_month = nodeFactory.objectNode();
	    ObjectNode dataObject_open = nodeFactory.objectNode();
	    ObjectNode dataObject_close = nodeFactory.objectNode();
	    
	    //create JSON Array
	    ArrayNode jsonArray_month = nodeFactory.arrayNode();
	    ArrayNode jsonArray_open = nodeFactory.arrayNode();
	    ArrayNode jsonArray_close = nodeFactory.arrayNode();
				
		for (int i = 0; i < lhtTableData.size(); i++) {
			String month = ((Hashtable) lhtTableData.get(String.valueOf(i))).get("MONTH").toString();
			String count = ((Hashtable) lhtTableData.get(String.valueOf(i))).get("COUNT").toString();
			String status =((Hashtable) lhtTableData.get(String.valueOf(i))).get("STATUS").toString();
			if (status.equals("open")) jsonArray_open.add(Integer.valueOf(count)); else jsonArray_open.add(0);
			if (status.equals("close")) jsonArray_close.add(Integer.valueOf(count)); else jsonArray_close.add(0);
			
			jsonArray_month.add(month);
		}
		
		//合併所有 JSON Object
		dataObject_month.put("month", jsonArray_month);
		dataObject_open.put("open", jsonArray_open);
		dataObject_close.put("close", jsonArray_close);

		
		dataObject_month.putAll(dataObject_open);
		dataObject_month.putAll(dataObject_close);
		
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    out.print(dataObject_month.toString());
	    out.flush();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		    out.print("");
		    out.flush();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

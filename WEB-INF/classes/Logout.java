/*
* Licensed to the Apache Software Foundation (ASF) under one or more
* contributor license agreements.  See the NOTICE file distributed with
* this work for additional information regarding copyright ownership.
* The ASF licenses this file to You under the Apache License, Version 2.0
* (the "License"); you may not use this file except in compliance with
* the License.  You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
/* $Id: RequestParamExample.java 1200123 2011-11-10 04:03:27Z kkolinko $
 *
 */

import java.util.*;
import java.awt.*;
import java.io.*;
import javax.servlet.http.Cookie;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import org.mindrot.jbcrypt.BCrypt;
import util.HTMLFilter;

/**
 * Example servlet showing request headers
 *
 * @author James Duncan Davidson <duncan@eng.sun.com>
 */

public class Logout extends HttpServlet {

	private static final int EmailIndex = 0;
	private static final int PasswordIndex = 1;
	private static final long serialVersionUID = 1L;
	private static final String IndexPage = "index.html";
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
        	throws IOException, ServletException
	{
		PrintWriter out = response.getWriter();
		Scanner sc;
		String content;		
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for (int i = 0; i < cookies.length; i++){
				String name = cookies[i].getName();
				String value = cookies[i].getValue();
				if(name.equals("ipAddr")){
					cookies[i].setValue("");
					cookies[i].setPath("/");
					cookies[i].setMaxAge(0);
				}
			}
		}

		if(request.getSession(false) != null){
			request.getSession(false).invalidate();
		}

		content = fileContentsToString(IndexPage);		
		out.println(content);
		return;      
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
        	throws IOException, ServletException
	{
		doGet(request, response);
	}

	// https://stackoverflow.com/questions/12035316/reading-entire-html-file-to-string
	private String fileContentsToString(String fileName){
		StringBuilder contentBuilder = new StringBuilder();
		try {
			final String relativeFolderPath = "/WEB-INF/pagesAndCredentials";
			final String absoluteDiskPath = getServletContext().getRealPath(relativeFolderPath)+'/';
		    BufferedReader in = new BufferedReader(new FileReader(absoluteDiskPath + fileName));
		    String str;
		    while ((str = in.readLine()) != null){
		        contentBuilder.append(str);
		    }
		    in.close();
		} catch (IOException e){ 
			return e.getMessage();
		}
		return contentBuilder.toString();	
	}
}

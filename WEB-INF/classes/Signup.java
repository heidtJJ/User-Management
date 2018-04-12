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

/**
 * Example servlet showing request headers
 *
 * @author James Duncan Davidson <duncan@eng.sun.com>
 */

public class Signup extends HttpServlet {

	private static final int EmailIndex = 0;
	private static final int PasswordIndex = 1;
	private static final long serialVersionUID = 1L;
	private static final String credentialsFileName = "userCredentials.txt";
	private static final String LoggedInPage = "loggedInPage.html";
	private static final String EmailExistsPage = "indexEmailExists.html";
	private static final String BadPasswordPage = "indexBadPassword.html";
	private static final String InvalidEmailPage = "indexEmailInvalid.html";
	private static final String IndexPage = "index.html";

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
        	throws IOException, ServletException
	{
		PrintWriter out = response.getWriter();
		Scanner sc;
		String content;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String passwordRepeat = request.getParameter("password-repeat");
		
		try {
			
			if(request.getSession(false) != null){	
				
				// see if ip address has changed
				Cookie[] cookies = request.getCookies();
				if(cookies != null){
					for (int i = 0; i < cookies.length; i++){
						String name = cookies[i].getName();
						String value = cookies[i].getValue();
						if(name.equals("ipAddr")){
							// if ip address has changed, kill session and cookie
							if(!value.equals(request.getRemoteAddr())){
								request.getSession(false).invalidate();
								cookies[i].setValue("");
								cookies[i].setPath("/");
								cookies[i].setMaxAge(0);
							}
						}
					}
				}
				
				if(request.getSession(false) != null) content = fileContentsToString(LoggedInPage);
				else content = fileContentsToString(IndexPage);
				
				out.println(content);
				return;
			}
			final String relativeFolderPath = "/WEB-INF/pagesAndCredentials";
			final String absoluteDiskPath = getServletContext().getRealPath(relativeFolderPath)+'/';
			sc = new Scanner(new File(absoluteDiskPath + credentialsFileName));

			boolean emailExists = false;
			boolean passwordMatch = password.equals(passwordRepeat);
			boolean empty = email.equals("") || password.equals("") || passwordRepeat.equals("");
			boolean goodPassword = goodPassword(password);
			
			while(sc.hasNextLine()){
				String[] words = sc.nextLine().split(" ");
				
				if(words[EmailIndex].equals(email)){
						emailExists = true;
						break;
				}
			}
			
			// if email does not exist and password matches password repeat -> write credentials to file  
			if(!emailExists && passwordMatch && !empty && goodPassword(password)){
				content = fileContentsToString(LoggedInPage);
			    try {
					Writer writer = new FileWriter(absoluteDiskPath + credentialsFileName, true);
			       	String encodedCredentials = email + " " + BCrypt.hashpw(password, BCrypt.gensalt());
					
					Cookie ipCookie = null;
					if (!request.getParameterMap().containsKey("ipAddr")) {
							ipCookie = new Cookie("ipAddr", request.getRemoteAddr());
							response.addCookie(ipCookie);
					}
					
					writer.write(encodedCredentials+"\n");
					writer.close();
					request.getSession(true);
				} catch (IOException ioe){
					System.err.println("Could not save data.\n");
				}
				catch (Exception e){
					content = fileContentsToString(BadPasswordPage);
				}
			}
			else if (!emailExists && passwordMatch && !empty && !goodPassword(password)){
				content = fileContentsToString(BadPasswordPage);
			}
			else if(emailExists && passwordMatch && !empty){
				content = fileContentsToString(EmailExistsPage);
			}
			else{
				content = fileContentsToString(InvalidEmailPage);
			}
	
		} catch (FileNotFoundException e) {
			out.println("File Not Found");
			e.printStackTrace();
			return;
		}
		catch (Exception e){
    		content = fileContentsToString(BadPasswordPage);// could not decode username or password
		}
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
			String relativeFolderPath = "/WEB-INF/pagesAndCredentials";
			String absoluteDiskPath = getServletContext().getRealPath(relativeFolderPath)+'/';
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
	
	private boolean goodPassword(String password){
        boolean hasLetter = false;
        boolean hasDigit = false;

        if (password.length() >= 8) {
            for (int i = 0; i < password.length(); i++) {
                char x = password.charAt(i);
                if (Character.isLetter(x)) {
                    hasLetter = true;
                }

                else if (Character.isDigit(x)) {
                    hasDigit = true;
                }

                // no need to check further, break the loop
                if(hasLetter && hasDigit){
                    break;
                }
            }
            if (hasLetter && hasDigit) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
	}
	
}

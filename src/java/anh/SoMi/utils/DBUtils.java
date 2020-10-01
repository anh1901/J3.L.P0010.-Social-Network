/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.utils;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class DBUtils implements Serializable{
    final static Logger logger = Logger.getLogger(DBUtils.class.getName());
    
    public static Connection makeConnection() throws NamingException,SQLException{
        logger.info("Connecting to database...");
        Context context=new InitialContext();
        Context tomcatCtx=(Context) context.lookup("java:comp/env");
        DataSource ds=(DataSource) tomcatCtx.lookup("J3.L.P0010.-Social-Network");
        if(ds !=null){
            Connection con=ds.getConnection();
            logger.info("Connected.");
            return con;
        }
        return null;
    }
    
}

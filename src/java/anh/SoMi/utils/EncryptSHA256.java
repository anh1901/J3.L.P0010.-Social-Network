/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.utils;

import java.security.MessageDigest;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class EncryptSHA256 {
    final static Logger logger = Logger.getLogger(EncryptSHA256.class.getName());
    public static String sha256(String base) {
        logger.info("Encrypting the password.");
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            logger.info("Encrypted.");
            return hexString.toString();
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }
}

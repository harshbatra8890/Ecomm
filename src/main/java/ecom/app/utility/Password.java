package ecom.app.utility;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Random;

public class Password {

	public static String generatePwdSalt(int saltLength) {
		// Characters that can be used in the salt
		String saltChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		// Create a random number generator
		Random random = new SecureRandom();

		// Generate a random salt
		StringBuilder salt = new StringBuilder();
		for (int i = 0; i < saltLength; i++) {
		
			int randomIndex = random.nextInt(saltChars.length());			
			salt.append(saltChars.charAt(randomIndex));
		}

		// Print the generated salt
		System.out.println("Generated Salt: " + salt.toString());

		return salt.toString();
	}

	public static String generatePwdHash(String inputString) {
		String strHash = "";
		try {
            // Create a SHA-256 message digest instance
            MessageDigest digest = MessageDigest.getInstance("SHA-256");

            // Calculate the hash of the input string
            byte[] hashBytes = digest.digest(inputString.getBytes(StandardCharsets.UTF_8));

            // Convert the hash bytes to a hexadecimal representation
            strHash = bytesToHex(hashBytes);

            
		} catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
		
		return strHash;
	}
	
	// Helper method to convert bytes to hexadecimal representation
    private static String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder(2 * bytes.length);
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
}

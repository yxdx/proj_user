package tw.proj.Utils;

import java.util.Random;
import java.util.regex.Pattern;

/**
 * 表单校验工具类
 *
 * @author ljc
 * @date 2018/10/11
 */
public class UserUtils {
	public static boolean checkName(String name) {
		//用户名长度不少于4个字符,且不大于12个字符,首字符为字母,仅包含字母 数字 下划线
		String regex = "^[a-zA-Z]\\w{3,11}$";
		return Pattern.compile(regex).matcher(name).matches();
	}

	public static boolean checkPassword(String password) {
		//密码长度不小于6个字符,不大于20个字符,非空格的任意字符
		String regex = "^\\S{6,20}$";
		return Pattern.compile(regex).matcher(password).matches();
	}

	public static boolean checkEmail(String email) {
		//email格式:aaa@bb.ccc
		String regex = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$";
		return Pattern.compile(regex).matcher(email).matches();
	}

	public static boolean checkAll(String name, String password, String email) {
		return checkName(name) && checkPassword(password) && checkEmail(email);
	}

	/**
	 * 生成6位随机数字型验证码
	 */
	public static String generateVerificationCode() {
		return Integer.toString(Math.abs(new Random().nextInt())).substring(0, 6);

	}


	/**
	 * 简单加密
	 */
	private static String toCipherText(String str) {
		char[] chars = new char[str.length()];
		for (int i = 0; i < str.length(); i++) {
			char aChar = (char) (str.charAt(i) + 6);
			chars[i] = aChar;
		}
		return new String(chars);
	}

	/**
	 * 简单解密
	 */
	private static String toPlainText(String str) {
		char[] chars = new char[str.length()];
		for (int i = 0; i < str.length(); i++) {
			char aChar = (char) (str.charAt(i) - 6);
			chars[i] = aChar;
		}
		return new String(chars);
	}

	public static String getCipherText(String email, String passwords) {
		String cipherEmail = toCipherText(email);
		String cipherPasswords = toCipherText(passwords);
		return cipherEmail + "#proj.tw#" + cipherPasswords;
	}

	public static String getEmail(String cipherText) {
		String[] s = cipherText.split("#proj.tw#");

		return toPlainText(s[0]);
	}

	public static String getPasswords(String cipherText) {
		String[] s = cipherText.split("#proj.tw#");
		return toPlainText(s[1]);
	}
}

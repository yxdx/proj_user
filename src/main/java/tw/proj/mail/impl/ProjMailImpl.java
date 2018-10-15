package tw.proj.mail.impl;

import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Component;
import tw.proj.mail.ProjMail;

import javax.mail.*;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

/**
 * 邮件发送类
 *
 * @author ljc
 * @date 2018/10/5
 */
@Component("projMail")
public class ProjMailImpl implements ProjMail {
	/**
	 * 别名
	 */
	private static String alias;
	/**
	 * 账户
	 */
	private static String account;
	/**
	 * 密码
	 */
	private static String pass;
	/**
	 * 服务器地址
	 */
	private static String host;
	/**
	 * 端口
	 */
	private static String port;
	/**
	 * 协议
	 */
	private static String protocol;

	static {
		Properties mailProp = new Properties();
		try {
//			mailProp.load(ClassLoader.getSystemResourceAsStream("mail.properties"));
			mailProp = PropertiesLoaderUtils.loadAllProperties("mail.properties");
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("mail.properties文件加载失败");
		}
		alias = mailProp.getProperty("alias");
		account = mailProp.getProperty("account");
		pass = mailProp.getProperty("pass");
		host = mailProp.getProperty("host");
		port = mailProp.getProperty("port");
		protocol = mailProp.getProperty("protocol");

	}

	private Session getSession() {
		Properties sessionProp = new Properties();
		sessionProp.setProperty("mail.smtp.host", host);
		sessionProp.setProperty("mail.smtp.port", port);
		sessionProp.setProperty("mail.store.protocol", protocol);
		sessionProp.setProperty("mail.smtp.auth", "true");
		sessionProp.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		Authenticator authenticator = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(account, pass);
			}
		};

		return Session.getDefaultInstance(sessionProp, authenticator);
	}


	/**
	 * 根据接收地址,邮件主题,邮件内容发送邮件
	 *
	 * @date 2018/10/5
	 * @Param [recipient, subject, context]
	 * @return void
	 */
	@Override
	public void sendMail(String recipient, String subject, String context) {
		Session session = getSession();
		MimeMessage message = new MimeMessage(session);
		try {
			alias = MimeUtility.encodeText(alias);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		try {
			message.setFrom(alias + "<" + account + ">");
			message.setRecipients(Message.RecipientType.TO, recipient);
			message.setSubject(subject);
			message.setContent(context, "text/html; charset=UTF-8");
			message.setSentDate(new Date());

			Transport transport = session.getTransport();
			transport.connect();
			transport.sendMessage(message,message.getAllRecipients());
			transport.close();

		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

}

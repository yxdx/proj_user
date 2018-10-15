package tw.proj.mail;

/**
 * 接口 ProjMail
 *
 * @author ljc
 * @date 2018/10/5
 */
public interface ProjMail {
	void sendMail(String recipient, String subject, String context);
}

package tw.proj.mail.impl;

import org.junit.Test;

public class ProjMailImplTest {

	@Test
	public void sendMail() {
		long start = System.currentTimeMillis();
		new ProjMailImpl().sendMail("robot@proj.tw","主题","<h1\talign=\"center\">验证码:888</h1>");
		long end = System.currentTimeMillis();
		long time = (end - start) / 1000;

		System.out.println("成功 , 共耗时" + time + "秒");
	}
}
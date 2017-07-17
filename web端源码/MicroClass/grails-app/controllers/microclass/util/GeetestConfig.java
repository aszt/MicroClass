package microclass.util;

/**
 * GeetestWeb配置文件
 * 
 *
 */
public class GeetestConfig {

	// 填入自己的captcha_id和private_key
	private static final String captcha_id = "b747d43797807e1b197522d434eba7f7";
	private static final String private_key = "470a3a1d5cfb805abc6e3d2d09729d14";

	public static final String getCaptcha_id() {
		return captcha_id;
	}

	public static final String getPrivate_key() {
		return private_key;
	}

}

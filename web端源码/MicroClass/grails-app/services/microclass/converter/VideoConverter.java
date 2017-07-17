package microclass.converter;



import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.MultimediaInfo;
import microclass.util.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.PropertyResourceBundle;

/**
 * @author c-kx
 *
 */
public class VideoConverter {

	private final static String fileName="app-config";	//属性文件名称
	private static String MENCODER_PATH ;
	private static String FFMPEG_PATH ;

	static{
		readConfig();
	}
	//读取配置文件信息
	@SuppressWarnings("unchecked")
	private static void readConfig(){
		//PropertyResourceBundle使用属性文件中的静态字符串集合来管理语言环境资源。
		PropertyResourceBundle prb=(PropertyResourceBundle) PropertyResourceBundle.getBundle(fileName);
		//枚举Enumeration
		Enumeration enu=prb.getKeys();
		while (enu.hasMoreElements()){
			String propertyName=enu.nextElement().toString();
			//读取配置文件中的静态字符串并且赋值给类成员变量
			if (propertyName.equals("mencoder.path"))
				MENCODER_PATH=prb.getString("mencoder.path");
			if (propertyName.equals("ffmpeg.path"))
				FFMPEG_PATH=prb.getString("ffmpeg.path");
		}

	}

	/**
	 * @param videoPath
	 * @return 转换后文件的路径
	 */
	public String mencoderConverter(String videoPath) {
		if (!checkfile(videoPath)) {
			return null;
		}
		File file = new File(FileUtils.getFilePrefix(videoPath)+".avi");
		if (file.exists()) {
			System.out.println("路径[" + videoPath + "]文件已经是avi格式不需要转换!");
			return videoPath;
		}
		List<String> commend = new ArrayList<String>();
		commend.add(MENCODER_PATH);
		commend.add(videoPath);
		commend.add("-oac");
		commend.add("mp3lame");
		commend.add("-lameopts");
		commend.add("preset=64");
		commend.add("-ovc");
		commend.add("xvid");
		commend.add("-xvidencopts");
		commend.add("bitrate=600");
		commend.add("-of");
		commend.add("avi");
		commend.add("-o");
		commend.add(FileUtils.getFilePrefix(videoPath)+".avi");
		try {
			ProcessBuilder builder = new ProcessBuilder();
			System.out.println("mencoder开始转换");
			Process process = builder.command(commend).redirectErrorStream(true).start();
			new PrintStream(process.getErrorStream()).start();
			new PrintStream(process.getInputStream()).start();
			process.waitFor();
			System.out.println("mencoder转换结束");
			if (!checkfile(FileUtils.getFilePrefix(videoPath)+".avi")) {
				System.err.println("转换失败");
				return null;
			}
			return FileUtils.getFilePrefix(videoPath)+".avi";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @param videoPath
	 * @return 转换后文件的路径
	 */
	public String ffmpegConverter(String videoPath) {
		if (!checkfile(videoPath)) {
			return null;
		}
		File file = new File(FileUtils.getFilePrefix(videoPath)+".flv");
		if (file.exists()) {
			System.out.println("路径[" + videoPath + "]文件已经是flv格式不需要转换!");
			return videoPath;
		}
		List<String> commend = new ArrayList<String>();
		commend.add(FFMPEG_PATH);
		commend.add("-i");
		commend.add(videoPath);
		commend.add("-ab");
		commend.add("128");
		commend.add("-acodec");
		commend.add("libmp3lame");
		commend.add("-ac");
		commend.add("1");
		commend.add("-ar");
		commend.add("22050");
		commend.add("-r");
		commend.add("29.97");
		// 清晰度 -qscale 4 为最好但文件大, -qscale 6就可以了
		commend.add("-qscale");
		commend.add("4");
		commend.add("-y");
		commend.add(FileUtils.getFilePrefix(videoPath)+".flv");
		try {
			System.out.println("ffmpegConverter开始转换");
			Process videoProcess = new ProcessBuilder(commend).redirectErrorStream(true).start();
			new PrintStream(videoProcess.getErrorStream()).start();
			new PrintStream(videoProcess.getInputStream()).start();
			videoProcess.waitFor();
			System.out.println("ffmpegConverter转换结束");
			if (!checkfile(FileUtils.getFilePrefix(videoPath)+".flv")) {
				System.err.println("转换失败");
				return null;
			}
			return FileUtils.getFilePrefix(videoPath)+".flv";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @param videoPath
	 * @return  截图路径
	 */
	public String  videoCapture(String videoPath) {
		if (!checkfile(videoPath)) {
			return null;
		}
		List<String> commands = new ArrayList<String>();
		commands.add(FFMPEG_PATH);
		commands.add("-i");
		commands.add(videoPath);
		commands.add("-y");
		commands.add("-f");
		commands.add("image2");
		commands.add("-ss");
		commands.add("15");// 这个参数是设置截取视频多少秒时的画面
		commands.add("-s");
		commands.add("1920x1080");// 数值截取的宽高比
		commands.add(FileUtils.getFilePrefix(videoPath)+".jpg");
		try {
			System.out.println("开始截图");
			Process videoProcess = new ProcessBuilder(commands).redirectErrorStream(true).start();
			new PrintStream(videoProcess.getErrorStream()).start();
			new PrintStream(videoProcess.getInputStream()).start();
			videoProcess.waitFor();
			System.out.println("截图结束");
			if (!checkfile(FileUtils.getFilePrefix(videoPath)+".jpg")) {
				System.err.println("截图失败");
				return null;
			}
			return FileUtils.getFilePrefix(videoPath)+".jpg";
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * @param path
	 * @return true或false 检测文件是否存在
	 */
	private static boolean checkfile(String path) {
		File file = new File(path);
		if (!file.exists()) {
			System.err.println("路径[" + path + "]对应的文件不存在!");
			return false;
		}
		return true;
	}

	//获取视频音频时长
	public String  getDuration(String path) {
		File source = new File(path);
		Encoder encoder = new Encoder();
		String duration="";
		try {
			MultimediaInfo m = encoder.getInfo(source);
			long ls = m.getDuration();
			duration= ls/60000+"分"+(ls%60000)/1000+"秒";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return duration;
	}
}


class PrintStream extends Thread {
   java.io.InputStream __is = null;

   public PrintStream(java.io.InputStream is) {
       __is = is;
   }

   public void run() {
       try {
           while (this != null) {
               int _ch = __is.read();
               if (_ch != -1) {
                   System.out.print((char) _ch);
               } else
                   break;
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
   }
}

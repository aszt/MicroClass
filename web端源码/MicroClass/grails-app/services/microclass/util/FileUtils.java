package microclass.util;

import java.io.*;
import java.text.DecimalFormat;

public class FileUtils {
	/**
	 * 转换文件大小
	 *
	 * @param fileS
	 * @return
	 */
	public static String FormetFileSize(long fileS) {
		DecimalFormat df = new DecimalFormat("#.00");
		String fileSizeString = "";
		if (fileS < 1024) {
			fileSizeString = df.format((double) fileS) + "B";
		} else if (fileS < 1048576) {
			fileSizeString = df.format((double) fileS / 1024) + "K";
		} else if (fileS < 1073741824) {
			fileSizeString = df.format((double) fileS / 1048576) + "M";
		} else {
			fileSizeString = df.format((double) fileS / 1073741824) + "G";
		}
		return fileSizeString;
	}

	//获取文件前缀（文件名）
    public static String getFilePrefix(String fileName){
		int splitIndex = fileName.lastIndexOf(".");
        return fileName.substring(0, splitIndex);
	}



//	获取文件后缀（扩展名）
	public static String getFileSufix(String fileName){
		int splitIndex = fileName.lastIndexOf(".");
        return fileName.substring(splitIndex + 1);
	}

    public static String getFilePath(String fileName){
        int splitIndex = fileName.lastIndexOf("/");
        return fileName.substring(0, splitIndex);
    }
	public  static  String getRelPath(String fileName){
		int splitIndex = fileName.lastIndexOf("\\")+1;
		return fileName.substring(splitIndex, fileName.length());
	}
	public static void copyFile(String inputFile,String outputFile) throws FileNotFoundException{
		File sFile = new File(inputFile);
		File tFile = new File(outputFile);
		FileInputStream fis = new FileInputStream(sFile);
		FileOutputStream fos = new FileOutputStream(tFile);
		int temp = 0;  
        try {  
			while ((temp = fis.read()) != -1) {  
			    fos.write(temp);  
			}
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally{
            try {
				fis.close();
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        } 
	}
}

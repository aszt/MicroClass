package microclass.converter;

import java.io.BufferedReader;
import java.io.InputStreamReader;

//这个类主要用来处理一个系统调用而新创建一个线程或进程执行期间所产生的出错流的处理
public class ErrorInputStreamWathThread extends Thread {
    private Process process = null;
    private boolean over = false;
    public ErrorInputStreamWathThread(Process p) {
        process = p;
        over = false;
    }

    public void run() {
        try {
            if (process == null) {
                System.out.println("process为null，无法处理文件转换");
                return;
            }

            //对出错流的处理
            BufferedReader br = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            while (true) {
                if (process == null || over) {
                    System.out.println("处理完成");
                    break;
                }
                String temp;
                while ((temp = br.readLine()) != null) {
//					System.out.println("出错流信息:" + temp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("发生异常" + e.getMessage());
        }
    }

    public void setOver(boolean over) {
        this.over = over;
    }
}

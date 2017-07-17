package microclass.util;
/**
 * 杀掉flashpaper进程
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class StreamGrabber extends Thread {

    private final InputStream stream;
    private final List<String> holder;

    public StreamGrabber(InputStream stream) {
        this(stream, null);
    }

    public StreamGrabber(InputStream stream, List<String> holder) {
        this.stream = stream;
        this.holder = holder;
    }

    @Override
    public void run() {
        try {
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(stream));
            String line = null;
            while ((line = br.readLine()) != null) {
                if (holder != null)
                    holder.add(line);
            }
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }

    public static Process performCommand(String command) {
        try {
            return Runtime.getRuntime().exec(command);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean checkTask(String taskName) {
        try {
            Process p = Runtime.getRuntime().exec("cmd.exe /c  tasklist");
            StringBuffer out = new StringBuffer();
            byte[] b = new byte[1024];
            for (int n; (n = p.getInputStream().read(b)) != -1;) {
                out.append(new String(b, 0, n));
            }
            if(out.toString().indexOf(taskName)==-1)
                return false;
            else
                return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }



    public static void main(String[] args) {
        String command = "taskkill /f /im FlashPrinter.exe";
        Process proc = performCommand(command);
        List<String> outputs = new ArrayList<String>();
        new StreamGrabber(proc.getInputStream(), outputs).start();
    }
}

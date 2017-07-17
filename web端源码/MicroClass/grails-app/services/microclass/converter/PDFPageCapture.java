/*
 * Copyright 2006-2013 ICEsoft Technologies Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the
 * License. You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an "AS
 * IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package microclass.converter;

import org.icepdf.core.exceptions.PDFException;
import org.icepdf.core.exceptions.PDFSecurityException;
import org.icepdf.core.pobjects.Document;
import org.icepdf.core.pobjects.PDimension;
import org.icepdf.core.pobjects.Page;
import org.icepdf.core.util.GraphicsRenderingHints;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * The <code>PageCapture</code> class is an example of how to save page
 * captures to disk.  A file specified at the command line is opened and every
 * page in the document is captured as an image and saved to disk as a
 * PNG graphic file.
 *
 * @since 5.0
 */
public class PDFPageCapture {

    private int totalPage;
    private String  fileName="0";

    public int getTotalPage() {
        return totalPage;
    }

    public void capturePages(String filePath,String outPath) {
        // open the url
        Document document = new Document();

        // setup two threads to handle image extraction.
        ExecutorService executorService = Executors.newFixedThreadPool(4);
        try {

            fileName=filePath.substring(filePath.lastIndexOf("/")+1,filePath.lastIndexOf("."));
            System.out.print("PDFPageCapture中得到的截图名"+fileName);

            document.setFile(filePath);
            // create a list of callables.
//            int pages = document.getNumberOfPages();
//            System.out.println(document.getDocumentLocation());
//            System.out.println(document.getDocumentOrigin());

            int pages = document.getNumberOfPages();
            this.totalPage =pages ;
            //只截第一页
             pages = 0 ;
            java.util.List<Callable<Void>> callables = new ArrayList<Callable<Void>>(pages);
            for (int i = 0; i <= pages; i++) {
                callables.add(new CapturePage(document, i,outPath));
            }
            executorService.invokeAll(callables);
            executorService.submit(new DocumentCloser(document)).get();

        } catch (InterruptedException e) {
            System.out.println("Error parsing PDF document " + e);
        } catch (ExecutionException e) {
            System.out.println("Error parsing PDF document " + e);
        } catch (PDFException ex) {
            System.out.println("Error parsing PDF document " + ex);
        } catch (PDFSecurityException ex) {
            System.out.println("Error encryption not supported " + ex);
        } catch (FileNotFoundException ex) {
            System.out.println("Error file not found " + ex);
        } catch (IOException ex) {
            System.out.println("Error handling PDF document " + ex);
        }
        executorService.shutdown();
    }

    /**
     * Captures images found in a page  parse to file.
     */
    public class CapturePage implements Callable<Void> {
        private Document document;
        private int pageNumber;
        private float scale = 1f;
        private float rotation = 0f;
        private String outFile;

        private CapturePage(Document document, int pageNumber, String outFile) {
            this.document = document;
            this.pageNumber = pageNumber;
            this.outFile = outFile;
        }

        public Void call() {
            Page page = document.getPageTree().getPage(pageNumber);
            page.init();
            PDimension sz = page.getSize(Page.BOUNDARY_CROPBOX, rotation, scale);

            int pageWidth = (int) sz.getWidth();
            int pageHeight = (int) sz.getHeight();

            BufferedImage image = new BufferedImage(pageWidth,
                    pageHeight,
                    BufferedImage.TYPE_INT_RGB);
            Graphics g = image.createGraphics();

            page.paint(g, GraphicsRenderingHints.PRINT, Page.BOUNDARY_CROPBOX, rotation, scale);
            g.dispose();
            // capture the page image to file
            try {
//                System.out.println("Capturing page " + pageNumber);
                File file = new File(outFile +"\\"+ fileName + ".jpg");
//                ImageIO.getImageWritersBySuffix
                ImageIO.write(image, "jpg", file);
            } catch (Throwable e) {
                e.printStackTrace();
            }
            image.flush();
            return null;
        }
    }

    /**
     * Disposes the document.
     */
    public class DocumentCloser implements Callable<Void> {
        private Document document;

        private DocumentCloser(Document document) {
            this.document = document;
        }

        public Void call() {
            if (document != null) {
                document.dispose();
                System.out.println("Document disposed");
            }
            return null;
        }
    }
}

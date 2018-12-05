package br.com.senac.pi3.pwda.servico;

import com.lowagie.text.Document;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.io.FileOutputStream;
import java.io.OutputStream;

import java.io.IOException;
import javax.swing.JFileChooser;

public class GerarPDF {
    public static void gerarPDF(String[][] matriz, String[] colunas, String titulo) throws Exception {
        Document doc = null;
        OutputStream os = null;
     
        try {
            //cria o documento tamanho A4, margens de 2,54cm
            doc = new Document(PageSize.A4, 72, 72, 72, 72);
       
            //cria a stream de saída
            //os = new FileOutputStream("out.pdf");
            String caminho = SalvarArquivo();
            
            if("".equals(caminho)){
                throw new Exception("Processo cancelado, nenhum local foi selecionado");
            }
            
            os = new FileOutputStream(caminho);
            
            //associa a stream de saída ao
            PdfWriter.getInstance(doc, os);
       
            //abre o documento
            doc.open();

            //add grade no pdf
            //Determina número de colunas
            PdfPTable table = new PdfPTable(colunas.length);
            
            //Titulo
            PdfPCell header = new PdfPCell(new Paragraph(titulo));
            
            //número de linhas, nao funciona direito kk
            header.setColspan(matriz.length + 2);
            
            //Adiciona celula com o titulo
            table.addCell(header);
            
            //Add campos na ordem a ser impressa
            for (int i = 0; i < colunas.length; i++) {
                table.addCell(colunas[i]);
            }
            
            for (int i = 0; i < matriz.length; i++) {
                for (int j = 0; j < matriz[i].length; j++) {
                    table.addCell(matriz[i][j]);
                }
            }
            doc.add(table);
            
            java.awt.Desktop.getDesktop().open(new java.io.File(caminho));
        } catch (Exception ex) {
            throw new Exception(ex.getMessage());
        } finally {
            if (doc != null) {
                //Fecha documento
                doc.close();
            }
            if (os != null) {
               //Fecha stream de saída
               os.close();
            }
        }
    }
    
    public static String SalvarArquivo() throws IOException{
        String retorno = "";
        
        JFileChooser salvandoArquivo = new JFileChooser();

        int resultado = salvandoArquivo.showSaveDialog(null);
        
        if (resultado == JFileChooser.APPROVE_OPTION) {
            String caminho = salvandoArquivo.getSelectedFile().toString().trim();
            
            if (!caminho.substring(caminho.length() - 4).equals(".pdf")) {
                caminho += ".pdf";
            }
            
            retorno = caminho;
        }
        
        return retorno;
    }
}

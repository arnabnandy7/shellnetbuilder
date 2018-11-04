import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Decrypter implements Runnable{
    
    File finname,foutname;
    
    public Decrypter(File fin,File fout) {
    	finname=fin;
    	
    	String s=finname.getName();
    	String str=s.substring(0,s.length()-4);
	    foutname=new File(fout.getAbsolutePath()+"/"+str);

    }
    
    public void run(){
    	decrypt();
    }
    
    public void decrypt() {
      
             try  {  
                   FileInputStream fis =new FileInputStream(finname);
                   FileOutputStream fos=new FileOutputStream(foutname);

                   byte key[] = "abcdEFGH".getBytes();   
                   SecretKeySpec secretKey = new SecretKeySpec(key,"DES");  
  
                   Cipher decrypt =  Cipher.getInstance("DES/ECB/PKCS5Padding");  
                   decrypt.init(Cipher.DECRYPT_MODE, secretKey);  
  
                   byte[] input = new byte[10240];
                   int bytesRead;
                   while ((bytesRead = fis.read(input)) != -1){
                         byte[] output = decrypt.update(input, 0, bytesRead);
                         if (output != null)
                            fos.write(output);
                   }
 
                   byte[] output = decrypt.doFinal();
                   if (output != null)
                       fos.write(output);
 
                   fis.close();
                   fos.flush();
                   fos.close();
                   
                   //JOptionPane.showMessageDialog(null,"Encryption Complete".toString(),"Encryption Software",JOptionPane.INFORMATION_MESSAGE);
                 
             } catch(Exception e){  
                //e.printStackTrace();
                //JOptionPane.showMessageDialog(null,"Cannot decrypt".toString(),"Password Decryption",JOptionPane.ERROR_MESSAGE);
             }  
     }
     
    public static void main (String[] args) 
    {
        Runnable obj=new Decrypter(new File(args[0]),new File(args[1]));
     	Thread t=new Thread(obj);
     	t.start();
        
    }
}

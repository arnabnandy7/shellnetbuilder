import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Encrypter implements Runnable{
    
    File finname,foutname;
    
    public Encrypter(File fin,File fout) {
    	finname=fin;
    	
    	String str="";
	    
	    foutname=new File(fout.getAbsolutePath()+"/"+finname.getName()+".des");
    }
    
    public void run(){
    	encrypt();
    }
    
  
  
     public void encrypt() {
  
            try  {  
                 FileInputStream fis =new FileInputStream(finname);;
                 FileOutputStream fos=new FileOutputStream(foutname);
  
                 byte key[] = "abcdEFGH".getBytes();   
                 SecretKeySpec secretKey = new SecretKeySpec(key,"DES");  
  
                 Cipher encrypt =  Cipher.getInstance("DES/ECB/PKCS5Padding");  
                 encrypt.init(Cipher.ENCRYPT_MODE, secretKey);  
  
                 byte[] input = new byte[10240];
                 int bytesRead;
                 while ((bytesRead = fis.read(input)) != -1){
                      byte[] output = encrypt.update(input, 0, bytesRead);
                      if (output != null){
                         fos.write(output);
                         fos.flush();
                      }
                 }
 
                 byte[] output = encrypt.doFinal();
                 if (output != null)
                    fos.write(output);
          
                 fis.close();
                 fos.flush();
                 fos.close();
                 
                 //JOptionPane.showMessageDialog(null,"Encryption Complete".toString(),"Encryption Software",JOptionPane.INFORMATION_MESSAGE);
                 
                 	
            } catch(Exception e){  
            }  
     }
     
    public static void main (String[] args) 
    {
        Runnable obj=new Encrypter(new File(args[0]),new File(args[1]));
     	Thread t=new Thread(obj);
     	t.start();
    }
   
}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.*;
import java.awt.event.*;
import java.awt.*;
import javax.swing.*;

/**
 *
 * @author subhra
 */
public class dnssetup extends javax.swing.JFrame {

    /**
     * Creates new form dnssetup
     */
    public dnssetup() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jTextField1 = new javax.swing.JTextField();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTextArea1 = new javax.swing.JTextArea();
        jButton1 = new javax.swing.JButton();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jTextField2 = new javax.swing.JTextField();
        jLabel6 = new javax.swing.JLabel();
        jTextField3 = new javax.swing.JTextField();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTextArea2 = new javax.swing.JTextArea();
        jLabel7 = new javax.swing.JLabel();
        jButton4 = new javax.swing.JButton();
        jButton5 = new javax.swing.JButton();
        jButton6 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("©Network Builder V0.1 | Primary DNS Server Setup");
        setResizable(false);

        jLabel1.setFont(new java.awt.Font("Century Schoolbook L", 1, 18)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(50, 134, 220));
        jLabel1.setText("Primary Name Server Setup");
        jLabel1.setToolTipText("DNS Setup");

        jLabel2.setFont(new java.awt.Font("Century Schoolbook L", 1, 18)); // NOI18N
        jLabel2.setForeground(java.awt.SystemColor.activeCaption);
        jLabel2.setText("Step 1");

        jLabel3.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jLabel3.setText(" Zone Name *");
        jLabel3.setToolTipText("Name of the Zone File Name");

        jTextField1.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jTextField1.setToolTipText("Enter Zone File Name");

        jTextArea1.setEditable(false);
        jTextArea1.setColumns(20);
        jTextArea1.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jTextArea1.setForeground(new java.awt.Color(178, 46, 38));
        jTextArea1.setRows(5);
        jScrollPane1.setViewportView(jTextArea1);

        jButton1.setBackground(new java.awt.Color(41, 121, 63));
        jButton1.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jButton1.setText("Save");
        jButton1.setToolTipText("Save Zone File Name");
        jButton1.addActionListener(new java.awt.event.ActionListener() 
	{
	     public void runShellScript(String unixCommand) throws IOException, InterruptedException
			 {
			        ProcessBuilder processBuilder = new ProcessBuilder("bash", "-c", unixCommand);
			        processBuilder.redirectErrorStream(true); 
			        Process shellProcess = processBuilder.start();
			        InputStream inputStream = shellProcess.getInputStream(); 
			        int consoleDisplay;
			        while((consoleDisplay=inputStream.read())!=-1)
				 {
			            System.out.println(consoleDisplay);
				}
        			try
				 {
				            inputStream.close();
        			 } 
				catch (IOException iOException)
				 { }
			}
            public void actionPerformed(java.awt.event.ActionEvent evt)
	    {
		String zone_name = new String(jTextField1.getText());
		String server_name = new String(jTextField2.getText());
		String server_ip = new String(jTextField3.getText());
		try{
                	jButton1ActionPerformed(evt);
			if(zone_name.equals("")|| server_name.equals("")|| server_ip.equals(""))
			{
				JLabel errorFields = new JLabel("<HTML><FONT COLOR = Blue>All Field is Mandetory.</FONT></HTML>");	
				JOptionPane.showMessageDialog(null,errorFields); 
				jTextField1.setText("");
				jTextField2.setText("");
				jTextField3.setText("");
			}
			else
			{
				BufferedWriter fileOut = new BufferedWriter(new FileWriter("/etc/Network_Builder_V0.1/logs/DNS/dnsk.log"));
				fileOut.write(jTextField1.getText()); 
				fileOut.newLine();
				fileOut.write(jTextField2.getText()); 
				fileOut.newLine();
				fileOut.write(jTextField3.getText()); 
				fileOut.newLine();
				fileOut.close();
				jTextField1.setText("");
				jTextField2.setText("");
				jTextField3.setText("");

				String str1,str2,str3;
				str1="Complete Configuration! Name Server Information has been Saved Successfully";
				BufferedWriter bw1 = new BufferedWriter(new FileWriter("/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg"));
				bw1.write(str1);
				bw1.newLine(); 
				bw1.close();
				
				String unixCommand = "bash dns.sh "+zone_name+" "+server_name+" "+server_ip; 
				runShellScript(unixCommand);
				
				BufferedReader br1=new BufferedReader(new FileReader("/etc/Network_Builder_V0.1/logs/DNS/dnsk.log"));
				BufferedReader br2=new BufferedReader(new FileReader("/etc/Network_Builder_V0.1/logs/DNS/dnsk.msg"));

				while ((str3 =br1.readLine())!= null) 
				{
					jTextArea1.append(str1 + "\n");
					//jTextArea1.append("\n");
				}
				while ((str2 = br2.readLine()) != null) 
				{
					jTextArea1.append(str2 + "\n");
					//jTextArea1.append("\n");
				}
			
				jButton6.setEnabled(true);
				
				
			}
		  }
		catch(Exception e)
		{
		}
            }
        });


        jLabel4.setFont(new java.awt.Font("Century Schoolbook L", 1, 18)); // NOI18N
        jLabel4.setForeground(java.awt.SystemColor.activeCaption);
        jLabel4.setText("Step 2");
        jLabel4.setToolTipText("");

        jLabel5.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jLabel5.setText("Server Name *");
        jLabel5.setToolTipText("NameServer Name");

        jTextField2.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jTextField2.setToolTipText("Enter Server Name");

        jLabel6.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jLabel6.setText("Server IP *");
        jLabel6.setToolTipText("IP Address of the Server");

        jTextField3.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N

        jTextArea2.setEditable(false);
        jTextArea2.setColumns(20);
        jTextArea2.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jTextArea2.setRows(5);
        jScrollPane2.setViewportView(jTextArea2);

        jLabel7.setFont(new java.awt.Font("Century Schoolbook L", 0, 14)); // NOI18N
        jLabel7.setForeground(new java.awt.Color(53, 106, 211));
        jLabel7.setText("©Network Builder V0.1");

        jButton4.setBackground(new java.awt.Color(211, 47, 31));
        jButton4.setFont(new java.awt.Font("Century Schoolbook L", 1, 24)); // NOI18N
        jButton4.setText("Close");
        jButton4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton4ActionPerformed(evt);
		dispose();
            }
        });

        jButton5.setBackground(new java.awt.Color(211, 47, 31));
        jButton5.setFont(new java.awt.Font("Century Schoolbook L", 1, 18)); // NOI18N
        jButton5.setText("Exit");
        jButton5.addActionListener(new java.awt.event.ActionListener() {
		public void runShellScript(String unixCommand) throws IOException, InterruptedException
			 {
			        ProcessBuilder processBuilder = new ProcessBuilder("bash", "-c", unixCommand);
			        processBuilder.redirectErrorStream(true); 
			        Process shellProcess = processBuilder.start();
			        InputStream inputStream = shellProcess.getInputStream(); 
			        int consoleDisplay;
			        while((consoleDisplay=inputStream.read())!=-1)
				 {
			            System.out.println(consoleDisplay);
				}
        			try
				 {
				            inputStream.close();
        			 } 
				catch (IOException iOException)
				 { }
			}
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton5ActionPerformed(evt);
		final String dir = System.getProperty("user.dir");
		try{
		String unixCommand = "java Encrypter dns.sh "+dir; 
		runShellScript(unixCommand);
		unixCommand = "rm -f dns.sh"; 
		runShellScript(unixCommand);
		}
		catch(Exception e){}
		System.exit(0);
            }
        });

        jButton6.setBackground(new java.awt.Color(41, 121, 63));
        jButton6.setFont(new java.awt.Font("Century Schoolbook L", 1, 14)); // NOI18N
        jButton6.setText("Update DHCP");
        jButton6.setToolTipText("DHCP Update");
	jButton6.setEnabled(false);
        jButton6.addActionListener(new java.awt.event.ActionListener() {
		public void runShellScript(String unixCommand) throws IOException, InterruptedException
			 {
			        ProcessBuilder processBuilder = new ProcessBuilder("bash", "-c", unixCommand);
			        processBuilder.redirectErrorStream(true); 
			        Process shellProcess = processBuilder.start();
			        InputStream inputStream = shellProcess.getInputStream(); 
			        int consoleDisplay;
			        while((consoleDisplay=inputStream.read())!=-1)
				 {
			            System.out.println(consoleDisplay);
				}
        			try
				 {
				            inputStream.close();
        			 } 
				catch (IOException iOException)
				 { }
			}
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton6ActionPerformed(evt);
		final String dir = System.getProperty("user.dir");
		try{
		String unixCommand = "java Encrypter dns.sh "+dir; 
		runShellScript(unixCommand);
		unixCommand = "rm -f dns.sh"; 
		runShellScript(unixCommand);
		}
		catch(Exception e){}
		new dhcpframedns().setVisible(true);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(178, 178, 178)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, 222, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel2))
                        .addGap(0, 328, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(26, 26, 26)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 76, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGroup(layout.createSequentialGroup()
                                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                            .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 116, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                                .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 105, javax.swing.GroupLayout.PREFERRED_SIZE)
                                                .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 113, javax.swing.GroupLayout.PREFERRED_SIZE)))
                                        .addGap(36, 36, 36)
                                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                            .addComponent(jTextField2, javax.swing.GroupLayout.DEFAULT_SIZE, 222, Short.MAX_VALUE)
                                            .addComponent(jTextField3)))
                                    .addComponent(jLabel4))
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(20, 20, 20)
                                .addComponent(jLabel7)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jButton6)
                                .addGap(18, 18, 18)))
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                .addComponent(jButton4)
                                .addGap(18, 18, 18)
                                .addComponent(jButton5, javax.swing.GroupLayout.PREFERRED_SIZE, 69, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(11, 11, 11))
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 299, Short.MAX_VALUE)
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.Alignment.TRAILING))))
                .addContainerGap())
            .addGroup(layout.createSequentialGroup()
                .addGap(239, 239, 239)
                .addComponent(jLabel1)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel2)
                .addGap(7, 7, 7)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 140, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 30, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel5, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel4)
                                .addGap(26, 26, 26)
                                .addComponent(jButton6, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 57, Short.MAX_VALUE)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(jButton4, javax.swing.GroupLayout.PREFERRED_SIZE, 43, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(jButton5, javax.swing.GroupLayout.PREFERRED_SIZE, 43, javax.swing.GroupLayout.PREFERRED_SIZE)))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 139, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, Short.MAX_VALUE)))
                        .addContainerGap())
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(jLabel7, javax.swing.GroupLayout.PREFERRED_SIZE, 29, javax.swing.GroupLayout.PREFERRED_SIZE))))
        );

        pack();
	setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton4ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton4ActionPerformed

    private void jButton5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton5ActionPerformed

    private void jButton6ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton6ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton6ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(dnssetup.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(dnssetup.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(dnssetup.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(dnssetup.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new dnssetup().setVisible(true);
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton4;
    private javax.swing.JButton jButton5;
    private javax.swing.JButton jButton6;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTextArea jTextArea1;
    private javax.swing.JTextArea jTextArea2;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    // End of variables declaration//GEN-END:variables
}
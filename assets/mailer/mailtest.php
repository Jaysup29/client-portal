<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'src/Exception.php';
require 'src/PHPMailer.php';
require 'src/SMTP.php';


function email_sender($address,$subject,$bodymessage,$deliverydate,$description,$title)
{
    $mail = new PHPMailer(true);
    
        try {
            //Server settings
            $mail->SMTPDebug = 2; 
            $mail->isSMTP();
            $mail->Host       = 'shu17.unified-servers.com'; 
            $mail->SMTPAuth   = true;
            $mail->Username   = 'info@sukiko.com.ph'; 
            $mail->Password   = 'hr%W6F;a-5Dkgq#';
            $mail->SMTPSecure = 'ssl';  
            $mail->Port       = 465;  
            
            $body = get_file_contents('format.php');
            $body = str_replace("####TITLE####",$title,$body);
            $body = str_replace("###DESCRIPTION###",$description,$body);
            $body = str_replace("###DELIVERYDATE###",$deliverydate,$body);
            $body = str_replace("###BODYMESSAGE###",$bodymessage,$body);

            $mail->setFrom('info@sukiko.com.ph', 'Ordering System');
            $mail->addAddress($address);
            $mail->addReplyTo('info@sukiko.com.ph', 'Information');
            $mail->isHTML(true); 
            $mail->Subject = $subject;
            $mail->Body    = $body;
            $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

            $mail->send();
            echo 'sent';
        } 
        catch (Exception $e) 
        {
            echo "err";
        }


}

?>
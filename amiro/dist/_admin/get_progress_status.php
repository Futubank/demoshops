<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       699 xkqwritggtypmpqpsxmzrzkznlnspzxuiiymlzgqrgzmmzqxuklutqpkkulpwpmzpgqypnir
 */ ?><?php foreach(array(20327=>'MS',20328=>'~') as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!empty($_GET[I20327])){ $SKIP_CONST =true; require 'cm_ini.php'; $file =$GLOBALS['ROOT_PATH']."_admin/_logs/"."progress_".str_replace(array(I20328, '\\'), array('', ''), $_GET[I20327]).'.txt'; if(is_file($file)){ header('Content-Type: text/plain; charset=UTF-8'); echo 'OK'; echo file_get_contents($file); die; }}echo 'ERROR'; 
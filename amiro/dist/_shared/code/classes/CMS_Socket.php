<?php /**
 * @copyright  2000-2016 Amiro.CMS. All rights reserved. 
 * @version    $Id$ 
 * @size       13895 xkqwznlqulyuyismypsyynntwrlzkltzlrnqnngqinpzwwnwikxilrwyrgtqykriwtgnpnir
 */ ?><?php foreach(array(2439=>"",2440=>'GHrt',2441=>"C",2442=>"\r\n\r\n") as $i1=>$i2){$i3=strrev("rtrts");define("I".$i1,$i3($i2,'abcdeghijklmopqswyz ~`!@#%^&*()_-+|{}[];:<>,./?ABCDEGHIJKLMOPQSWYZ','ZYWSQPOMLKJIHGEDCBA?/.,><:;][}{|+-_)(*&^%#@!`~ zywsqpomlkjihgedcba'));} if(!defined('AMI_ENVIRONMENT')){header('HTTP/1.0 403 Forbidden');die('Forbidden, invalid URL! '.__FILE__.' at '.__LINE__);} class CMS_Socket {public $host; public $port =80; public $II1II1I =20; public $error =0; public $request; public $Il1ILLl; public $reply =""; public $Il1ILLL =0; public $Il1ILL1 =0; public $mode =0; public $Il1IL1I =false; public $filename; public $Il1IL1l; public $Il1IL1L =false; public $Il1IL11 =0; public $Il1I1II =8192; public $Il1I1Il; public $Il1I1IL =8192; public $Il1I1I1 =false; public $Il1I1lI =0; public $percent =0; public $_debug =0; public $Il1I1ll =0; function CMS_Socket() {if ($this->_debug === 1) {_d("CMS_Socket::CMS_Socket()"); }$this->error =0; $this->port =80; $this->mode =0; $this->Il1I1ll =0; }function Init($url, $mode =0, $Il1I1lL =I2439) {$this->error =0; if ($this->_debug === 1) {_d("CMS_Socket::Init()"); }$result =false; if (!empty($mode)) {$this->mode =$mode; }if (!empty($Il1I1lL)) {$this->Il1I1IL =$Il1I1lL; }if (!empty($url)) {$Il1I1l1 =array(); $Il1I1l1 =parse_url($url); $scheme =$Il1I1l1['scheme']; switch ($scheme) {case "http": $host =$Il1I1l1['host']; $port =$Il1I1l1[I2440]; $query =$Il1I1l1['path'] .$Il1I1l1['query']; if (!empty($host)) {$this->host =$host; }else {$this->error =2; }if (($this->error === 0) && !empty($port)) {$this->port =$port; }else {$this->port =80; }$request ="GET $query HTTP/1.1\r\n"; $request .= "Host: $host\r\n"; $request .= "Connection: Close\r\n\r\n"; $this->TTl1ITl($request); break; }if ($this->error === 0) {$result =true; }}else {$this->error =1; }return $result; }function TTl1ITT($buffer =8192) {if ($this->_debug === 1) {_d("CMS_Socket::SetBufferSize()"); }$this->Il1I1II =intval($buffer); }function TTl1ITI($partial =true) {if ($this->_debug === 1) {_d("CMS_Socket::SetPartialDownload()"); }$this->Il1IL1I =$partial; }function TTl1ITl($request) {if ($this->_debug === 1) {_d("CMS_Socket::SetRequest()"); }if (!empty($request)) {$this->request =$request; }}function TTl1IT1($filename) {if ($this->_debug === 1) {_d("CMS_Socket::SetFilename()"); }if (!empty($filename)) {$this->filename =$filename; }}function TTl1IIT($mode =0) {if ($this->_debug === 1) {_d("CMS_Socket::SetSocketMode()"); }if (($mode === 0) || ($mode === 1)) {$this->Il1I1ll =$mode; }}function TTl1III() {if ($this->_debug === 1) {_d("CMS_Socket::sockOpen()"); }$result =true; if ($this->Il1I1ll === 0) {$this->Il1IL11 =fsockopen($this->host, $this->port, $errno, $errstr, $this->II1II1I); }elseif ($this->Il1I1ll === 1) {$address =gethostbyname($this->host); $this->Il1IL11 =socket_create(AF_INET, SOCK_STREAM, SOL_TCP); if ($this->Il1IL11 <0) {$this->error =4; }else {$result =socket_connect($this->Il1IL11, $address, $this->port); if ($result <0) {$this->error =4; }}}if (!$this->Il1IL11) {$this->error =4; $result =false; }if ($this->mode === 1) {$this->Il1IL1l =fopen($this->filename, I2441); if ($this->Il1IL1l === false) {$this->error =7; $result =false; }}return $result; }function TTl1IIl() {if ($this->_debug === 1) {_d("CMS_Socket::IsOpen()"); }$result =false; if ($this->Il1IL11 !== 0) {$result =true; }return $result; }function TTl1II1() {if ($this->_debug === 1) {_d("CMS_Socket::sockWrite()"); }if ($this->Il1I1ll === 0) {fwrite($this->Il1IL11, $this->request); }elseif ($this->Il1I1ll === 1) {socket_write($this->Il1IL11, $this->request, mb_strlen($this->request)); }}function TTl1IlT() {$this->Il1ILLL =0; $reply =I2439; if ($this->_debug === 1) {_d("CMS_Socket::sockRead()"); }if ($this->Il1IL1I === false) {if ($this->Il1I1ll === 0) {$reply =fread($this->Il1IL11, $this->Il1I1II); $this->reply .= $reply; }elseif ($this->Il1I1ll === 1) {$reply =socket_read($this->Il1IL11, $this->Il1I1II); $this->reply .= $reply; }$this->Il1ILLL =mb_strlen($this->reply); }elseif ($this->Il1IL1I === true) {if ($this->Il1I1ll === 0) {$reply =fread($this->Il1IL11, $this->Il1I1II); }if ($this->Il1I1ll === 1) {$reply =socket_read($this->Il1IL11, $this->Il1I1II); }$this->reply .= $reply; $this->Il1ILLL =mb_strlen($reply); $this->Il1ILL1 =mb_strlen($this->reply); }if ($this->mode === 1) {if ($this->Il1IL1L === true) {fwrite($this->Il1IL1l, $reply); }else {$this->TTl1IlI(); }}}function TTl1IlI() {if ($this->_debug === 1) {_d("CMS_Socket::_defineHeaders()"); }if ($this->Il1IL1L !== true) {if (($pos =mb_strpos($this->reply, I2442)) !== false) {$this->reply =mb_substr($this->reply, $pos+4); $this->Il1ILLL =mb_strlen($this->reply); $this->replyTotal =mb_strlen($this->reply); $this->Il1IL1L =true; fwrite($this->Il1IL1l, $this->reply); }}}function TTl1Ill() {if ($this->_debug === 1) {_d("CMS_Socket::Close()"); }if ($this->Il1I1ll === 0) {fclose($this->Il1IL11); }elseif ($this->Il1I1ll === 1) {socket_close($this->Il1IL11); }if ($this->mode === 1) {fclose($this->Il1IL1l); }}function TTl1Il1() {if ($this->_debug === 1) {_d("CMS_Socket::AnalyzeHeader()"); }if (mb_strpos($this->reply, "HTTP/1.1 200 OK") !== false) {preg_match("/Content-Length: (\d+)/", $this->reply, $match); if (!empty($match)) {$Il1I1LI =$match[1]; $this->Il1I1IL =$Il1I1LI; $this->Il1I1I1 =true; }else {$this->error =6; }}else {$this->error =5; }$this->Il1I1lI++; }function TTl1I1T() {if ($this->_debug === 1) {_d("CMS_Socket::CutHeaders()"); }if (mb_strpos($this->reply, "HTTP/1.1 200 OK") !== false) {preg_match("/Content-Length: (\d+)/", $this->reply, $match); if (!empty($match)) {$Il1I1LI =$match[1]; $this->reply =mb_substr($this->reply, -$Il1I1LI); }}else {$this->error =5; }}function Get($url =I2439) {if ($this->_debug === 1) {_d("CMS_Socket::Get()"); }if (!empty($url)) {$this->Init($url); }if ($this->Il1IL1I === false) {if ($this->error === 0) {if ($this->TTl1III()) {$reply =I2439; $this->TTl1II1(); while (!feof($this->Il1IL11)) {$this->TTl1IlT(); $reply .= $this->reply; }if (mb_strpos($reply, "HTTP/1.1 200 OK") !== false) {preg_match("/Content-Length: (\d+)/", $reply, $match); if (!empty($match)) {$Il1I1LI =$match[1]; $reply =mb_substr($reply, -$Il1I1LI); }else {$reply =I2439; $this->error =6; }}else {$this->error =5; $this->reply =I2439; }if ($this->mode === 1) {fwrite($this->Il1IL1l, $reply); }$this->TTl1Ill(); return $reply; }}}elseif ($this->Il1IL1I === true) {if ($this->TTl1IIl()) {$this->TTl1IlT(); }else {if ($this->TTl1III()) {$this->TTl1II1(); $this->TTl1IlT(); }}if ($this->Il1ILLL === 0) {$this->TTl1Ill(); $this->TTl1I1T(); }if (!$this->Il1I1I1 && $this->Il1I1lI <= 20) {$this->TTl1Il1(); }$this->percent =ceil($this->Il1ILL1 /$this->Il1I1IL *100); if ($this->percent >100) $this->percent =100; return $this->Il1ILLL; }}}?>
<?php
//...
$connect = mysqli_connect('localhost','root','','Monisit');

if(!$connect){
	die ('Error connect to database');
};
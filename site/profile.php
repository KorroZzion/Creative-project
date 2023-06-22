<?php
session_id('my-session-id');
	session_start();
  require_once 'vendor/connect.php';
  if(!$_SESSION['user']){
    header('Location: ../index.php');
  };
?>

<!DOCTYPE html>
<html lang = "en">
<head>
  <meta charset="UTF-8">
  <meta name="view" conten="qrcodess">
  <link rel="stylesheet" type="text/css" href="assets/css/qrcss.css">
  <title>Qrcod</title>
</head>
<body>

  <header>
      <a href="rasp.php">Расписание</a>
      <a href="profile.php">Группы</a>
      <a class='logout' href="vendor/logout.php">Выход</a>
  </header>
<form>
  <p>
    <div style="text-align: center;">
      <img class="qr" src="https://chart.googleapis.com/chart?cht=qr&chl=<?= $_SESSION['user']['qr_cod'] ?>&chs=180x180&choe=UTF-8&chld=L|2" alt="qrcode" id="code" width=45% align ="down" >

        <h1 margin: 20px 0>Преподаватель: <?= $_SESSION['user']['first_name']?> <?= $_SESSION['user']['last_name']?>| Предмет: <?= $_SESSION['user']['subject']?>  | Группа: <?= $_SESSION['user']['groups']?>  </h1></div>
  </p>
</form>
</body>


<?php
	session_id('my-session-id');
	session_start();
	require_once 'vendor/connect.php';

	if(isset($_SESSION['user']) && $_SESSION['user']){
  		header('Location: ../profile.php');
};
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="assets/css/auth.css">
	<title></title>
</head>
<body>

	<form action="vendor/signin.php" method="post">

		<label>Логин</label>
		<input type="text" placeholder="Введите свой логин" name="login">
		<label>Пароль</label>
		<input type="password" placeholder="Введите свой пароль" name="password">
		<button>Войти</button>

		<?php
			if (isset($_SESSION['message'])) {
  				echo '<p class="msg">' . $_SESSION['message'] . '</p>';
  				unset($_SESSION['message']);
}
		?>

	</form>


</body>
</html>
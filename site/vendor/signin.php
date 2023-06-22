<?php
	session_start();
	require_once 'connect.php';

	$login = $_POST['login'];
	$password = $_POST['password'];

	$check_user = mysqli_query($connect,
		"SELECT *
    FROM `teachers`
    INNER JOIN `lessons` ON `teachers`.`teacher_id` = `lessons`.`teacher_id`
    INNER JOIN `lesson_grops` ON `lessons`.`id_lesson` = `lesson_grops`.`id_lesson`
    INNER JOIN `schedule` ON `lessons`.`id_lesson` = `schedule`.`id_lesson`
    INNER JOIN `audience` ON `schedule`.`id_audience` = `audience`.`id_audience`
    WHERE `teachers`.`login`='$login' AND `teachers`.`password`='$password'
    ORDER BY `schedule`.`time_lesson` ASC");


	if(mysqli_num_rows($check_user)>0){

		$user = mysqli_fetch_assoc($check_user);
		$_SESSION['user']=[
			"id" => $user['id'],
			"first_name" => $user['first_name'],
			"last_name" => $user['last_name'],
			"surname" => $user['surname'],
			"subject" => $user['subject'],
			"groups" => $user['groups'],
			"qr_cod" => $user['qr_cod'],
			"dates" => $user['dates'],
			"audience" => $user['audience'],
			"room" => $user['room'],
			"time_lesson" => $user['time_lesson'],

		];
		header('Location: ../profile.php');

	} else{
		$_SESSION['message'] = 'Неверный логин или пароль';
		header('Location: ../index.php');
	};

?>
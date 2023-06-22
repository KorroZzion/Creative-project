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
        <meta name="view" conten="rasp">
        <link rel="stylesheet" type="text/css" href="assets/css/qrcss.css">
        <title>RASP</title>
    </head>
    <body>
        <table>
            <thead>
                <tr>
                    <th>Time_lesson</th>
                    <th>Аudience room</th>
                    <th>Subject</th>
                    <th>Fullname teacher</th>
                    <th>Groups</th>
                </tr>
            </thead>
            <tbody>

                <?php
                $check_user = mysqli_query($connect,
    "SELECT `dates`,`time`, `audience`, `room`, `subject`, `first_name`, `last_name`,`surname`, `groups`
FROM `teachers`
INNER JOIN `lessons` ON `teachers`.`teacher_id` = `lessons`.`teacher_id`
INNER JOIN `lesson_grops` ON `lessons`.`id_lesson` = `lesson_grops`.`id_lesson`
INNER JOIN `schedule` ON `lessons`.`id_lesson` = `schedule`.`id_lesson`
INNER JOIN `audience` ON `schedule`.`id_audience` = `audience`.`id_audience`
INNER JOIN `time_lessons` ON `schedule`.`id_tles` = `time_lessons`.`id_tles`
ORDER BY `schedule`.`id_tles` ASC
    ");

$rasps = mysqli_fetch_all($check_user);
foreach ($rasps as $rasp) {
?>
<tr>
<td><?= $rasp[1] ?></td>
<td><?= $rasp[2] ?> корпус, <?= $rasp[3] ?> аудитория</td>
<td><?= $rasp[4] ?></td>
<td><?= $rasp[5] ?> <?= $rasp[6] ?> <?= $rasp[7] ?></td>
<td><?= $rasp[8] ?></td>
</tr>
<?php
}
?>

            </tbody>
        </table>
    </body>
</html>
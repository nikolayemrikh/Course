<?php

error_reporting(E_ALL);
include("lib.php");

echo $body ='
<script type="text/javascript">
<!--
function execMethod(val) {
   self.document.form01.elements[0].name=val;
   self.document.form01.submit();
}
//-->
</script>
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
      <ul class="nav">
        <li><a class="brand">Система формирования расписания</a></li>
        <li class="active"><a href="/site1/user.php">Главная</a></li>
        <li><a href="logout.php">Выход</a></li>
      </ul>
    </div>
  </div>
</div>';


function getMainWindow($conn,$message)
{
   $title = 'Управление расписанием';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="user.php">
<script type="text/javascript">
<!--
function execMethod(val) {
   self.document.form01.elements[0].name=val;
   self.document.form01.submit();
}
//-->
</script>
<table id="basic_table">
<thead>
<tr>
   <th>N</th>
   <th>Начальная станция</th>
   <th>Конечная станция</th>
   <th>В пути</th>
   <th>Отправление</th>
   <th>Прибытие</th>
   <th>Расстояние</th>
   <th>Информация <br/> о маршруте</th>
</tr>
</thead><tbody>';
   $sql = "SELECT sch_id, firstcity, lastcity, travel_time, dt, at, dist, route_id FROM schedule";
   $stmt = oci_parse($conn, $sql);
   oci_execute($stmt);
   $i = 0;
   while (oci_fetch($stmt)){
      $i++;
      $firstcity = oci_result($stmt, 'FIRSTCITY');
      $lastcity = oci_result($stmt, 'LASTCITY');
      $travel_time = oci_result($stmt, 'TRAVEL_TIME');
      $DT = oci_result($stmt, 'DT');
      $AT = oci_result($stmt, 'AT');
      $dist = oci_result($stmt, 'DIST');
      $route_id = oci_result($stmt, 'ROUTE_ID');
      $sch_id = oci_result($stmt, 'SCH_ID');
      $body .= '<tr>
<td>'.$i.'</td>
<td>'.$firstcity.'</td>
<td>'.$lastcity.'</td>
<td>'.convertToHoursMins($travel_time,'%02d часов %02d минут').'</td>
<td>'.$DT.'</td>
<td>'.$AT.'</td>
<td>'.$dist.'</td>
<td><input type="submit" name="getSchDistView" class="btn btn-info" value="'.$route_id.'"></td></tr>';
   }
   $body .= '</tbody>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getMainWindow" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}

function getSchDistView($conn,$route_id,$message){
   $title = 'Управление расписанием';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="user.php">
<table id="basic_table"> 
    <thead>
    <tr>
        <th>Начальная станция</th>
        <th>Конечная станция</th>
        <th>Дата и время <br/> отправления первого поезда</th>
        <th>Кол-во поездов в день</th>
        <th>Интервал между <br/> отбытием поездов</th>
        <th>Скорость поезда</th>
        <th>Расстояние</th>
    </tr>
</thead>
<tbody>';
    $sql = "SELECT ROUTE_ID, FIRSTCITY, LASTCITY, DT, TPD, INTER, SPEED, DIST FROM route WHERE ROUTE_ID='$route_id'";
    $stmt = oci_parse($conn, $sql);
    oci_execute($stmt);
    while (oci_fetch($stmt)){
        $sc_route_firstcity = oci_result($stmt, 'FIRSTCITY');
        $sc_route_lastcity = oci_result($stmt, 'LASTCITY');
        $sc_route_DT = oci_result($stmt, 'DT');
        $sc_route_TPD = oci_result($stmt, 'TPD');
        $sc_route_inter = oci_result($stmt, 'INTER');
        $sc_route_speed = oci_result($stmt, 'SPEED');
        $sc_route_dist = oci_result($stmt, 'DIST');
        $body .= '<tr>
         <td>'.$sc_route_firstcity.'</td>
         <td>'.$sc_route_lastcity.'</td>
         <td>'.substr_replace($sc_route_DT,"",17,10).'</td>
         <td>'.$sc_route_TPD.'</td>
         <td>'.substr_replace(substr_replace($sc_route_inter,"",0,11),"",5,7).'</td>
         <td>'.$sc_route_speed.'</td>
         <td>'.$sc_route_dist.'</td>
</tr>';
    }
    $body .= '<tbody>
</table>
<table id="info_table">
   <thead>
   <tr>
      <th>№</th>
      <th>Расстояние</th>
      <th>Начальная <br/> станция</th>
      <th>Конечная <br/> станция</th>
   </tr>
</thead>
<tbody>';
    $sql = "SELECT DIST, FIRSTCITY, LASTCITY FROM distance WHERE ROUTE_ID='$route_id'";
    $stmt = oci_parse($conn, $sql);
    oci_execute($stmt);
    $i=0;
    while (oci_fetch($stmt)){
        $i++;
        $sc_d_dist = oci_result($stmt, 'DIST');
        $sc_d_firstcity = oci_result($stmt, 'FIRSTCITY');
        $sc_d_lastcity = oci_result($stmt, 'LASTCITY');
        $body .= '<tr>
<td>'.$i.'</td>
<td>'.$sc_d_dist.'</td>
<td>'.$sc_d_firstcity.'</td>
<td>'.$sc_d_lastcity.'</td>';
}
$body .= '<tbody>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getScheduleEdit" class="btn btn-inverse" value="Вернуться назад">
</tr></td>
</table>';
   $html = tplLoad($title,$body);
   return $html;
}

session_start();
//Роль зарегистрирована в сессии?
if (!isset($_SESSION["status"])){
        header("Location: index.php");
        session_destroy();
        exit;
//Проверка соответствия роли
} elseif ($_SESSION["status"]!=2){
        header("Location: index.php");
        session_destroy();
        exit;
}

if (@PostContains(usrStatus)) $_SESSION["uStatus"] = $usrStatus;
if (@PostContains(user)) $_SESSION["reUser"] = $user;
if (@PostContains(schedule)) $_SESSION["reSch"] = $schedule;

$conn = dbConnect();

if ($conn=='') errorMessage("Нет доступа к базе данных.");

if (@PostContains(getSchDistView)) {
   @PostContains(getSchDistView);
         $html = getSchDistView($conn,$getSchDistView,"Маршрут");
//Выход
} elseif (@PostContains(systemExit)) {
        session_destroy();
        header("Location: index.php");
        exit;
} else {
        $html = getMainWindow($conn,"Основное окно пользователя");
}

echo $html;
?>
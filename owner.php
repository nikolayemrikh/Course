<?php
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
        <li class="active"><a href="/site1/owner.php">Главная</a></li>
        <li><a href="logout.php">Выход</a></li>
      </ul>
    </div>
  </div>
</div>';

//Вывод основного окна для данной роли
function getMainWindow($conn)
{
   $title = 'Главная страница админа';
   $body = '<h1>Основное окно админа</h1>
</form>
<form name="form01" method="post" action="owner.php">
<input type="hidden" name="getScheduleEdit" value="">
</form>
<script type="text/javascript">
<!--
function execMethod(val) {
	self.document.form01.elements[0].name=val;
	self.document.form01.submit();
}
//-->
</script>
<table id="buttons_table">
<tr><td><a href="#" onclick="execMethod(\'getUsersList\'); return false"><i class="icon-list"></i> Список пользователей</a></td></tr>
<tr><td><a href="#" onclick="execMethod(\'getScheduleEdit\'); return false"><i class="icon-edit"></i> Управление расписанием</a></td></tr>
<tr><td><a href="#" onclick="execMethod(\'systemExit\'); return false"><i class="icon-remove"></i> Выйти</a></td></tr>
</table>';



   $html = tplLoad($title,$body);
   return $html;
}



function getScheduleEdit($conn,$message)
{
   $title = 'Управление расписанием';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
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
<input type="submit" name="getEditRoute" class="btn btn-primary" value="Маршруты">
<input type="submit" name="getEditDistance" class="btn btn-primary" value="Дистанции">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}

function getSchDistView($conn,$route_id,$message){
   $title = 'Управление расписанием';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
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


//Вывод окна со списком дистанций с возможностью выбора
function getEditDistance($conn,$message) 
{

$title = 'Список дистанций';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="basic_table" style="float:left;">
<thead>
<tr>
	<th>Расстояние</th>
	<th>Начальная станция</th>
	<th>Конечная станция</th>
	<th>route_id</th>
	<th>select</th>
</tr>
</thead><tbody>';
   $sql = "SELECT * FROM distance";
   $stmt = oci_parse($conn, $sql);
   oci_execute($stmt);
   $i=0;
   while (oci_fetch($stmt)){
      $i++;
	   $d_ID = oci_result($stmt, 'DISTANCE_ID');
	   $d_dist = oci_result($stmt, 'DIST');	  
      $d_firstcity = oci_result($stmt, 'FIRSTCITY');
      $d_lastcity = oci_result($stmt, 'LASTCITY');
	   $d_route_id = oci_result($stmt, 'ROUTE_ID');
      $body .= '<tr>   
<td>'.$d_dist.'</td>
<td>'.$d_firstcity.'</td>
<td>'.$d_lastcity.'</td>
<td>'.$d_route_id.'</td>
<td><input type="radio" name="distance" value="'.$d_ID.'" ';
      if ($_SESSION["reDistance"] != '' && $_SESSION["reDistance"] == $d_ID)
         $body .= 'checked';
      $body .= '></td></tr>';
   }
   $body .= '<tbody>
</table>
<table id="menu_table" style="float:left; table-layout:fixed;">
<tr><td><input type="submit" name="getAddDistance" class="btn btn-primary" value="Добавить новую дистанцию"></td></tr>
<tr><td><input type="submit" name="getEditDistanceRow" class="btn btn-primary" value="Изменить выбранную дистанцию"></td></tr>
<tr><td><input type="submit" name="getDeleteDistance" class="btn btn-primary" value="Удалить выбранную дистанцию"></td></tr>
</table>
<br/>
<table id="buttons_table" style="float:left;">
<tr><td>
<input type="submit" name="getEditRoute" class="btn btn-info" value="Изменить маршруты">
<input type="submit" name="getScheduleEdit" class="btn btn-inverse" value="Вернуться к расписанию">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}


//Вывод окна с формой добавления новой дистанции
function getAddDistance($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id,$message)
{
    $title = 'Добавление новой дистанции';
    $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="input_table">
<tr>
<td>Расстояние:</td>
<td><input type="text" name="d_dist" value="'.$d_dist.'"></td>
</tr>
<tr>
<td>Начальная станция:</td>
<td><input type="text" name="d_firstcity" value="'.$d_firstcity.'"></td>
</tr>
<tr>
<td>Конечная станция:</td>
<td><input type="text" name="d_lastcity" value="'.$d_lastcity.'"></td>
</tr>
<tr>
<td>route_id:</td>
<td><input type="text" name="d_route_id" value="'.$d_route_id.'"></td>
</tr>
<tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getAddDistance" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getEditDistance" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
    $html = tplLoad($title,$body);
    return $html;
}


//Вывод окна с формой редактирования выбранной дистанции
function getEditDistanceRow($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id,$message)
{
   $title = 'Редактирование выбранной дистанции';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="input_table">
<tr>
<td>Расстояние:</td>
<td><input type="text" name="d_dist" value="'.$d_dist.'"></td>
</tr>
<tr>
<td>Начальная станция:</td>
<td><input type="text" name="d_firstcity" value="'.$d_firstcity.'"></td>
</tr>
<tr>
<td>Конечная станция:</td>
<td><input type="text" name="d_lastcity" value="'.$d_lastcity.'"></td>
</tr>
<tr>
<td>route_id:</td>
<td><input type="text" name="d_route_id" value="'.$d_route_id.'"></td>
</tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="EditDistanceRow" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getEditDistance" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}


//Вывод окна со списком маршрутов с возможностью выбора
function getEditRoute($conn,$message) 
{
$title = 'Список маршрутов';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
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
      <th>id</th>
   	<th>select</th>
   </tr>
</thead><tbody>';
   $sql = "SELECT ROUTE_ID, FIRSTCITY, LASTCITY, DT, TPD, INTER, SPEED, DIST FROM route";
   $stmt = oci_parse($conn, $sql);
   oci_execute($stmt);
   $i = 0;
   while (oci_fetch($stmt)){
      $i++;
   	$route_id = oci_result($stmt, 'ROUTE_ID');	  
      $route_firstcity = oci_result($stmt, 'FIRSTCITY');
      $route_lastcity = oci_result($stmt, 'LASTCITY');
   	$route_DT = oci_result($stmt, 'DT');
   	$route_TPD = oci_result($stmt, 'TPD');
   	$route_inter = oci_result($stmt, 'INTER');
   	$route_speed = oci_result($stmt, 'SPEED');
   	$route_dist = oci_result($stmt, 'DIST');
      $body .= '<tr>
         <td>'.$route_firstcity.'</td>
         <td>'.$route_lastcity.'</td>
         <td>'.substr_replace($route_DT,"",17,10).'</td>
         <td>'.$route_TPD.'</td>
         <td>'.substr_replace(substr_replace($route_inter,"",0,11),"",5,7).'</td>
         <td>'.$route_speed.'</td>
         <td>'.$route_dist.'</td>
         <td>'.$route_id.'</td>
         <td><input type="radio" name="route" value="'.$route_id.'" ';
      if ($_SESSION["reRoute"] != '' && $_SESSION["reRoute"] == $route_id)
         $body .= 'checked';
      $body .= '></td></tr>';
   }
   $body .= '<tbody>
</table>
<table id="buttons_table">
   <tr><td>
   <input type="submit" name="getAddRoute" class="btn btn-primary" value="Добавить новый маршрут">
   <input type="submit" name="getEditRouteRow" class="btn btn-primary" value="Изменить выбранный маршрут">
   <input type="submit" name="getDeleteRoute" class="btn btn-primary" value="Удалить выбранный маршрут">
   <input type="submit" name="getEditDistance" class="btn btn-info" value="К изменению дистанций">
   <input type="submit" name="getScheduleEdit" class="btn btn-inverse" value="Вернуться к расписанию">
   </td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}


//Вывод окна с формой добавления нового маршрута
function getAddRoute($conn,$route_firstcity,$route_lastcity,$route_DT,$route_TPD,$route_inter,$route_speed,$message)
{
   $title = 'Добавление нового маршрута';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="input_table">
<tr>
<td>Начальная станция</td>
<td><input type="text" name="route_firstcity" value="'.$route_firstcity.'"></td>
</tr>
<tr>
<td>Конечная станция</td>
<td><input type="text" name="route_lastcity" value="'.$route_lastcity.'"></td>
</tr>
<tr>
<td>Дата и время отправления (ДД.ММ.ГГ ЧЧ:ММ:СС) </td>
<td><input type="text" name="route_DT" value="'.$route_DT.'"></td>
</tr>
<tr>
<td>Раз в день</td>
<td><input type="text" name="route_TPD" value="'.$route_TPD.'"></td>
</tr>
<tr>
<td>Интервал (ЧЧ:ММ)</td>
<td><input type="text" name="route_inter" value="'.$route_inter.'"></td>
</tr>
<tr>
<td>Скорость</td>
<td><input type="text" name="route_speed" value="'.$route_speed.'"></td>
</tr>
<tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getAddRoute" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getEditRoute" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}


//Вывод окна с формой редактирования выбранного маршрута
function getEditRouteRow($conn,$route_firstcity,$route_lastcity,$route_DT,$route_TPD,$route_inter,$route_speed,$message)
{
   $title = 'Редактирование выбранного маршрута';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="input_table">
<tr>
<td>Начальная станция:</td>
<td><input type="text" name="route_firstcity" value="'.$route_firstcity.'"></td>
</tr>
<tr>
<td>Конечная станция:</td>
<td><input type="text" name="route_lastcity" value="'.$route_lastcity.'"></td>
</tr>
<tr>
<td>Дата и время отправления (ДД.ММ.ГГ ЧЧ:ММ:СС)</td>
<td><input type="text" name="route_DT" value="'.$route_DT.'"></td>
</tr>
<tr>
<td>Раз в день</td>
<td><input type="text" name="route_TPD" value="'.$route_TPD.'"></td>
</tr>
<tr>
<td>Интервал (ЧЧ:ММ)</td>
<td><input type="text" name="route_inter" value="'.$route_inter.'"></td>
</tr>
<tr>
<td>Скорость</td>
<td><input type="text" name="route_speed" value="'.$route_speed.'"></td>
</tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="EditRouteRow" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getEditRoute" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}



//Вывод списка всех пользователей с возможностью выбора
function getUsersList($conn,$message)
{
   $title = 'Список пользователей';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="basic_table">
<thead>
<tr>
<th>N</th>
<th>Фамилия И.О.</th>
<th>Логин</th>
<th>Роль</th>
<th>Выбрать</th>
</tr>
</thead><tbody>';
   $sql = "SELECT * FROM person";
   $stmt = oci_parse($conn, $sql);
   oci_execute($stmt);
   $i = 0;
   while (oci_fetch($stmt)){
      $i++;
      $uID = oci_result($stmt, 'ID');
      $userStatus = oci_result($stmt, 'STATUS');
      $firstName = oci_result($stmt, 'FIRSTNAME');
      $lastName = oci_result($stmt, 'LASTNAME');
      $middleName = oci_result($stmt, 'MIDDLENAME');
      $login = oci_result($stmt, 'LOGIN');
      //$password = oci_result($stmt, 'PASSWORD');
      switch ($userStatus) {
      case 1:
         $uStatus = "Хозяин";
         break;
      case 2:
         $uStatus = "Читатель";
         break;
      default :
         $uStatus = "&nbsp";
      }//endswitch
      $body .= '<tr>
<td>'.$i.'</td>
<td>'.$lastName.' '.$firstName.' '.$middleName.'</td>
<td>'.$login.'</td>
<td>'.$uStatus.'</td>
<td>
<input type="radio" name="user" value="'.$uID.'" ';
      if ($_SESSION["reUser"] != '' && $_SESSION["reUser"] == $uID)
         $body .= 'checked';
      $body .= '></td></tr>';
   }//endwhile
   $body .= '<tbody></table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getCreateUser" class="btn btn-primary" value="Создать">
<input type="submit" name="getEditUser" class="btn btn-info" value="Редактировать">
<input type="submit" name="DeleteUser" class="btn btn-info" value="Удалить">
<input type="submit" name="getMainWindow" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}

//Вывод окна с формой создания новой учетной записи
function getCreateUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,$message)
{
   $title = 'Создание учетной записи';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="input_table">
<tr>
<td>* Фамилия:</td>
<td><input type="text" name="lastName" value="'.$lastName.'"></td>
</tr>
<tr>
<td>* Имя:</td>
<td><input type="text" name="firstName" value="'.$firstName.'"></td>
</tr>
<tr>
<td>Отчество:</td>
<td><input type="text" name="middleName" value="'.$middleName.'"></td>
</tr>
<tr>
<td>* Логин (не более 9 символов):</td>
<td><input type="text" name="login" value="'.$login.'"></td>
</tr>
<tr>
<td>* Пароль:</td>
<td><input type="password" name="password" value=""></td>
</tr>
<tr>
<td>* Подтверждение пароля:</td>
<td><input type="password" name="rePassword" value=""></td>
</tr>
<td>Роль:</td>
<td>
<select name="usrStatus">';
if ($_SESSION["login"] == $login && $_SESSION["reUser"] == 1) {
      $body .= '<option value="owner" selected>хозяин</option>';
} else {
   $body .= '<option value="guest"> </option><option value="reader" ';
   if ($uStatus == 2)
      $body .= 'selected';
   $body .= '>читатель</option><option value="owner" ';
   if ($uStatus == 1)
      $body .= 'selected';
   $body .= '>хозяин</option>';
}
$body .= '</select></td>
</tr>
<tr>
<td colspan="2"><b>Символом "*" отмечены обязательные для заполнения поля.</b></td>
</tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getCreateUser" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getUsersList" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}

//Вывод окна с формой редактирования учетной записи
function getEditUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,$message)
{
   $title = 'Редактирование учетной записи';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="owner.php">
<table id="input_table">
<tr>
<td>* Фамилия:</td>
<td><input type="text" name="lastName" value="'.$lastName.'"></td>
</tr>
<tr>
<td>* Имя:</td>
<td><input type="text" name="firstName" value="'.$firstName.'"></td>
</tr>
<tr>
<td>Отчество:</td>
<td><input type="text" name="middleName" value="'.$middleName.'"></td>
</tr>
<tr>
<td>* Логин (не более 9 символов):</td>
<td><input type="text" name="login" value="'.$login.'"></td>
</tr>
<tr>
<td>* Пароль:</td>
<td><input type="password" name="password" value=""></td>
</tr>
<tr>
<td>* Подтверждение пароля:</td>
<td><input type="password" name="rePassword" value=""></td>
</tr>
<tr>
<td>Роль:</td>
<td>
<select name="usrStatus">';
if ($_SESSION["login"] == $login && $_SESSION["reUser"] == 1) {
      $body .= '<option value="owner" selected>хозяин</option>';
} else {
   $body .= '<option value="guest"> </option><option value="reader" ';
   if ($uStatus == 2)
      $body .= 'selected';
   $body .= '>читатель</option><option value="owner" ';
   if ($uStatus == 1)
      $body .= 'selected';
   $body .= '>хозяин</option>';
}
$body .= '</select></td>
</tr>
<tr>
<td colspan="2"><b>Символом "*" отмечены обязательные для заполнения поля.</b></td>
</tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="EditUser" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getUsersList" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
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
} elseif ($_SESSION["status"]!=1){
        header("Location: index.php");
        session_destroy();
        exit;
}

if (@PostContains(usrStatus)) $_SESSION["uStatus"] = $usrStatus;
if (@PostContains(user)) $_SESSION["reUser"] = $user;
if (@PostContains(distance)) $_SESSION["reDistance"] = $distance;
if (@PostContains(route)) $_SESSION["reRoute"] = $route;


$conn = dbConnect();

if ($conn=='') errorMessage("Нет доступа к базе данных.");

//Создание новой учетной записи
if  (@PostContains(getCreateUser)) {
        //Данные были отправлены формой?
        if (@PostContains(lastName) && @PostContains(firstName) && @PostContains(middleName) &&
            @PostContains(login) && @PostContains(password) && @PostContains(rePassword) && 
            $_SESSION["reUser"] && $_SESSION["uStatus"]){
                //Для корректного выполнения SQL-запроса
                $rlastName=replaceSQLChars($lastName);                        $rfirstName=replaceSQLChars($firstName);
                $rmiddleName=replaceSQLChars($middleName);                    $rlogin=replaceSQLChars($login);
                $rpassword=md5($password);
                //Для корректного отображения введенных данных в полях формы
                $lastName=replaceHTMLChars($lastName);                        $firstName=replaceHTMLChars($firstName);
                $middleName=replaceHTMLChars($middleName);                    $login=replaceHTMLChars($login);
                $password=md5($password);                                     $rePassword=md5($rePassword);
                  //Проверка заполнения обязательных полей формы регистрации и совпадения пароля с подтверждением
                if ($lastName!='' && $firstName!='' && $login!='' && $password!='' && $password==$rePassword){
                        //Проверка уникальности введенного логина
                        $sql="SELECT count(login) AS c FROM person WHERE login='$rlogin'";
                        $stmt = @oci_parse($conn,$sql);
                          $mess = @oci_execute($stmt);
                        if (!$mess) errorMessage("Произошла ошибка при выполнении операции.");
                        if(oci_fetch($stmt)){$c = oci_result($stmt, 'C');}
                        //Если логин уникален, то внести информацию в БД
                        if ($c==0) {
                                switch ($_SESSION["uStatus"]) {
                                        case "reader":
                                                $userStatus = 2;
                                        break;
                                        case "owner":
                                                $userStatus = 1;
                                        break;
                                        default:
                                                $userStatus = NULL;
                                }//endswitch
                                $sql="INSERT INTO person (lastName,firstName,middleName,login,password,status)
                                                          VALUES ('$rlastName','$rfirstName','$rmiddleName','$rlogin','$rpassword','$userStatus')";
                                  $stmt = @oci_parse($conn,$sql);
                                  $mess = @oci_execute($stmt);
                                  // Обрабатываем исключительные ситуации
                                  if(!$mess) {
                                        @oci_rollback($conn);
                                        $html = getCreateUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Некорректные данные");
                                   } else {
                                        $html = getUsersList($conn,"Запись успешно добавлена");
                                }
                        } else {
                                $html = getCreateUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Неуникальный логин");
                        }
                } else {
                                $html = getCreateUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Не заполнены обязательные поля или<br>некорректные данные");
                }
        } else {
                $html = getCreateUser($conn,"","","","","","Создание учетной записи");
        }

//Отобразить форму для редактирования учетной записи с параметрами выбранного пользователя
} elseif (@PostContains(getEditUser)) {
        if ($_SESSION["reUser"]!="") {
                $reUser = $_SESSION["reUser"];
                $sql="SELECT * FROM person WHERE id='$reUser'";
                $stmt = oci_parse($conn, $sql);
                oci_execute($stmt);
                $i = 0;
                while (oci_fetch($stmt)){
                        $i++;
                        $uStatus = oci_result($stmt, 'STATUS');
                        $firstName = oci_result($stmt, 'FIRSTNAME');
                        $lastName = oci_result($stmt, 'LASTNAME');
                        $middleName = oci_result($stmt, 'MIDDLENAME');
                        $login = oci_result($stmt, 'LOGIN');
                        //$password = oci_result($stmt, 'PASSWORD');
                        switch ($uStatus) {
                                case 1:
                                        $userStatus = "Хозяин";
                                break;
                                case 2:
                                        $userStatus = "Читатель";
                                break;
                                default :
                                        $userStatus = "&nbsp";
                        }//endswitch
                }
                //$rePassword = $password;
                $html = getEditUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Редактирование учетной записи");
        } else {
                $html = getUsersList($conn,"Не выбран пользователь");
        }

//Редактирование выбранной учетной записи
} elseif (@PostContains(EditUser)) {
        if (@PostContains(lastName) && @PostContains(firstName) && @PostContains(middleName) &&
                        @PostContains(login) && @PostContains(password) && @PostContains(rePassword) &&
                        $_SESSION["reUser"] && $_SESSION["uStatus"]) {
                //Для корректного выполнения SQL-запроса
                $rlastName=replaceSQLChars($lastName);                        $rfirstName=replaceSQLChars($firstName);
                $rmiddleName=replaceSQLChars($middleName);                    $rlogin=replaceSQLChars($login);
                $rpassword=replaceSQLChars($password);
                //Для корректного отображения введенных данных в полях формы
                $lastName=replaceHTMLChars($lastName);                        $firstName=replaceHTMLChars($firstName);
                $middleName=replaceHTMLChars($middleName);                    $login=replaceHTMLChars($login);
                $password=md5($password);                                     $rePassword=md5($rePassword);
                  //Проверка заполнения обязательных полей формы регистрации и совпадения пароля с подтверждением
                if ($lastName!='' && $firstName!='' && $login!='' && $password==$rePassword){
                        //Проверка уникальности введенного логина
                        $reUser = $_SESSION["reUser"];
                        $sql="SELECT count(login) AS c FROM person WHERE login='$rlogin' and not(id='$reUser')";
                        $stmt = oci_parse($conn,$sql);
                          $mess = oci_execute($stmt);
                        if (!$mess) errorMessage("Произошла ошибка при выполнении операции.");
                        if(oci_fetch($stmt)){$c = oci_result($stmt, 'C');}
                        //Если логин уникален, то обновить информацию в БД
                        if ($c==0) {
                                switch ($_SESSION["uStatus"]) {
                                        case "reader":
                                                $userStatus = 2;
                                        break;
                                        case "owner":
                                                $userStatus = 1;
                                        break;
                                        default:
                                                $userStatus = NULL;
                                }//endswitch
                                $reUser = $_SESSION["reUser"];
            if ($rpassword!='') {
                                 $sql="UPDATE person SET lastName='$rlastName',firstName='$rfirstName',middleName='$rmiddleName',login='$rlogin',password='$password',status='$userStatus'
                                                WHERE id='$reUser'";
            } else {
               $sql="UPDATE person SET lastName='$rlastName',firstName='$rfirstName',middleName='$rmiddleName',login='$rlogin',status='$userStatus'
                                                WHERE id='$reUser'";
            }
                                $stmt = oci_parse($conn,$sql);
                                $mess = oci_execute($stmt);
                                // Обрабатываем исключительные ситуации
                                if(!$mess) {
                                      @oci_rollback($conn);
                                      $html = getEditUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Некорректные данные");
                                 } else {
                                      $html = getUsersList($conn,"Запись успешно изменена");
                                      $_SESSION["reUser"] = "";
                                 }
                        } else {
                                $html = getEditUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Неуникальный логин");
                        }
                } else {
                                $html = getEditUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Не заполнены обязательные поля или<br>некорректные данные");
                }
        } else {
                $html = getEditUser($conn,$lastName,$firstName,$middleName,$login,$uStatus,"Редактирование учетной записи");
        }

//Удаление выбранной учетной записи
} elseif (@PostContains(DeleteUser)) {
        if ($_SESSION["reUser"]!="") {
                $reUser = $_SESSION["reUser"];
                $sql="DELETE FROM person WHERE id='$reUser'";
                  $stmt = @oci_parse($conn,$sql);
                  $mess = @oci_execute($stmt);
                          // Обрабатываем исключительные ситуации
                          if(!$mess) {
                                @oci_rollback($conn);
                                $html = getUsersList($conn,"Произошла ошибка при удалении пользователя");
                           } else {
                                $html = getUsersList($conn,"Пользователь успешно удален");
                                $_SESSION["reUser"] = "";
                        }
        } else {
                $html = getUsersList($conn,"Не выбран пользователь");
        }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Добавление новой дистанции
} elseif (@PostContains(getAddDistance)) {
	 if (@PostContains(d_dist) && @PostContains(d_firstcity) && @PostContains(d_lastcity) && @PostContains(d_route_id)) {
        $rd_dist=replaceSQLChars($d_dist);
        $rd_firstcity=replaceSQLChars($d_firstcity);
        $rd_lastcity=replaceSQLChars($d_lastcity);
        $rd_route_id=replaceSQLChars($d_route_id);
        $d_dist=replaceHTMLChars($d_dist);
        $d_firstcity=replaceHTMLChars($d_firstcity);
        $d_lastcity=replaceHTMLChars($d_lastcity);
        $d_route_id=replaceHTMLChars($d_route_id);
                                 if ($d_dist!='' && $d_firstcity!='' && $d_lastcity!='' && $d_route_id!='') {
                                $sql="INSERT INTO distance (DIST, FIRSTCITY, LASTCITY, ROUTE_ID) VALUES ('$rd_dist','$rd_firstcity','$rd_lastcity','$rd_route_id')";
                                  $stmt = oci_parse($conn,$sql);
                                  $mess = oci_execute($stmt);
                                  // Обрабатываем исключительные ситуации
                                 if(!$mess) {
                                       print_r ($rd_dist); print_r($rd_firstcity); print_r($rd_lastcity); print_r($rd_route_id);
                                       print_r ($d_dist); print_r($d_firstcity); print_r($d_lastcity); print_r($d_route_id);
                                       print_r($_POST);
                                        @oci_rollback($conn);
                                        $html = getAddDistance($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id, "Некорректные данные");
                                 } else {
									         $html = getEditDistance($conn,"Дистанция успешно добавлена");
                                    $d_dist = ""; $d_firstcity=""; $d_lastcity=""; $d_route_id="";
								   }
                        } else {
                           $html = getAddDistance($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id,"Отсутствуют данные");
                        }
			} else {
				$html = getAddDistance($conn,"","","","","Добавление новой дистанции");
			}

//Отобразить форму для редактирования выбранной дистанции с параметрами выбранной дистанции
} elseif (@PostContains(getEditDistanceRow)) {
		if ($_SESSION["reDistance"]!="") {
            $reDistance = $_SESSION["reDistance"];
				$sql="SELECT * FROM distance WHERE DISTANCE_ID='$reDistance'";
                $stmt = oci_parse($conn, $sql);
                oci_execute($stmt);
                while (oci_fetch($stmt)){
						   $d_dist = oci_result($stmt, 'DIST');
						   $d_firstcity = oci_result($stmt, 'FIRSTCITY');
						   $d_lastcity = oci_result($stmt, 'LASTCITY');
						   $d_route_id = oci_result($stmt, 'ROUTE_ID');              
                }
                $html = getEditDistanceRow($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id,"Редактирование выбранной дистанции");
		} else {
			$html = getEditDistance($conn, "Не выбрана дистанция");
		}
//Редактирование выбранной дистанции
} elseif (@PostContains(EditDistanceRow)) {
    if (@PostContains(d_dist) && @PostContains(d_firstcity) && @PostContains(d_lastcity) && @PostContains(d_route_id)) {
        $rd_dist=replaceSQLChars($d_dist);
        $rd_firstcity=replaceSQLChars($d_firstcity);
        $rd_lastcity=replaceSQLChars($d_lastcity);
        $rd_route_id=replaceSQLChars($d_route_id);
        $d_dist=replaceHTMLChars($d_dist);
        $d_firstcity=replaceHTMLChars($d_firstcity);
        $d_lastcity=replaceHTMLChars($d_lastcity);
        $d_route_id=replaceHTMLChars($d_route_id);

      $reDistance = $_SESSION["reDistance"];
      $sql="UPDATE distance SET DIST='$rd_dist',FIRSTCITY='$rd_firstcity',LASTCITY='$rd_lastcity',ROUTE_ID='$rd_route_id'
                            WHERE DISTANCE_ID='$reDistance'";
             $stmt = oci_parse($conn,$sql);
             $mess = oci_execute($stmt);
             if(!$mess) {
               @oci_rollback($conn);
               $html = getEditDistanceRow($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id, "Некорректные данные");
            } else {
               $html = getEditDistance($conn,"Запись успешно изменена"); 
               $reDistance = "";      
            }
			} else {
            $html = getEditDistanceRow($conn,$d_dist,$d_firstcity,$d_lastcity,$d_route_id,"Не удалось выбранной дистанции");

         }

//Удаление выбранной дистанции
} elseif (@PostContains(getDeleteDistance)) {
		if ($_SESSION["reDistance"]!="") {
                  $reDistance = $_SESSION["reDistance"];
                  $sql="DELETE FROM distance WHERE DISTANCE_ID='$reDistance'";
                  $stmt = @oci_parse($conn,$sql);
                  $mess = @oci_execute($stmt);
                          // Обрабатываем исключительные ситуации
                          if(!$mess) {
                                @oci_rollback($conn);
                                $html = getEditDistance($conn,"Произошла ошибка при удалении дистанции");
                           } else {
                                $html = getEditDistance($conn,"Дистанция успешно удалена");
                                $reDistance = "";
                        }
		}
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	//Добавление нового маршрута
	} elseif (@PostContains(getAddRoute)) {
		if (@PostContains(route_firstcity) && @PostContains(route_lastcity) &&
       @PostContains(route_DT) && @PostContains(route_TPD) && @PostContains(route_inter) && @PostContains(route_speed)){
         $rroute_firstcity=replaceSQLChars($route_firstcity);
        $rroute_lastcity=replaceSQLChars($route_lastcity);
        $rroute_DT=replaceSQLChars($route_DT);
        $rroute_TPD=replaceSQLChars($route_TPD);
         $rroute_inter=replaceSQLChars($route_inter);
        $rroute_speed=replaceSQLChars($route_speed);

        $route_firstcity=replaceHTMLChars($route_firstcity);
        $route_lastcity=replaceHTMLChars($route_lastcity);
        $route_DT=replaceHTMLChars($route_DT);
        $route_TPD=replaceHTMLChars($route_TPD);
        $route_inter=replaceHTMLChars($route_inter);
        $route_speed=replaceHTMLChars($route_speed);
        $rroute_inter='+0 ' . $rroute_inter . ":00";
         if ($route_firstcity!='' && $route_lastcity!='' && $route_DT!='' && $route_TPD!='' && $route_inter!='' && $route_speed!='') {
				$sql="INSERT INTO route (FIRSTCITY, LASTCITY, DT,  TPD, INTER, SPEED) VALUES ('$rroute_firstcity', '$rroute_lastcity', '$rroute_DT', '$rroute_TPD', '$rroute_inter', '$rroute_speed')";
                $stmt = oci_parse($conn, $sql);
                $mess = oci_execute($stmt);
                 if(!$mess) {
                                        @oci_rollback($conn);
                                        $html = getAddRoute($conn, $route_firstcity, $route_lastcity, $route_DT, $route_TPD, $route_inter, $route_speed,  "Некорректные данные");
                                        print_r($_POST);
                                   } else {
									   $html = getEditRoute($conn,"Запись успешно добавлена");
								   }
         } else {
            $html = getAddRoute($conn, $route_firstcity, $route_lastcity, $route_DT, $route_TPD, $route_inter, $route_speed,"Отсутствуют данные");
         }
			} else {
				$html = getAddRoute($conn,"","","","","","","Добавление нового маршрута");
			}
//Отобразить форму для редактирования выбранного маршрута
} elseif (@PostContains(getEditRouteRow)) {
		if ($_SESSION["reRoute"]!="") {
            $reRoute = $_SESSION["reRoute"];
				$sql="SELECT * FROM route WHERE ROUTE_ID='$reRoute'";
                $stmt = oci_parse($conn, $sql);
                oci_execute($stmt);
                while (oci_fetch($stmt)){
						  $route_firstcity = oci_result($stmt, 'FIRSTCITY');
						  $route_lastcity = oci_result($stmt, 'LASTCITY');
						  $route_DT = oci_result($stmt, 'DT'); 
						  $route_TPD = oci_result($stmt, 'TPD');
						  $route_inter = oci_result($stmt, 'INTER');
						  $route_speed = oci_result($stmt, 'SPEED');					  
                }
                $html = getEditRouteRow($conn,$route_firstcity,$route_lastcity,substr_replace($route_DT,"",17,10),$route_TPD,substr_replace(substr_replace($route_inter,"",0,11),"",5,7),$route_speed,"Редактирование выбранного маршрута");
		} else {
         $html = getEditRoute($conn, "Не выбран маршрут");
      }
//Редактирование выбранного маршрута
} elseif (@PostContains(EditRouteRow)) {
   if (@PostContains(route_firstcity) && @PostContains(route_lastcity) &&
            @PostContains(route_DT) && @PostContains(route_TPD) && @PostContains(route_inter) && @PostContains(route_speed)){
         $rroute_firstcity=replaceSQLChars($route_firstcity);
        $rroute_lastcity=replaceSQLChars($route_lastcity);
        $rroute_DT=replaceSQLChars($route_DT);
        $rroute_TPD=replaceSQLChars($route_TPD);
         $rroute_inter=replaceSQLChars($route_inter);
        $rroute_speed=replaceSQLChars($route_speed);

        $route_firstcity=replaceHTMLChars($route_firstcity);
        $route_lastcity=replaceHTMLChars($route_lastcity);
        $route_DT=replaceHTMLChars($route_DT);
        $route_TPD=replaceHTMLChars($route_TPD);
        $route_inter=replaceHTMLChars($route_inter);
        $route_speed=replaceHTMLChars($route_speed);
        $rroute_inter='+0 ' . $rroute_inter . ":00";
      $reRoute = $_SESSION["reRoute"];
      $sql="UPDATE route SET FIRSTCITY='$rroute_firstcity',LASTCITY='$rroute_lastcity',DT='$rroute_DT',TPD='$rroute_TPD',INTER='$rroute_inter',SPEED='$rroute_speed'
             WHERE ROUTE_ID='$reRoute'";            
             $stmt = oci_parse($conn,$sql);
             $mess = oci_execute($stmt);  
             if(!$mess) { echo($rroute_inter);
             @oci_rollback($conn);
             $html = getEditRouteRow($conn,$route_firstcity,$route_lastcity,$route_DT,$route_TPD,$route_inter,$route_speed,"Некорректные данные");                              
             } else {
             $html = getEditRoute($conn,"Запись успешно изменена");
             $reRoute = "";
         }
      } else {
         $html = getEditRouteRow($conn,$route_firstcity,$route_lastcity,$route_DT,$route_TPD,$route_inter,$route_speed,"Редактирование выбранного маршрута");
      }

//Удаление выбранного маршрута
} elseif (@PostContains(getDeleteRoute)) {
		if ($_SESSION["reRoute"]!="") {
                  $reRoute = $_SESSION["reRoute"];
                  $sql="DELETE FROM route WHERE ROUTE_ID='$reRoute'";
                  $stmt = @oci_parse($conn,$sql);
                  $mess = @oci_execute($stmt);
                          // Обрабатываем исключительные ситуации
                          if(!$mess) {
                                @oci_rollback($conn);
                                $html = getEditRoute($conn,"Произошла ошибка при удалении маршрута");
                           } else {
                                $html = getEditRoute($conn,"Маршрут успешно удален");
                                $reRoute = "";
                        }
		}
} elseif (@PostContains(getScheduleEdit)) {
        $html = getScheduleEdit($conn,"Управление расписанием");

} elseif (@PostContains(getEditRoute)) {
        $html = getEditRoute($conn,"Управление маршрутами");	

}elseif (@PostContains(getEditDistance)) {
         $html = getEditDistance($conn,"Управление дистанциями");

}elseif (@PostContains(getSchDistView)) {
   @PostContains(getSchDistView);
         $html = getSchDistView($conn,$getSchDistView,"Маршрут");


}elseif (@PostContains(getUsersList)) {
   $html = getUsersList($conn,"Список пользователей");

//Выход
} elseif (@PostContains(systemExit)) {
        session_destroy();
        header("Location: index.php");
        exit;
} else {
        $html = getMainWindow($conn);
}

echo $html;
?>
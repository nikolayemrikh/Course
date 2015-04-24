<?php

error_reporting(E_ALL);
include("lib.php");


function getMainWindow($conn)
{
   $title = 'Расписание';
   $body = '<h1>Расписание</h1>
<table cellspacing="50" id="basic_table">
<thead>
<tr>
	<th>N</th>
	<th>Начальная станция</th>
	<th>Конечная станция</th>
	<th>В пути</th>
	<th>Отправление</th>
	<th>Прибытие</th>
	<th>Расстояние</th>
	<th>ID марштура</th>
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
      $body .= '<tr>
<td>'.$i.'</td>
<td>'.$firstcity.'</td>
<td>'.$lastcity.'</td>
<td>'.convertToHoursMins($travel_time,'%02d часов %02d минут').'</td>
<td>'.$DT.'</td>
<td>'.$AT.'</td>
<td>'.$dist.'</td>
<td>'.$route_id.'</td>
</tr>';
   }
   $body .= '</tbody>
</table>
<form name="form01" method="post" action="index.php">
<table id="buttons_table">
<tr><td>
<input type="submit" name="getLogonWindow" class="btn btn-primary" value="Войти в систему">
<input type="submit" name="getRegWindow" class="btn btn-info" value="Зарегистрироваться">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}
//<td>'.convertToHoursMins($travel_time,'%02d часов %02d минут').'</td>
//Вывод окна с формой авторизации
function getLogonWindow($conn,$login,$message)
{
   $title = 'Авторизация';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="index.php">
<table id="input_table">
<tr>
<td>Логин:</td>
<td><input type="text" name="login" value="'.$login.'"></td>
</tr>
<tr>
<td>Пароль:</td>
<td><input type="password" name="password" value=""></td>
</tr>
<tr>
<td>Роль:</td>
<td><select name="rule">
<option value="2">Пользователь</option>
<option value="1">Админ</option>
</select></td>
</tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getLogonWindow" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getStartWindow" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}

//Вывод окна с формой регистрации
function getRegWindow($conn,$lastName,$firstName,$middleName,$login,$message)
{
   $title = 'Регистрация';
   $body = '<h1>'.$message.'</h1>
<form name="form01" method="post" action="index.php">
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
<td><input type="password" name="password" value="'.$password.'"></td>
</tr>
<tr>
<td>* Подтверждение пароля:</td>
<td><input type="password" name="rePassword" value="'.$rePassword.'"></td>
</tr>
<tr>
<td colspan="2"><b>Символом "*" отмечены обязательные для заполнения поля.</b</td>
</tr>
</table>
<table id="buttons_table">
<tr><td>
<input type="submit" name="getRegWindow" class="btn btn-primary" value=" ОК ">
<input type="submit" name="getStartWindow" class="btn btn-inverse" value="Вернуться назад">
</td></tr>
</table>
</form>';
   $html = tplLoad($title,$body);
   return $html;
}


$conn = dbConnect();
if ($conn=='') errorMessage("Нет доступа к базе данных.");
//Если было вызвано окно авторизации
if (@PostContains(getLogonWindow)){
        //Пользователь указал логин и пароль?
        if (@PostContains(login) && @PostContains(password) && @PostContains(rule)) {
                $rlogin=replaceSQLChars($login);
                $rpassword=md5($password);
                $login=replaceHTMLChars($login);
                $rule=replaceHTMLChars($rule);
                $sql="SELECT id, login, password, status FROM person WHERE login='$rlogin' and password='$rpassword'";
                $stmt = @oci_parse($conn, $sql);
                @oci_execute($stmt);
                if (oci_fetch($stmt)){
			if(oci_result($stmt, 'PASSWORD') == $rpassword //Проверка пароля
				&& oci_result($stmt, 'LOGIN') == $rlogin //Проверка на инъекцию
			){
		                $status = oci_result($stmt, 'STATUS');
				if ($status == '1' && ($rule == '1' || $rule == '2')) $status=$rule;
		                $userID = oci_result($stmt, 'ID');

				//Проверка роли пользователя
		                switch ($status){
		                        case 1:
		                                session_start();
		                                $_SESSION["userID"] = $userID;
						$_SESSION["login"] = $login;
		                                $_SESSION["status"] = $status;
		                                $_SESSION["reUser"] = "";
		                                $_SESSION["uStatus"] = "";
		                                $_SESSION["reDistance"] = "";
		                                $_SESSION["reRoute"] = "";
                                    $_SESSION["reSch"]= "";
		                              header("Location: owner.php");
		                                $sql="INSERT INTO logon_ (person,ipAddress,date_) values ('$userID','".$_SERVER["REMOTE_ADDR"]."',sysdate)";
		                                  $stmt = oci_parse($conn, $sql);
		                                oci_execute($stmt);
		                             exit;
		                        case 2:
		                                session_start();
		                                $_SESSION["userID"] = $userID;
						$_SESSION["login"] = $login;
		                                $_SESSION["status"] = $status;
		                              header("Location: user.php");
		                                $sql="INSERT INTO logon_ (person,ipAddress,date_) values ('$userID','".$_SERVER["REMOTE_ADDR"]."',sysdate)";
		                                  $stmt = oci_parse($conn, $sql);
		                                oci_execute($stmt);
		                             exit;
		                        default:
		                                $html = getLogonWindow($conn,$login,"Неправильно указаны параметры учетной записи.<br> Повторите еще раз:");
		                } //endswitch
			}//endif
                }//endif
                $html = getLogonWindow($conn,$login,"Неправильно указаны параметры учетной записи.<br> Повторите еще раз:");
        } else {
                $html = getLogonWindow($conn,"","Вход в систему");
        }
} elseif (@PostContains(getRegWindow)){
        if (@PostContains(lastName) && @PostContains(firstName) && @PostContains(middleName) &&
                        @PostContains(login) && @PostContains(password) && @PostContains(rePassword)) {
                //Для корректного выполнения SQL-запроса
                $rlastName=replaceSQLChars($lastName);                     $rfirstName=replaceSQLChars($firstName);
                $rmiddleName=replaceSQLChars($middleName);                 $rlogin=replaceSQLChars($login);
                $rpassword=replaceSQLChars($password);
                //Для корректного отображения введенных данных в полях формы
                $lastName=replaceHTMLChars($lastName);                     $firstName=replaceHTMLChars($firstName);
                $middleName=replaceHTMLChars($middleName);                 $login=replaceHTMLChars($login);
                $password=replaceHTMLChars($password);                                  $rePassword=replaceHTMLChars($rePassword);
          //Проверка заполнения обязательных полей формы регистрации и совпадения пароля с подтверждением
          if ($lastName!='' && $login!='' && $password!='' && $password==$rePassword){
                        $sql="SELECT count(login) AS c FROM person WHERE login='$rlogin'";
                        $stmt = @oci_parse($conn,$sql);
                        $mess = @oci_execute($stmt);
                        if (!$mess) errorMessage("Произошла ошибка при выполнении операции");
                        if(oci_fetch($stmt)){$c = oci_result($stmt, 'C');}
                        //Проверка уникальности введенного логина
                        if ($c==0) {
                                $sql="INSERT INTO person (lastName,firstName,middleName,login,password,status)
                                                          VALUES ('$rlastName','$rfirstName','$rmiddleName','$rlogin','$rpassword',2)";
                          $stmt = @oci_parse($conn,$sql);
                          $mess = @oci_execute($stmt);
                          // Обрабатываем исключительные ситуации
                                  if(!$mess) {
                                        @oci_rollback($conn);
                                        $html = getRegWindow($conn,$lastName,$firstName,$middleName,$login,"Некорректные данные");
                                   } else {
                                        $html = getMainWindow($conn);
                                }
                        } else {
                                $html = getRegWindow($conn,$lastName,$firstName,$middleName,$login,"Неуникальный логин");
                        }
          } else {
                        $html = getRegWindow($conn,$lastName,$firstName,$middleName,$login,"Не заполнены обязательные поля или<br>некорректные данные");
          }
        } else {
                $html = getRegWindow($conn,"","","","","Форма регистрации");
        }
} else {

        $html = getMainWindow($conn);
}

echo $html;

?>
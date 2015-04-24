	<?php

define("ROOT", dirname(__FILE__));
define("TEMPLATE", "main");
function dbConnect()
{
   $conn = @oci_connect('u0026', 'rku801', 'de.ifmo.ru:3521/xe');
   return $conn;
}

function dbDisconnect()
{
   @oci_close($conn);
}

function tplLoad($title,$body)
{
   if( !file_exists(ROOT . '/template/' . TEMPLATE . '.tpl') ) exit("Ошибка загрузки шаблона!");
   $html = file_get_contents(ROOT . '/template/' . TEMPLATE . '.tpl');
   $html = str_replace('{title}', $title, $html);
   $html = str_replace('{body}', $body, $html);
   return $html;
}

function dateCheck($beginDate, $endDate)
{
   //определение текущих дня, месяца и года
   $sysDay=date("d");
   $sysMonth=date("m");
   $sysYear=date("Y");
   //выделение из введенных дат дня, месяца и года
   $bDay=substr($beginDate,0,2);
   $bMonth=substr($beginDate,3,2);
   $bYear=substr($beginDate,6,4);
   $eDay=substr($endDate,0,2);
   $eMonth=substr($endDate,3,2);
   $eYear=substr($endDate,6,4);
   //проверка того, являются ли введенные данные датами
   $begin = (@checkdate($bMonth,$bDay,$bYear));
   $end = (@checkdate($eMonth,$eDay,$eYear));
   $check = 0;
   if ($begin && $end) {
      $sys = false;
      //дата начала должна быть больше текущей
      if ($bYear > $sysYear) $sys = true;
      if (($bYear == $sysYear) && ($bMonth > $sysMonth)) $sys = true;
      if (($bYear == $sysYear) && ($bMonth == $sysMonth) && ($bDay > $sysDay)) $sys = true;

      if ($sys) {
         //дата окончания должна быть больше даты начала
         if ($eYear > $bYear) $check = 1;
         if (($eYear == $bYear) && ($eMonth > $bMonth)) $check = 1;
         if (($eYear == $bYear) && ($eMonth == $bMonth) && ($eDay > $bDay)) $check = 1;
      }
   }
   return $check;
}
//Вывод окна с сообщением об ошибке
function errorMessage($message)
{
   $title = 'Ошибка!';
   $body = '<h1>'.$message.'</h1>';
   $html = tplLoad($title,$body);
   echo '<p id="error" align="center"><img src="/site1/template/nichosi.png" width="527" height="310" alt="Nichosi"></p>';
   echo $html;
   exit;
}

//Для предотвращения ошибок при внесении информации в БД
function replaceSQLChars($str)
{
        $str = str_replace("\'", "''", $str);
        $str = str_replace("\\\"", "\"", $str);
        $str = str_replace("\\\\", "\\", $str);
        return $str;
}

//Для предотвращения ошибок при отображении данных в полях формы
function replaceHTMLChars($str)
{
        $str = str_replace("\'", "'", $str);
        $str = str_replace("\\\"", "\"", $str);
        $str = str_replace("\\\\", "\\", $str);
        //Преобразование специальных символов в HTML-сущности
        $str = htmlSpecialChars($str);
        return $str;
}


function PostContains($whattoget)
{
	if (isset($_POST[$whattoget]))
	{
		global ${$whattoget};
		${$whattoget} = $_POST[$whattoget];
		return true;
	}
	else
        {
        	return false;
	}

}

function convertToHoursMins($time, $format = '%d:%d') {
    settype($time, 'integer');
    if ($time < 1) {
        return;
    }
    $hours = floor($time / 60);
    $minutes = ($time % 60);
    return sprintf($format, $hours, $minutes);
}


?>

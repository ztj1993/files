<?php
/**
 * Curl 循环调用脚本
 */

empty($_GET['query']) && $_GET['query'] = null;

/**
 * Curl 调用
 * @param $query
 */
function curl_call($query)
{
    $url = "http://{$_SERVER['HTTP_HOST']}{$_SERVER['PHP_SELF']}?query={$query}";
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_CUSTOMREQUEST => "GET",
    ));
    $response = curl_exec($curl);
    $err = curl_error($curl);
    curl_close($curl);
    if ($err) {
        echo "cURL Error #:" . $err;
    } else {
        echo $response;
    }
}

switch ($_GET['query']) {
    case 'a':
        echo 'aaa';
        curl_call('b');
        break;
    case 'b':
        echo 'bbb';
        curl_call('c');
        break;
    case 'c':
        echo 'ccc';
        break;
    default:
        echo 'empty';
        curl_call('a');
        break;
}

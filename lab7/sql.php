
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Database connector</title>
</head>
<body>
    <h1>2014308140 이민혁</h1>
    <?php 

    $db = "mysql";
    $host = "127.0.0.1";
    $username = "root";
    $password = "password";
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // 파라미터
        $name = $_POST["name"]; // imdb_small
        $query = $_POST["query"]; // select role from `roles` join `movies` on roles.movie_id = id where name = 'Pi';
        if (empty($name)) echo "Name is empty<br>"; else echo "name: $name<br>";
        if (empty($query)) echo "Query is empty<br>"; else echo "query: $query<br>";

        // 데이터베이스 연결 및 쿼리
        try {            
            $db = new PDO("$db:dbname=$name;host=$host", $username, $password);
            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $rows = $db->query($query);
            foreach ($rows as $row) { ?>
                <li> role: <?= $row["role"] ?> </li>
            <?php }
        } catch (PDOException $ex) { ?>
            <p>Database error occurred please try again</p>
            <p>error message: <?= $ex ?></p>
        <?php } 
        } ?>
</body>
</html>


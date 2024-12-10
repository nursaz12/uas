<?php
$connection = new mysqli("localhost","root","","recipes");
$data = mysqli_query($connection, "select * from recipes");
$data = mysqli_fetch_all($data, MYSQLI_ASSOC);
echo json_encode($data);
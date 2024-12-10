<?php
$connection = new mysqli("localhost","root","","recipes");
$data = mysqli_query($connection, "select * from recipes where
id=".$_GET['id']);
$data = mysqli_fetch_array($data, MYSQLI_ASSOC);
echo json_encode($data);
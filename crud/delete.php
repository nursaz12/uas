<?php
// Create a connection to the MySQL database
$connection = new mysqli("localhost", "root", "", "recipes");

// Check if the connection is successful
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

// Debug: Print the POST data
error_log(print_r($_POST, true));

// Validate and get data from the POST request
$id = isset($_POST['id']) ? $_POST['id'] : null;

// Check if the ID is available
if ($id) {
    // Prepare the SQL query to delete data from the database
    $query = "DELETE FROM recipes WHERE id='$id'";

    // Execute the query
    $result = mysqli_query($connection, $query);

    // Check if the query was successful
    if ($result) {
        echo json_encode(['message' => 'Data deleted successfully']);
    } else {
        echo json_encode(['message' => 'Data failed to delete', 'error' => mysqli_error($connection)]);
    }
} else {
    echo json_encode(['message' => 'Missing required data', 'post_data' => $_POST]);
}
?>

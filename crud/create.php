<?php
// Create a connection to the MySQL database
$connection = new mysqli("localhost", "root", "", "recipes");

// Check if the connection is successful
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

// Log POST data for debugging
error_log(print_r($_POST, true));
error_log(print_r($_FILES, true));

// Get data from the POST request
$title = $_POST['title'];
$ingredients = $_POST['ingredients'];
$instructions = $_POST['instructions'];
$category = $_POST['category'];
$image_path = "";

// Check if the file is uploaded successfully
if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
    // Define the target file path for the uploaded image
    $image_path = 'uploads/' . basename($_FILES['image']['name']);
    $target_file = __DIR__ . '/' . $image_path;

    // Ensure the target directory exists
    if (!is_dir(dirname($target_file))) {
        mkdir(dirname($target_file), 0777, true); // Create the directory if it doesn't exist
    }

    // Move the uploaded file to the target directory
    if (!move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
        echo json_encode(['message' => 'File upload failed']);
        return;
    }
}

// Prepare the SQL query to insert data into the database
$query = "INSERT INTO recipes (title, ingredients, instructions, category, image) 
          VALUES ('$title', '$ingredients', '$instructions', '$category', '$image_path')";

// Execute the query
$result = mysqli_query($connection, $query);

// Check if the query was successful
if ($result) {
    echo json_encode(['message' => 'Data input successfully']);
} else {
    echo json_encode(['message' => 'Data Failed to input', 'error' => mysqli_error($connection)]);
}
?>

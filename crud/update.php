<?php
// Create a connection to the MySQL database
$connection = new mysqli("localhost", "root", "", "recipes");

// Check if the connection is successful
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

// Validate and get data from the POST request
$id = isset($_POST['id']) ? $_POST['id'] : null;
$title = isset($_POST['title']) ? $_POST['title'] : null;
$ingredients = isset($_POST['ingredients']) ? $_POST['ingredients'] : null;
$instructions = isset($_POST['instructions']) ? $_POST['instructions'] : null;
$category = isset($_POST['category']) ? $_POST['category'] : null;

// Check if all required data is available
if ($id && $title && $ingredients && $instructions && $category) {
    // Initialize the query without the image part
    $query = "UPDATE recipes SET title='$title', ingredients='$ingredients', instructions='$instructions', category='$category'";

    // Check if the file is uploaded successfully
    if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
        // Define the target directory and file path for the uploaded image
        $image_path = 'uploads/' . basename($_FILES['image']['name']);
        $target_file = __DIR__ . '/' . $image_path;

        // Ensure the target directory exists
        if (!is_dir(dirname($target_file))) {
            mkdir(dirname($target_file), 0777, true); // Create the directory if it doesn't exist
        }

        // Move the uploaded file to the target directory
        if (move_uploaded_file($_FILES['image']['tmp_name'], $target_file)) {
            // Append the image part to the query
            $query .= ", image='$image_path'";
        } else {
            echo json_encode(['message' => 'File upload failed']);
            return;
        }
    }

    // Complete the query with the WHERE clause
    $query .= " WHERE id='$id'";

    // Execute the query
    $result = mysqli_query($connection, $query);

    // Check if the query was successful
    if ($result) {
        echo json_encode(['message' => 'Data updated successfully']);
    } else {
        echo json_encode(['message' => 'Data failed to update', 'error' => mysqli_error($connection)]);
    }
} else {
    echo json_encode(['message' => 'Missing required data']);
}
?>

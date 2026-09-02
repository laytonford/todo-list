<?php

header("Content-Type: application/json");

$mysqli = new mysqli(
    "192.168.56.12",
    "user",
    "password",
    "todo"
);

if ($mysqli->connect_error) {
    http_response_code(500);
    echo json_encode(["error" => "Database connection failed"]);
    exit;
}

$method = $_SERVER["REQUEST_METHOD"];

// GET - return all tasks
if ($method === "GET") {

    $result = $mysqli->query(
        "SELECT * FROM tasks ORDER BY id"
    );

    $tasks = [];

    while ($row = $result->fetch_assoc()) {
        $row["completed"] = (bool)$row["completed"];
        $tasks[] = $row;
    }

    echo json_encode($tasks);
    exit;
}

// POST - add a new task
if ($method === "POST") {

    $data = json_decode(file_get_contents("php://input"), true);

    if (empty($data["description"])) {
        http_response_code(400);
        echo json_encode(["error" => "Description is required"]);
        exit;
    }

    $stmt = $mysqli->prepare(
        "INSERT INTO tasks (description, completed) VALUES (?, 0)"
    );

    $stmt->bind_param("s", $data["description"]);
    $stmt->execute();

    http_response_code(201);

    echo json_encode([
        "id" => $mysqli->insert_id,
        "description" => $data["description"],
        "completed" => false
    ]);

    exit;
}

// PUT - update whether a task is complete
if ($method === "PUT") {

    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data["id"]) || !isset($data["completed"])) {
        http_response_code(400);
        echo json_encode(["error" => "ID and completed are required"]);
        exit;
    }

    $id = (int)$data["id"];
    $completed = $data["completed"] ? 1 : 0;

    $stmt = $mysqli->prepare(
        "UPDATE tasks SET completed = ? WHERE id = ?"
    );

    $stmt->bind_param("ii", $completed, $id);
    $stmt->execute();

    echo json_encode(["message" => "Task updated"]);
    exit;
}

// DELETE - remove a task
if ($method === "DELETE") {

    $data = json_decode(file_get_contents("php://input"), true);

    if (!isset($data["id"])) {
        http_response_code(400);
        echo json_encode(["error" => "ID is required"]);
        exit;
    }

    $id = (int)$data["id"];

    $stmt = $mysqli->prepare(
        "DELETE FROM tasks WHERE id = ?"
    );

    $stmt->bind_param("i", $id);
    $stmt->execute();

    echo json_encode(["message" => "Task deleted"]);
    exit;
}

http_response_code(405);
echo json_encode(["error" => "Method not allowed"]);
<?php
error_reporting(E_ALL);
ini_set("display_errors", 1);
include "../settings/connection.php";

if (isset($_GET['DonorID']) && !empty($_GET['DonorID'])) {
    $DonorID = $_GET['DonorID'];
    $d_query = "DELETE FROM Donors WHERE DonorID = '$DonorID'";

    ob_start(); 
    echo "Debug: SQL query: $d_query<br>";
    $run = mysqli_query($conn, $d_query);

    if ($run) {
        header("Location:../admin/d_register_mgt.php");
    } else {
        echo "Error: " . mysqli_error($conn);
    }
    ob_end_flush(); 
} else {
    echo "Error: DonorID not provided or invalid.";
}

include "../actions/get_all_drives_action.php";
?>
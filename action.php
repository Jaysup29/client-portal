<?php 

    include('dbcon.php');

    $quantity = mysqli_real_escape_string($conn, $input["quantity"]);

    if($_POST['action'] == 'edit')
    {
        $data = array(
            ':items'=> $_POST['items'],
            ':uom'=> $_POST['uom'],
            ':quantity'=> $_POST['quantity'],
            ':expiry_date'=> $_POST['expiry_date']
        );

        $qty = $_POST['quantity'];
        $query = "UPDATE wms_inbound.tbl_receivingitemsummary SET Quantity = '$quantity' 
        WHERE ReceivingItemSummaryID = ".$input["id"]."";
        $statement = $connect->prepare($query);
        $statement->execute($data);

        echo json_encode($_POST);
    }

    if($_POST['action'] == 'delete')
    {
        echo 'Delete';
    }
    // include "dbcon.php";

    // $input = filter_input_array(INPUT_POST);

    // $quantity = mysqli_real_escape_string($conn, $input["quantity"]);
    // $expiry_date = mysqli_real_escape_string($conn, $input["expiry_date"]);

    // if($input["action"] === 'edit')
    // {
    //     $query = "UPDATE wms_inbound.tbl_receivingitemsummary 
    //     SET Quantity = '$quantity', ExpiryDate = '$expiry_date' 
    //     WHERE ReceivingItemSummaryID = ".$input["id"]."";

    //     if(mysqli_query($conn, $query))
    //     {
    //         echo "Edit Succes!";
    //     }
    //     else
    //     {
    //         echo $conn->error;
    //     }
    // }
    // if($input["action"] === 'delete')
    // {
    //     $query = "DELETE FROM wms_inbound.tbl_receivingitemsummary
    //     WHERE ReceivingItemSummaryID = ".$input["id"]."";

    //     if(mysqli_query($conn, $query))
    //     {
    //         echo "Delete Success!";
    //     }
    //     else
    //     {
    //         echo $conn->error;
    //     }
    // }
    // echo json_encode($input);
?>
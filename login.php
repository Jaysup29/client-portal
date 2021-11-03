<?php 
  session_start();
  if(isset($_SESSION["CustomerEmail"]))
  {
    header('Location: index.php');
  }


  if($_SERVER["REQUEST_METHOD"] == "POST")
  {
    $ue = $_POST['username'];
    // $password = $_POST['password'];

    include 'dbcon.php';
    $query = "SELECT CustomerId, CustomerEmail, CompanyName FROM wms_cloud.tbl_customers WHERE CustomerEmail = '$ue'";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) == 1)
    {
      while($row = mysqli_fetch_assoc($result))
      {

        $_SESSION["CustomerEmail"] = $row['CustomerEmail'];
        $_SESSION["CompanyName"] = $row['CompanyName'];
        $_SESSION["CustomerId"] = $row['CustomerId'];
        $_SESSION["loggedin"] = true;

        header('Location: index.php');
      }
    }
    else
    {
      echo "<script type='text/javascript'>alert('Please check Username/Email and Password if correct.');</script>";
    }
  }
 ?>

<!doctype html>
    <html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./dist/css/styles2.css">
        <link rel="stylesheet" href="./node_modules/bootstrap/dist/css/bootstrap.min.css">
        <title>Login</title>
    </head>
    <body>
        <div class="container vh-100 d-flex justify-content-center align-items-center">
            <div class="card border-0 shadow-lg">
                <div class="card-body">
                    <div class="card-title">
                        <h3 class="text-center mb-5">Login</h3>
                    </div>
                    <div class="card-body p-0">
                        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post" class="w-100">
                            <div class="mb-3">
                              <input type="text" class="form-control border shadow-sm" name="username" placeholder="Username">
                            </div>
                            <div class="mb-1">
                                <input type="password" class="form-control border shadow-sm" id="password" placeholder="Password">
                            </div>
                            <div class="mb-1">
                                <label for="formFile" class="form-label fw-lighter text-muted"><a href="#" class="text-decoration-none">Forget Password?</a>
                                </label>
                            </div>
                            <div class="float-end">
                                <button class="btn btn-primary">Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script scr="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    </body>
    </html>


<!doctype html>
    <html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./dist/css/styles2.css">
        <link rel="stylesheet" href="./node_modules/bootstrap/dist/css/bootstrap.min.css">
        <script src="plugins/jquery/jquery.min.js"></script>
        <title>Login</title>
    </head>
    <body>
        <div class="container vh-100 d-flex justify-content-center align-items-center">
            <div class="card border-0 shadow-lg px-3 py-4">
                <div class="card-body">
                    <div class="card-title">
                        <h3 class="text-center mb-5">Login</h3>
                    </div>
                    <div class="card-body p-0">
                          <div class="mb-3">
                            <input type="text" class="form-control border shadow-sm" name="username" placeholder="Email" id="username">
                          </div>
                          <div class="mb-1">
                              <input type="password" class="form-control border shadow-sm" id="userpword" placeholder="Password">
                          </div>
                          <div class="mb-1">
                              <label for="formFile" class="form-label fw-lighter text-muted"><a href="#" class="text-decoration-none">Forget Password?</a>
                              </label>
                          </div>
                          <div class="float-end">
                            <button class="btn btn-primary" id="loginbtn" onClick="login()">Login</button>
                          </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script scr="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="script.js"></script>

    </body>
    </html>
    <script>

    $("#username").keyup(function(event) {
        if (event.which === 13) {
            $("#loginbtn").click();
        }
    });
    </script>


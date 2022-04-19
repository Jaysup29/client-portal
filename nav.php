<?php 
  $userid = $_SESSION['UserID'];

  include 'dbcon.php';

  $query = "SELECT CommonCode, role_id FROM tbl_customers_users WHERE id = '$userid'";
  $result = mysqli_query($conn, $query);
  if(mysqli_num_rows($result) == 1)
  {
    while($row = mysqli_fetch_assoc($result))
    {
      $commoncode = $row['CommonCode'];
      $role_id = $row['role_id'];
    }

    $query = "SELECT CustomerID FROM tbl_customers WHERE CustomerCommonCode = '$commoncode'";
    $result = mysqli_query($conn, $query);
    if(mysqli_num_rows($result) > 0)
    {
      while($row = mysqli_fetch_assoc($result))
      {
        $CustomerID = $row['CustomerID'];
      }

      if($role_id == 0)
      {
        echo '
          <nav>
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
              <li class="nav-item menu">
                <a href="#" class="nav-link active">
                  <i class="nav-icon fas fa-tachometer-alt"></i>
                  <p>
                    Masterlist
                    <i class="right fas fa-angle-left"></i>
                  </p>
                </a>
                <ul class="nav nav-treeview">
                  <li class="nav-item">
                    <a href="master_userlist.php" class="nav-link">
                      <i class="nav-icon fas fa-sign-out-alt"></i>
                      <p id="label">
                        Users
                      </p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="master_itemlist.php" class="nav-link">
                      <i class="nav-icon fas fa-sign-out-alt"></i>
                      <p id="label">
                        Items
                      </p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="master_storelist.php" class="nav-link">
                      <i class="nav-icon fas fa-sign-out-alt"></i>
                      <p id="label">
                        Stores
                      </p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="nav-item mb-2">
              <a href="logout.php" class="nav-link">
                <i class="nav-icon fas fa-sign-out-alt"></i>
                <p id="label">
                  Logout
                </p>
              </a>
            </li>
            </ul>
          </nav>
        ';
      }
      else
      {
        echo '
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <li class="nav-item mb-2">
              <a href="index.php" class="nav-link">
                <i class="nav-icon fas fa-columns"></i>
                  <p id="label">Dashboard</p>
              </a>
            </li>
            <li class="nav-item mb-2">
              <a href="receiving.php" class="nav-link">
                <i class="nav-icon fas fa-inbox"></i>
                <p id="label">Receiving</p>
              </a>
            </li>
            <li class="nav-item mb-2">
              <a href="order.php" class="nav-link">
                <i class="nav-icon fas fa-dice-d6"></i>
                <p id="label">
                  Orders
                </p>
              </a>
            </li>
            <li class="nav-item mb-2">
              <a href="stockonhand_reports.php" class="nav-link">
                <i class="nav-icon fas fa-file-alt"></i>
                <p id="label">
                  Reports
                </p>
              </a>
            </li>
            <li class="nav-item mb-2">
              <a href="settings.php" class="nav-link">
                <i class="nav-icon fas fa-cog"></i>
                <p id="label">
                  Settings
                </p>
              </a>
            </li>
            <li class="nav-item mb-2">
              <a href="logout.php" class="nav-link">
                <i class="nav-icon fas fa-sign-out-alt"></i>
                <p id="label">
                  Logout
                </p>
              </a>
            </li>
            </ul>
        </nav>
        ';
      }
    }
    else
    {
echo '
          <nav>
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
              <li class="nav-item menu">
                <a href="#" class="nav-link active">
                  <i class="nav-icon fas fa-tachometer-alt"></i>
                  <p>
                    Masterlist
                    <i class="right fas fa-angle-left"></i>
                  </p>
                </a>
                <ul class="nav nav-treeview">
                  <li class="nav-item">
                    <a href="master_userlist.php" class="nav-link">
                      <i class="nav-icon fas fa-sign-out-alt"></i>
                      <p id="label">
                        Users
                      </p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="master_itemlist.php" class="nav-link">
                      <i class="nav-icon fas fa-sign-out-alt"></i>
                      <p id="label">
                        Items
                      </p>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a href="master_storelist.php" class="nav-link">
                      <i class="nav-icon fas fa-sign-out-alt"></i>
                      <p id="label">
                        Stores
                      </p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="nav-item mb-2">
              <a href="logout.php" class="nav-link">
                <i class="nav-icon fas fa-sign-out-alt"></i>
                <p id="label">
                  Logout
                </p>
              </a>
            </li>
            </ul>
          </nav>
        ';
    }
  }

?>


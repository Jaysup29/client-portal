<?php

else if($dataBarGraph == 'Total Weight')
        {
            $query = "SELECT
                      SUM(wms_inbound.tbl_receivingitems.Weight)
                  FROM wms_inbound.tbl_receivingitems
                  LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                  LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                  WHERE CusID = $CustomerID AND ExpiryDate < CURDATE()
                  ";

            $res = mysqli_query($conn, $query);

            while($rows = mysqli_fetch_array($res))
            {   
                // $wgt = number_format((float)$rows[0], 2);
                $expired = round($rows[0], 0);
            }

            $query = "SELECT
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessTwo'
                    ";

            $res = mysqli_query($conn, $query);

            while($rows = mysqli_fetch_array($res))
            {   
                // $wgt = number_format((float)$rows[0], 2);
                $lTwo = round($rows[0], 0);
            }


            $query = "SELECT
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessFour'
                    ";

            $res = mysqli_query($conn, $query);

            while($rows = mysqli_fetch_array($res))
            {   
                // $wgt = number_format((float)$rows[0], 2);
                $lFour = round($rows[0], 0);
            }


            $query = "SELECT
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    WHERE CusID = $CustomerID AND ExpiryDate BETWEEN CURDATE() AND '$lessSix'
                    ";

            $res = mysqli_query($conn, $query);

            while($rows = mysqli_fetch_array($res))
            {   
                // $wgt = number_format((float)$rows[0], 2);
                $lSix = round($rows[0], 0);
            }

            $query = "SELECT
                        SUM(wms_inbound.tbl_receivingitems.Weight)
                    FROM wms_inbound.tbl_receivingitems
                    LEFT JOIN wms_inbound.tbl_receiving on wms_inbound.tbl_receivingitems.IBN = wms_inbound.tbl_receiving.IBN
                    LEFT JOIN wms_cloud.tbl_items on wms_inbound.tbl_receivingitems.ItemID = wms_cloud.tbl_items.ItemID
                    WHERE CusID = $CustomerID AND ExpiryDate BETWEEN '$lessSix' AND '2060-01-01'
                    ";

            $res = mysqli_query($conn, $query);

            while($rows = mysqli_fetch_array($res))
            {   
                // $wgt = number_format((float)$rows[0], 2);
                $mSix = round($rows[0], 0);
            }

            $total = 0;
            $total = $expired + $lTwo + $lFour + $lSix + $mSix;

            $data[] = array( $expired, $lTwo, $lFour, $lSix, $mSix);

            echo json_encode($data);

        }

?>
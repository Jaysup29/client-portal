<section class="content mx-2">
    <ul class="nav nav-tabs">
      <li class="nav-item">
        <a class="nav-link 
        <?php
        if($page_content == 'stockonhand_reports_content.php')
        {
            echo 'active';
        }
        ?>
        " href="stockonhand_reports.php#">Stock On Hand</a>
    </li>

    <li class="nav-item">
        <a class="nav-link
        <?php
        if($page_content == 'ageing_reports_content.php')
        {
            echo 'active';
        }
        ?>
        " href="ageing_reports.php">Ageing</a>
    </li>

    <li class="nav-item">
        <a class="nav-link
        <?php
        if($page_content == 'goodsmovement_report_content.php')
        {
            echo 'active';
        }
        ?>
        " href="goodsmovement_report.php">Goods Movement</a>
    </li>

    <li class="nav-item">
        <a class="nav-link
        <?php
        if($page_content == 'dailytransaction_reports_content.php')
        {
            echo 'active';
        }
        ?>
        " href="dailytransaction_reports.php">Daily Transaction</a>
    </li>

    <li class="nav-item">
        <a class="nav-link
        <?php
        if($page_content == 'inboundtransaction_reports_content.php')
        {
            echo 'active';
        }
        ?>
        " href="inboundtransaction_reports.php">Inbound Transaction</a>
    </li>

<!--     <li class="nav-item">
        <a class="nav-link
        <?php
        if($page_content == 'outboundtransaction_reports_content.php')
        {
            echo 'active';
        }
        ?>
        " href="outboundtransaction_reports.php">Outbound Transaction</a>
    </li> -->

    <li class="nav-item">
        <a class="nav-link
        <?php
        if($page_content == 'outboundtransaction_reports_content2.php')
        {
            echo 'active';
        }
        ?>
        " href="outboundtransaction_reports2.php">Outbound Transaction</a>
    </li>



</ul>
<div class="btn-group w-100" id="smallescreendropdown">
  <button type="button" class="btn btn-secondary dropdown-toggle mb-2" data-toggle="dropdown" data-bs-display="static" aria-expanded="false">
    Reports
</button>
<ul class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start" id="dropdownitems">
  <li class="nav-item">
    <a class="nav-link text-decoration-none text-dark 
    <?php
    if($page_content == 'stockonhand_reports_content.php')
    {
        echo 'active';
    }
    ?>
    " href="stockonhand_reports.php#">Stock On Hand</a>
</li>

<li class="nav-item">
    <a class="nav-link text-decoration-none text-dark
    <?php
    if($page_content == 'ageing_reports_content.php')
    {
        echo 'active';
    }
    ?>
    " href="ageing_reports.php">Ageing</a>
</li>

<li class="nav-item">
    <a class="nav-link text-decoration-none text-dark
    <?php
    if($page_content == 'goodsmovement_report_content.php')
    {
        echo 'active';
    }
    ?>
    " href="goodsmovement_report.php">Goods Movement</a>
</li>

<li class="nav-item">
    <a class="nav-link text-decoration-none text-dark
    <?php
    if($page_content == 'dailytransaction_reports_content.php')
    {
        echo 'active';
    }
    ?>
    " href="dailytransaction_reports.php">Daily Transaction</a>
</li>


<li class="nav-item">
    <a class="nav-link text-decoration-none text-dark
    <?php
    if($page_content == 'inboundtransaction_reports_content.php')
    {
        echo 'active';
    }
    ?>
    " href="inboundtransaction_reports.php">Inbound Transaction</a>
</li>

<!-- <li class="nav-item">
    <a class="nav-link text-decoration-none text-dark
    <?php
    if($page_content == 'outboundtransaction_reports_content.php')
    {
        echo 'active';
    }
    ?>
    " href="outboundtransaction_reports.php">Outbound Transaction</a>
</li>  -->

<li class="nav-item">
    <a class="nav-link text-decoration-none text-dark
    <?php
    if($page_content == 'outboundtransaction_reports_content2.php')
    {
        echo 'active';
    }
    ?>
    " href="outboundtransaction_reports2.php">Outbound Transaction</a>
</li> 
</li>

</ul>
</div>
</section>

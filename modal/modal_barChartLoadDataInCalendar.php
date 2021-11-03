<style type="text/css">
    .fc-title{color:white }
    .fc-time{color:white }

    .view-calendar{
         display: flex;
         font-size: 15px;
         margin-bottom: 15px;
    }

</style>
<div class="modal fade" id="view_bargraph_incalendar" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLongTitle"></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="view-calendar" style="padding:10px;">
          <div id="calendar"></div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>



<div class="modal fade" id="view_details_itr" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="exampleModalLongTitle">View Details</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table id="itr_details" class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>Date</th>
							<th>Control Number</th>

							<th>Client SKU</th>
							<th>Item Description</th>

							<!-- <th>JO Number</th> -->
							<th>Quantity</th>
							<th>Weight</th>

							<th>Item Status</th>

							<th>CV Number</th>
							<!-- <th>Checker Assigned</th> -->

							<th>Status</th>
							<th>Remarks</th>
						</tr>
					</thead>
					<tbody id="itr_body">

					</tbody>

					<tfoot><tr>
						<td></td>
						<td></td>

						<td></td>
						<td></td>

						<td style="color:red; font-weight: bold;">Total</td>
						<td style="color:red; font-weight: bold;" id="quantity"></td>

						<td style="color:red; font-weight: bold;" id="weight"></td>
						<td></td>

						<td></td>
						<td></td>
					</tr></tfoot>

				</table>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>


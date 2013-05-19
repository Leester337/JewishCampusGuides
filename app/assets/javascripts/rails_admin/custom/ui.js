function get_organizations(college_id)
{
	jQuery.ajax({
		url: "/find/organization_by_college",
		type: "GET",
		data: {'college_id' : college_id},
		success: function(data) {
			$('#organization').html(data);
		}
	});
}
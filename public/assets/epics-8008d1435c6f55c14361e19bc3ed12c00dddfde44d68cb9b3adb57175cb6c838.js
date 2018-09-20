$(document).on('turbolinks:load',function()
{
$('#epics').DataTable();
$PaginationType: "full_numbers"
bJQueryUI: true
bProcessing: true
bServerSide: true
$AjaxSource: $('#epics').data('source')
});
